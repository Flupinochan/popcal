import 'package:flutter/material.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

// ローテーション設定
class Rotation {
  // Firestoreに保存した後に付与されるためオプショナル
  final RotationId? rotationId;
  final UserId userId;
  final RotationName rotationName;
  final List<RotationMemberName> rotationMemberNames;
  final List<Weekday> rotationDays;
  final TimeOfDay notificationTime;
  // ローテーションした回数
  final int currentRotationIndex;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Rotation({
    this.rotationId,
    required this.userId,
    required this.rotationName,
    required this.rotationMemberNames,
    required this.rotationDays,
    required this.notificationTime,
    this.currentRotationIndex = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  Rotation copyWith({
    RotationId? rotationId,
    UserId? userId,
    RotationName? rotationName,
    List<RotationMemberName>? rotationMemberNames,
    List<Weekday>? rotationDays,
    TimeOfDay? notificationTime,
    int? currentRotationIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Rotation(
      rotationId: rotationId ?? this.rotationId,
      userId: userId ?? this.userId,
      rotationName: rotationName ?? this.rotationName,
      rotationMemberNames: rotationMemberNames ?? this.rotationMemberNames,
      rotationDays: rotationDays ?? this.rotationDays,
      notificationTime: notificationTime ?? this.notificationTime,
      currentRotationIndex: currentRotationIndex ?? this.currentRotationIndex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // メンバーの順番を取得
  int getMemberIndex(RotationMemberName rotationMemberName) {
    final index = rotationMemberNames.indexOf(rotationMemberName);
    return index >= 0 ? index : 0;
  }
}
