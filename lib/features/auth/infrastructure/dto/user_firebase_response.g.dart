// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_firebase_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserFirebaseResponse _$UserFirebaseResponseFromJson(
  Map<String, dynamic> json,
) => _UserFirebaseResponse(
  userId: UserId.fromJson(json['userId'] as String),
  email: Email.fromJson(json['email'] as String),
);

Map<String, dynamic> _$UserFirebaseResponseToJson(
  _UserFirebaseResponse instance,
) => <String, dynamic>{'userId': instance.userId, 'email': instance.email};
