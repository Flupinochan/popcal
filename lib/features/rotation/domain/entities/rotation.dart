import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';

// ローテーション設定
class Rotation {
  // Firestoreに保存した後に付与されるためオプショナル
  final RotationId? rotationId;
  final UserId userId;
  final RotationName rotationName;
  final List<RotationMemberName> rotationMemberNames;
  final List<Weekday> rotationDays;
  final NotificationTime notificationTime;
  // ローテーションした回数
  final RotationIndex currentRotationIndex;
  final RotationCreatedAt createdAt;
  final RotationUpdatedAt updatedAt;

  const Rotation({
    this.rotationId,
    required this.userId,
    required this.rotationName,
    required this.rotationMemberNames,
    required this.rotationDays,
    required this.notificationTime,
    required this.currentRotationIndex,
    required this.createdAt,
    required this.updatedAt,
  });

  Rotation copyWith({
    RotationId? rotationId,
    UserId? userId,
    RotationName? rotationName,
    List<RotationMemberName>? rotationMemberNames,
    List<Weekday>? rotationDays,
    NotificationTime? notificationTime,
    RotationIndex? currentRotationIndex,
    RotationCreatedAt? createdAt,
    RotationUpdatedAt? updatedAt,
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

  // メンバーの順番を取得 (entityに記載すべきかvalue objectから取得すべきか)
  int getMemberIndex(RotationMemberName rotationMemberName) {
    final index = rotationMemberNames.indexOf(rotationMemberName);
    return index >= 0 ? index : 0;
  }
}
