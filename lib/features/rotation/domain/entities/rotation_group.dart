import 'package:flutter/material.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';

// ローテーション設定
class RotationGroup {
  // Firestoreに保存した後に付与されるためオプショナル
  final String? rotationGroupId;
  final String ownerUserId;
  final String rotationName;
  final List<String> rotationMembers;
  final List<Weekday> rotationDays;
  final TimeOfDay notificationTime;
  // ローテーションした回数
  final int currentRotationIndex;
  // 最後の通知設定日 => 直近30日分を常に更新して通知設定するため
  final DateTime lastScheduledDate;
  final DateTime rotationStartDate;
  final DateTime updatedAt;

  const RotationGroup({
    this.rotationGroupId,
    required this.ownerUserId,
    required this.rotationName,
    required this.rotationMembers,
    required this.rotationDays,
    required this.notificationTime,
    this.currentRotationIndex = 0,
    DateTime? lastScheduledDate,
    required this.rotationStartDate,
    required this.updatedAt,
  }) : lastScheduledDate = lastScheduledDate ?? rotationStartDate;

  // 特定の値を更新するために利用
  RotationGroup copyWith({
    String? rotationGroupId,
    String? ownerUserId,
    String? rotationName,
    List<String>? rotationMembers,
    List<Weekday>? rotationDays,
    TimeOfDay? notificationTime,
    int? currentRotationIndex,
    DateTime? lastScheduledDate,
    DateTime? rotationStartDate,
    DateTime? updatedAt,
  }) {
    return RotationGroup(
      rotationGroupId: rotationGroupId ?? this.rotationGroupId,
      ownerUserId: ownerUserId ?? this.ownerUserId,
      rotationName: rotationName ?? this.rotationName,
      rotationMembers: rotationMembers ?? this.rotationMembers,
      rotationDays: rotationDays ?? this.rotationDays,
      notificationTime: notificationTime ?? this.notificationTime,
      currentRotationIndex: currentRotationIndex ?? this.currentRotationIndex,
      lastScheduledDate: lastScheduledDate ?? this.lastScheduledDate,
      rotationStartDate: rotationStartDate ?? this.rotationStartDate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
