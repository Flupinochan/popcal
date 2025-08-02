// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_firebase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserFirebaseDto _$UserFirebaseDtoFromJson(Map<String, dynamic> json) =>
    _UserFirebaseDto(
      uid: UserId.fromJson(json['uid'] as String),
      email: Email.fromJson(json['email'] as String),
    );

Map<String, dynamic> _$UserFirebaseDtoToJson(_UserFirebaseDto instance) =>
    <String, dynamic>{'uid': instance.uid, 'email': instance.email};
