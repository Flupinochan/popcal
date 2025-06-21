import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

class RotationGroupFirebaseDto {
  final String id;
  final String title;
  final String rotationType;
  final List<Map<String, dynamic>> roles;
  final List<Map<String, dynamic>> members;
  final Map<String, dynamic> schedule;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const RotationGroupFirebaseDto({
    required this.id,
    required this.title,
    required this.rotationType,
    required this.roles,
    required this.members,
    required this.schedule,
    required this.createdAt,
    required this.updatedAt,
  });

  // Entity → DTO
  factory RotationGroupFirebaseDto.fromEntity(RotationGroup entity) {
    return RotationGroupFirebaseDto(
      id: entity.id,
      title: entity.title,
      rotationType: entity.rotationType.name,
      roles: entity.roles.map((role) => role.toMap()).toList(),
      members: entity.members.map((member) => member.toMap()).toList(),
      schedule: entity.schedule.toMap(),
      // firestoreはTimestampが推奨、Widgetでは、DateTimeを利用する
      createdAt: Timestamp.fromDate(entity.createdAt),
      updatedAt: Timestamp.fromDate(entity.updatedAt),
    );
  }

  // DTO → Map (Firestore保存用)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rotationType': rotationType,
      'roles': roles,
      'members': members,
      'schedule': schedule,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Map → DTO (Firestore読込用)
  factory RotationGroupFirebaseDto.fromMap(Map<String, dynamic> map) {
    return RotationGroupFirebaseDto(
      id: map['id'] as String,
      title: map['title'] as String,
      rotationType: map['rotationType'] as String,
      roles: List<Map<String, dynamic>>.from(map['roles']),
      members: List<Map<String, dynamic>>.from(map['members']),
      schedule: Map<String, dynamic>.from(map['schedule']),
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }
}
