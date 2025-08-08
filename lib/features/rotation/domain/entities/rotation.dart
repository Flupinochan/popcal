import 'package:flutter/material.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

// ローテーション設定
class Rotation {
  // Firestoreに保存した後に付与されるためオプショナル
  final String? rotationId;
  final UserId userId;
  final String rotationName;
  final List<String> rotationMembers;
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
    required this.rotationMembers,
    required this.rotationDays,
    required this.notificationTime,
    this.currentRotationIndex = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  Rotation copyWith({
    String? rotationId,
    UserId? userId,
    String? rotationName,
    List<String>? rotationMembers,
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
      rotationMembers: rotationMembers ?? this.rotationMembers,
      rotationDays: rotationDays ?? this.rotationDays,
      notificationTime: notificationTime ?? this.notificationTime,
      currentRotationIndex: currentRotationIndex ?? this.currentRotationIndex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // メンバーの順番を取得
  int getMemberIndex(String memberName) {
    final index = rotationMembers.indexOf(memberName);
    return index >= 0 ? index : 0;
  }
}
