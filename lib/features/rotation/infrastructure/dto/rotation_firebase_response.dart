// Firebase Cloud Firestore <=> DTO <=> Entity 変換するDTOクラス
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/entities/skip_event.dart';
import 'package:popcal/features/rotation/domain/enums/skip_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';

part 'rotation_firebase_response.freezed.dart';

@freezed
sealed class RotationFirebaseResponse with _$RotationFirebaseResponse {
  const factory RotationFirebaseResponse({
    required RotationId? rotationId,
    required UserId userId,
    required RotationName rotationName,
    required List<RotationMemberName> rotationMemberNames,
    required List<int> rotationDays,
    required NotificationTime notificationTime,
    required RotationIndex currentRotationIndex,
    // firestoreに保存する際はTimestampが適切
    // Widget(UI)はDateTimeが適切
    required RotationCreatedAt createdAt,
    required RotationUpdatedAt updatedAt,
    required List<SkipEvent> skipEvents,
  }) = _RotationFirebaseResponse;
  // Entity => DTO (factory method)
  factory RotationFirebaseResponse.fromEntity(Rotation entity) {
    return RotationFirebaseResponse(
      rotationId: entity.rotationId,
      userId: entity.userId,
      rotationName: entity.rotationName,
      rotationMemberNames: entity.rotationMemberNames,
      rotationDays:
          entity.rotationDays.map((weekday) => weekday.value).toList(),
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

    return RotationFirebaseResponse(
      rotationId: RotationId(snapshot.id),
      userId: UserId(data['userId'] as String),
      rotationName: RotationName(data['rotationName'] as String),
      rotationMemberNames: _parseRotationMembers(data['rotationMemberNames']),
      // ignore: avoid-dynamic
      rotationDays: List<int>.from(data['rotationDays'] as List<dynamic>),
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
      rotationDays: rotationDays.map(Weekday.fromInt).toList(),
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
      'rotationDays': rotationDays,
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
  static List<RotationMemberName> _parseRotationMembers(dynamic data) {
    if (data == null) return [];

    if (data is! List) {
      throw FormatException(
        'rotationMemberNames must be a List, got ${data.runtimeType}',
      );
    }

    return data.whereType<String>().map(RotationMemberName.new).toList();
  }

  // ignore: avoid-dynamic
  static List<SkipEvent> _parseSkipEvents(dynamic data) {
    if (data == null) return [];

    if (data is! List) {
      throw FormatException(
        'skipEvents must be a List, got ${data.runtimeType}',
      );
    }

    return data.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('SkipEvent item must be a Map');
      }

      final timestamp = item['date'] as Timestamp;
      final typeString = item['type'] as String;
      final skipCount = (item['skipCount'] ?? 1) as int;

      final type = SkipType.values.firstWhere(
        (e) => e.name == typeString,
        orElse: () => throw FormatException('Invalid SkipType: $typeString'),
      );

      return SkipEvent(
        date: DateKey.fromDateTime(timestamp.toDate()),
        type: type,
        skipCount: SkipCount(skipCount: skipCount),
      );
    }).toList();
  }

  static List<Map<String, dynamic>> _skipEventsToFirestore(
    List<SkipEvent> skipEvents,
  ) {
    return skipEvents
        .map(
          (event) => {
            'date': Timestamp.fromDate(event.date.value),
            'type': event.type.name,
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
