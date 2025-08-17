// ignore_for_file: avoid-dynamic

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_of_day_extention.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';
import 'package:popcal/features/rotation/infrastructure/dto/create_rotation_firebase_request.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_firebase_response.dart';
import 'package:popcal/features/rotation/infrastructure/dto/update_rotation_firebase_request.dart';

part 'rotation_firebase_mapper.freezed.dart';

@freezed
sealed class RotationFirebaseMapper with _$RotationFirebaseMapper {
  const factory RotationFirebaseMapper({
    required String rotationId,
    required String userId,
    required String rotationName,
    required List<String> rotationMemberNames,
    required List<Weekday> rotationDays,
    required TimeOfDay notificationTime,
    required int currentRotationIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SkipEvents skipEvents,
  }) = _RotationFirebaseMapper;

  const RotationFirebaseMapper._();

  // Mapper=>DTO
  RotationFirebaseResponse toDto() {
    return RotationFirebaseResponse(
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

  // Firestore=>Mapper
  // Security Ruleでバリデーションされているため注意
  // List<Weekday>はList<int>で保存
  // TimeOfDayとDateTimeはTimestampで保存
  // firestoreにおける時刻は独自のTimestamp使用
  // Widgetはdart標準のDateTimeを使用
  Map<String, dynamic> toFirestore() {
    return {
      'rotationId': rotationId,
      'userId': userId,
      'rotationName': rotationName,
      'rotationMemberNames': rotationMemberNames,
      'rotationDays': rotationDays.map((weekday) => weekday.value).toList(),
      'notificationTime': notificationTime.toTimestamp(),
      'currentRotationIndex': currentRotationIndex,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'skipEvents': _skipEventsToFirestore(skipEvents),
    };
  }

  static Result<RotationFirebaseMapper> fromCreateDto(
    CreateRotationFirebaseRequest dto,
  ) {
    // DtoでrotationIdをnullチェックしているため不要
    return Results.success(
      RotationFirebaseMapper(
        rotationId: dto.rotationId!,
        userId: dto.userId,
        rotationName: dto.rotationName,
        rotationMemberNames: dto.rotationMemberNames,
        rotationDays: dto.rotationDays,
        notificationTime: dto.notificationTime,
        currentRotationIndex: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        skipEvents: dto.skipEvents,
      ),
    );
  }

  // Mapper=>Firestore
  // withConverter用：Resultは使用せずエラーをスロー
  // 1. Firestoreからのレスポンスは全てOptionalでnullチェック
  // 2. ListやMapは値がdynamicのためList<String>、List<int>に変換
  // 3. TimestampはDateTime or TimeOfDayに変換
  static RotationFirebaseMapper fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final data = snapshot.data();
      if (data == null) {
        throw Exception('Document data is null');
      }

      final rotationId = data['rotationId'] as String?;
      if (rotationId == null) {
        throw Exception('rotationId is required');
      }

      final userId = data['userId'] as String?;
      if (userId == null) {
        throw Exception('userId is required');
      }

      final rotationName = data['rotationName'] as String?;
      if (rotationName == null) {
        throw Exception('rotationName is required');
      }

      final rotationMemberNames =
          (data['rotationMemberNames'] as List<dynamic>?)?.cast<String>() ?? [];

      final rotationDaysInt =
          (data['rotationDays'] as List<dynamic>?)?.cast<int>() ?? [];
      final rotationDays = rotationDaysInt.map(Weekday.fromInt).toList();

      final notificationTimeTimestamp = data['notificationTime'] as Timestamp?;
      if (notificationTimeTimestamp == null) {
        throw Exception('notificationTime is required');
      }
      final notificationTime = notificationTimeTimestamp.toTimeOfDay();

      final currentRotationIndex = data['currentRotationIndex'] as int? ?? 0;

      final createdAtTimestamp = data['createdAt'] as Timestamp?;
      if (createdAtTimestamp == null) {
        throw Exception('createdAt is required');
      }
      final createdAt = createdAtTimestamp.toDate();

      final updatedAtTimestamp = data['updatedAt'] as Timestamp?;
      if (updatedAtTimestamp == null) {
        throw Exception('updatedAt is required');
      }
      final updatedAt = updatedAtTimestamp.toDate();

      final skipEvents = _parseSkipEvents(data['skipEvents']);

      return RotationFirebaseMapper(
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
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Failed to parse Firestore data: $e'),
        stackTrace,
      );
    }
  }

  // DTO=>Mapper
  static Result<RotationFirebaseMapper> fromUpdateDto(
    UpdateRotationFirebaseRequest dto,
  ) {
    return Results.success(
      RotationFirebaseMapper(
        rotationId: dto.rotationId,
        userId: dto.userId,
        rotationName: dto.rotationName,
        rotationMemberNames: dto.rotationMemberNames,
        rotationDays: dto.rotationDays,
        notificationTime: dto.notificationTime,
        currentRotationIndex: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        skipEvents: dto.skipEvents,
      ),
    );
  }

  static SkipEvents _parseSkipEvents(dynamic data) {
    if (data == null) return const SkipEvents([]);
    if (data is! List) return const SkipEvents([]);

    final skipEventsList =
        data
            .whereType<Map<String, dynamic>>()
            .map((item) {
              final timestamp = item['dateKey'] as Timestamp?;
              final typeString = item['dayType'] as String?;
              final skipCount = item['skipCount'] as int?;

              if (timestamp == null ||
                  typeString == null ||
                  skipCount == null) {
                return null;
              }

              final type = DayType.fromString(typeString);
              if (type == null) return null;

              final dateKeyResult = DateKey.create(timestamp.toDate());
              if (dateKeyResult.isFailure) return null;

              return SkipEvent(
                dateKey: dateKeyResult.valueOrNull!,
                dayType: type,
                skipCount: SkipCount(skipCount: skipCount),
              );
            })
            .whereType<SkipEvent>()
            .toList();

    return SkipEvents(skipEventsList);
  }

  static List<Map<String, dynamic>> _skipEventsToFirestore(
    SkipEvents skipEvents,
  ) {
    return skipEvents.value
        .map(
          (event) => {
            'dateKey': Timestamp.fromDate(event.dateKey.value),
            'dayType': event.dayType.name,
            'skipCount': event.skipCount.skipCount,
          },
        )
        .toList();
  }
}
