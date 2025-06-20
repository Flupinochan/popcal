// Firebase Cloud Firestore <=> DTO <=> Entity 変換するDTOクラス
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

part 'rotation_group_firebase_dto.freezed.dart';

@freezed
sealed class RotationGroupFirebaseDto with _$RotationGroupFirebaseDto {
  const RotationGroupFirebaseDto._();

  const factory RotationGroupFirebaseDto({
    required String? rotationGroupId,
    required String ownerUserId,
    required String rotationName,
    required List<String> rotationMembers,
    // firestoreに保存する際はTimestampが適切
    // Widget(UI)はDateTimeが適切
    required Timestamp notificationTime,
    required Timestamp createdAt,
    required Timestamp updatedAt,
  }) = _RotationGroupFirebaseDto;

  // Entity => DTO (factory method)
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

  // Firestore => DTO (factory method)
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

  // DTO => Entity (instance method)
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

  // DTO => Firestore (instance method)
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
