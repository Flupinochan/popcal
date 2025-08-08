// Firebase Cloud Firestore <=> DTO <=> Entity 変換するDTOクラス
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

part 'rotation_firebase_response.freezed.dart';

@freezed
sealed class RotationFirebaseResponse with _$RotationFirebaseResponse {
  const RotationFirebaseResponse._();

  const factory RotationFirebaseResponse({
    required RotationId? rotationId,
    required UserId userId,
    required RotationName rotationName,
    required List<RotationMemberName> rotationMemberNames,
    required List<int> rotationDays,
    required Map<String, int> notificationTime,
    required int currentRotationIndex,
    // firestoreに保存する際はTimestampが適切
    // Widget(UI)はDateTimeが適切
    required Timestamp createdAt,
    required Timestamp updatedAt,
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
      notificationTime: _timeOfDayToMap(entity.notificationTime),
      currentRotationIndex: entity.currentRotationIndex,
      createdAt: Timestamp.fromDate(entity.createdAt),
      updatedAt: Timestamp.fromDate(entity.updatedAt),
    );
  }

  // Firestore => DTO (factory method)
  // ※Firestore カスタムオブジェクトを参照
  // https://firebase.google.com/docs/firestore/query-data/get-data?hl=ja#dart_4
  factory RotationFirebaseResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RotationFirebaseResponse(
      rotationId: RotationId(snapshot.id),
      userId: UserId(data['userId'] as String),
      rotationName: RotationName(data['rotationName'] as String),
      rotationMemberNames: _parseRotationMembers(data['rotationMemberNames']),
      rotationDays: List<int>.from(data['rotationDays'] as List<dynamic>),
      notificationTime: Map<String, int>.from(
        data['notificationTime'] as Map<String, dynamic>,
      ),
      currentRotationIndex: data['currentRotationIndex'] as int,
      createdAt: data['createdAt'] as Timestamp,
      updatedAt: data['updatedAt'] as Timestamp,
    );
  }

  // DTO => Entity (instance method)
  Rotation toEntity() {
    return Rotation(
      rotationId: rotationId,
      userId: userId,
      rotationName: rotationName,
      rotationMemberNames: rotationMemberNames,
      rotationDays:
          rotationDays.map((value) => Weekday.fromInt(value)).toList(),
      notificationTime: _mapToTimeOfDay(notificationTime),
      currentRotationIndex: currentRotationIndex,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
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
      'notificationTime': notificationTime,
      'currentRotationIndex': currentRotationIndex,
      'createdAt': createdAt,
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

  static List<RotationMemberName> _parseRotationMembers(dynamic data) {
    if (data == null) return [];

    if (data is! List) {
      throw FormatException(
        'rotationMemberNames must be a List, got ${data.runtimeType}',
      );
    }

    return data
        .whereType<String>()
        .map((name) => RotationMemberName(name))
        .toList();
  }
}
