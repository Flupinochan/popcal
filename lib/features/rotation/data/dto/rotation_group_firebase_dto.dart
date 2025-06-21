// Firebase Cloud Firestore <=> DTO <=> Entity 変換するDTOクラス
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

class RotationGroupFirebaseDto {
  final String? rotationGroupId;
  final String ownerUserId;
  final String rotationName;
  final List<String> rotationMembers;
  // firestoreに保存する際はTimestampが適切
  // Widget(UI)はDateTimeが適切
  final Timestamp notificationTime;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const RotationGroupFirebaseDto({
    required this.rotationGroupId,
    required this.ownerUserId,
    required this.rotationName,
    required this.rotationMembers,
    required this.notificationTime,
    required this.createdAt,
    required this.updatedAt,
  });

  // Entity => DTO
  factory RotationGroupFirebaseDto.fromEntity(RotationGroup entity) {
    return RotationGroupFirebaseDto(
      rotationGroupId:
          entity.rotationGroupId?.isNotEmpty == true
              ? entity.rotationGroupId
              : null,
      ownerUserId: entity.ownerUserId,
      rotationName: entity.rotationName,
      rotationMembers: entity.rotationMembers,
      notificationTime: Timestamp.fromDate(entity.notificationTime),
      createdAt: Timestamp.fromDate(entity.createdAt),
      updatedAt: Timestamp.fromDate(entity.updatedAt),
    );
  }

  // DTO => Entity
  RotationGroup toEntity() {
    return RotationGroup(
      rotationGroupId: rotationGroupId,
      ownerUserId: ownerUserId,
      rotationName: rotationName,
      rotationMembers: rotationMembers,
      notificationTime: notificationTime.toDate(),
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
    );
  }

  // Firestore => DTO
  factory RotationGroupFirebaseDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RotationGroupFirebaseDto(
      rotationGroupId: doc.id,
      ownerUserId: data['ownerUserId'],
      rotationName: data['rotationName'],
      rotationMembers: List<String>.from(data['rotationMembers']),
      notificationTime: data['notificationTime'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  // DTO => Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'ownerUserId': ownerUserId,
      'rotationName': rotationName,
      'rotationMembers': rotationMembers,
      'notificationTime': notificationTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
