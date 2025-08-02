// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_firebase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserFirebaseDto _$UserFirebaseDtoFromJson(Map<String, dynamic> json) =>
    _UserFirebaseDto(
      userId: UserId.fromJson(json['userId'] as String),
      email: Email.fromJson(json['email'] as String),
    );

Map<String, dynamic> _$UserFirebaseDtoToJson(_UserFirebaseDto instance) =>
    <String, dynamic>{'userId': instance.userId, 'email': instance.email};
