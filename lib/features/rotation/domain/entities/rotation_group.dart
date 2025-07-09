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
    if (rotationGroupId == null) {
      throw StateError('ローテーションIDが未初期化です');
    }

    final hash = sha256.convert(utf8.encode(rotationGroupId!));
    final rawValue = hash.bytes
        .take(4)
        .fold(0, (prev, byte) => prev * 256 + byte);

    // 32bit符号付き整数の正の範囲内に収める必要がある (0 ～ 2^31 - 1)
    return rawValue & 0x7FFFFFFF;
  }
}
