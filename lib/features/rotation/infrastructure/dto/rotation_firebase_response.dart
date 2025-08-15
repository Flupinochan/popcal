import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

part 'rotation_firebase_response.freezed.dart';

@freezed
sealed class RotationFirebaseResponse with _$RotationFirebaseResponse {
  const factory RotationFirebaseResponse({
    required RotationId? rotationId,
    required UserId userId,
    required RotationName rotationName,
    required RotationMemberNames rotationMemberNames,
    required RotationDays rotationDays,
    required NotificationTime notificationTime,
    required RotationIndex currentRotationIndex,
    // firestoreに保存する際はTimestampが適切
    // Widget(UI)はDateTimeが適切
    required RotationCreatedAt createdAt,
    required RotationUpdatedAt updatedAt,
    required SkipEvents skipEvents,
  }) = _RotationFirebaseResponse;
  // Entity => DTO (factory method)
  factory RotationFirebaseResponse.fromEntity(Rotation entity) {
    return RotationFirebaseResponse(
      rotationId: entity.rotationId,
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMemberNames: entity.rotationMemberNames,
      rotationDays: entity.rotationDays,
      notificationTime: entity.notificationTime,
      currentRotationIndex: entity.currentRotationIndex,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      skipEvents: entity.skipEvents,
    );
  }

  // Firestore => DTO (factory method)
  // ※Firestore カスタムオブジェクトを参照
  // https://firebase.google.com/docs/firestore/query-data/get-data?hl=ja#dart_4
  factory RotationFirebaseResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    final data = snapshot.data()!;
    final createdAt = data['createdAt'] as Timestamp;
    final updatedAt = data['updatedAt'] as Timestamp;
    final rotationIndex = RotationIndex.create(
      data['currentRotationIndex'] as int,
    );
    final notificationTime = _mapToTimeOfDay(
      data['notificationTime'] as Map<String, dynamic>,
    );

    if (rotationIndex.isFailure) {
      throw FormatException(
        'currentRotationIndex is invalid: ${data['currentRotationIndex']}',
      );
    }

    final rotationMemberNamesResult = _parseRotationMembers(
      data['rotationMemberNames'],
    );
    if (rotationMemberNamesResult.isFailure) {
      throw FormatException(
        'rotationMemberNames is invalid: ${data['rotationMemberNames']}',
      );
    }

    final rotationDaysResult = RotationDays.createFromDynamic(
      // ignore: avoid-dynamic
      data['rotationDays'] as List<dynamic>,
    );
    if (rotationDaysResult.isFailure) {
      throw FormatException(
        'rotationDays is invalid: ${data['rotationDays']}',
      );
    }

    return RotationFirebaseResponse(
      rotationId: RotationId(snapshot.id),
      userId: UserId(data['userId'] as String),
      rotationName: RotationName(data['rotationName'] as String),
      rotationMemberNames: rotationMemberNamesResult.valueOrNull!,
      rotationDays: rotationDaysResult.valueOrNull!,
      notificationTime: NotificationTime(notificationTime),
      currentRotationIndex: rotationIndex.valueOrNull!,
      createdAt: RotationCreatedAt(createdAt.toDate()),
      updatedAt: RotationUpdatedAt(updatedAt.toDate()),
      skipEvents: _parseSkipEvents(data['skipEvents']),
    );
  }

  const RotationFirebaseResponse._();

  // DTO => Entity (instance method)
  Rotation toEntity() {
    return Rotation(
      rotationId: rotationId,
      userId: userId,
      rotationName: rotationName,
      rotationMemberNames: rotationMemberNames,
      rotationDays: rotationDays,
      notificationTime: notificationTime,
      currentRotationIndex: currentRotationIndex,
      createdAt: createdAt,
      updatedAt: updatedAt,
      skipEvents: skipEvents,
    );
  }

  // DTO => Firestore (instance method)
  // Security Ruleでバリデーションされている
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId.value,
      'rotationName': rotationName.value,
      'rotationMemberNames':
          rotationMemberNames.map((member) => member.value).toList(),
      'rotationDays': rotationDays.toIntList(),
      'notificationTime': _timeOfDayToMap(notificationTime.value),
      'currentRotationIndex': currentRotationIndex.value,
      'createdAt': Timestamp.fromDate(createdAt.value),
      'updatedAt': Timestamp.fromDate(updatedAt.value),
      'skipEvents': _skipEventsToFirestore(skipEvents),
    };
  }

  // Map => TimeOfDay ※firebaseでは値はdynamic判定
  static TimeOfDay _mapToTimeOfDay(Map<String, dynamic> map) {
    return TimeOfDay(
      hour: (map['hour'] ?? 0) as int,
      minute: (map['minute'] ?? 0) as int,
    );
  }

  // ignore: avoid-dynamic
  static Result<RotationMemberNames> _parseRotationMembers(dynamic data) {
    if (data is! List) {
      throw FormatException(
        'rotationMemberNames must be a List, got ${data.runtimeType}',
      );
    }

    final memberNames = data.whereType<String>().toList();
    return RotationMemberNames.create(memberNames);
  }

  // ignore: avoid-dynamic
  static SkipEvents _parseSkipEvents(dynamic data) {
    if (data == null) return const SkipEvents([]);

    if (data is! List) {
      throw FormatException(
        'skipEvents must be a List, got ${data.runtimeType}',
      );
    }

    final skipEventsList =
        data.map((item) {
          if (item is! Map<String, dynamic>) {
            throw const FormatException('SkipEvent item must be a Map');
          }

          final timestamp = item['date'] as Timestamp;
          final typeString = item['type'] as String;
          final skipCount = (item['skipCount'] ?? 1) as int;

          final type = DayType.values.firstWhere(
            (e) => e.name == typeString,
            orElse:
                () => throw FormatException('Invalid SkipType: $typeString'),
          );

          final dateKeyResult = DateKey.create(timestamp.toDate());
          if (dateKeyResult.isFailure) {
            throw FormatException(
              'Invalid dateKey: ${timestamp.toDate()}',
            );
          }

          return SkipEvent(
            dateKey: dateKeyResult.valueOrNull!,
            dayType: type,
            skipCount: SkipCount(skipCount: skipCount),
          );
        }).toList();

    return SkipEvents(skipEventsList);
  }

  static List<Map<String, dynamic>> _skipEventsToFirestore(
    SkipEvents skipEvents,
  ) {
    return skipEvents.value
        .map(
          (event) => {
            'date': Timestamp.fromDate(event.dateKey.value),
            'type': event.dayType.name,
            'skipCount': event.skipCount.skipCount,
          },
        )
        .toList();
  }

  // TimeOfDay => Map 変換 ※FirebaseにはTimeOfDay型がないためMapで保存
  static Map<String, int> _timeOfDayToMap(TimeOfDay timeOfDay) {
    return {'hour': timeOfDay.hour, 'minute': timeOfDay.minute};
  }
}
