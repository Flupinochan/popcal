// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_firebase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserFirebaseModel _$UserFirebaseModelFromJson(Map<String, dynamic> json) =>
    _UserFirebaseModel(
      userId: UserId.fromJson(json['userId'] as String),
      email: Email.fromJson(json['email'] as String),
    );

Map<String, dynamic> _$UserFirebaseModelToJson(_UserFirebaseModel instance) =>
    <String, dynamic>{'userId': instance.userId, 'email': instance.email};
