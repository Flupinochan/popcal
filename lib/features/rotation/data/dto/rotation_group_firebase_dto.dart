// Firebase Cloud Firestore <=> DTO <=> Entity 変換するDTOクラス
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'rotation_group_firebase_dto.freezed.dart';

@freezed
sealed class RotationGroupFirebaseDto with _$RotationGroupFirebaseDto {
  const RotationGroupFirebaseDto._();

  const factory RotationGroupFirebaseDto({
    required String? rotationGroupId,
    required String ownerUserId,
    required String rotationName,
    required List<String> rotationMembers,
    required List<int> rotationDays,
    required Map<String, int> notificationTime,
    required int currentRotationIndex,
    // firestoreに保存する際はTimestampが適切
    // Widget(UI)はDateTimeが適切
    required Timestamp lastScheduledDate,
    required Timestamp rotationStartDate,
    required Timestamp updatedAt,
  }) = _RotationGroupFirebaseDto;

  // Entity => DTO (factory method)
  factory RotationGroupFirebaseDto.fromEntity(RotationGroup entity) {
    return RotationGroupFirebaseDto(
      rotationGroupId:
          entity.rotationGroupId?.isNotEmpty == true
              ? entity.rotationGroupId
              : null,
      ownerUserId: entity.userId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      rotationDays:
          entity.rotationDays.map((weekday) => weekday.value).toList(),
      notificationTime: _timeOfDayToMap(entity.notificationTime),
      currentRotationIndex: entity.currentRotationIndex,
      lastScheduledDate: Timestamp.fromDate(entity.lastScheduledDate),
      rotationStartDate: Timestamp.fromDate(entity.createdAt),
      updatedAt: Timestamp.fromDate(entity.updatedAt),
    );
  }

  // Firestore => DTO (factory method)
  // ※Firestore カスタムオブジェクトを参照
  // https://firebase.google.com/docs/firestore/query-data/get-data?hl=ja#dart_4
  factory RotationGroupFirebaseDto.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RotationGroupFirebaseDto(
      rotationGroupId: snapshot.id,
      ownerUserId: data['ownerUserId'] as String,
      rotationName: data['rotationName'] as String,
      rotationMembers: List<String>.from(
        data['rotationMembers'] as List<dynamic>,
      ),
      rotationDays: List<int>.from(data['rotationDays'] as List<dynamic>),
      notificationTime: Map<String, int>.from(
        data['notificationTime'] as Map<String, dynamic>,
      ),
      currentRotationIndex: data['currentRotationIndex'] as int,
      lastScheduledDate: data['lastScheduledDate'] as Timestamp,
      rotationStartDate: data['rotationStartDate'] as Timestamp,
      updatedAt: data['updatedAt'] as Timestamp,
    );
  }

  // DTO => Entity (instance method)
  RotationGroup toEntity() {
    return RotationGroup(
      rotationGroupId: rotationGroupId,
      userId: ownerUserId,
      rotationName: rotationName,
      rotationMembers: rotationMembers,
      rotationDays:
          rotationDays.map((value) => Weekday.fromInt(value)).toList(),
      notificationTime: _mapToTimeOfDay(notificationTime),
      currentRotationIndex: currentRotationIndex,
      lastScheduledDate: lastScheduledDate.toDate(),
      createdAt: rotationStartDate.toDate(),
      updatedAt: updatedAt.toDate(),
    );
  }

  // DTO => Firestore (instance method)
  Map<String, dynamic> toFirestore() {
    return {
      'ownerUserId': ownerUserId,
      'rotationName': rotationName,
      'rotationMembers': rotationMembers,
      'rotationDays': rotationDays,
      'notificationTime': notificationTime,
      'currentRotationIndex': currentRotationIndex,
      'lastScheduledDate': lastScheduledDate,
      'rotationStartDate': rotationStartDate,
      'updatedAt': updatedAt,
    };
  }

  // TimeOfDay => Map 変換 ※FirebaseにはTimeOfDay型がないため
  static Map<String, int> _timeOfDayToMap(TimeOfDay timeOfDay) {
    return {'hour': timeOfDay.hour, 'minute': timeOfDay.minute};
  }

  // Map => TimeOfDay
  static TimeOfDay _mapToTimeOfDay(Map<String, int> map) {
    return TimeOfDay(hour: map['hour'] ?? 0, minute: map['minute'] ?? 0);
  }
}
