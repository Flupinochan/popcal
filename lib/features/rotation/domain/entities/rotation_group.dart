import 'dart:convert';

import 'package:crypto/crypto.dart';

// ローテーション中核
class RotationGroup {
  // Firestoreに保存した後に付与されるためオプショナル
  final String? rotationGroupId;
  final String ownerUserId;
  final String rotationName;
  final List<String> rotationMembers;
  final DateTime notificationTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RotationGroup({
    this.rotationGroupId,
    required this.ownerUserId,
    required this.rotationName,
    required this.rotationMembers,
    required this.notificationTime,
    required this.createdAt,
    required this.updatedAt,
  });

  // rotationGroupIdからハッシュ値のnotificationIdを取得
  int get notificationId {
    final hash = sha256.convert(utf8.encode(rotationGroupId!));
    return hash.bytes.take(4).fold(0, (prev, byte) => prev * 256 + byte);
  }
}
