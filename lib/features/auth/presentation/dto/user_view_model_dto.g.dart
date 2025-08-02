// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_view_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserViewModelDto _$UserViewModelDtoFromJson(Map<String, dynamic> json) =>
    _UserViewModelDto(
      uid: UserId.fromJson(json['uid'] as String),
      email: Email.fromJson(json['email'] as String),
    );

Map<String, dynamic> _$UserViewModelDtoToJson(_UserViewModelDto instance) =>
    <String, dynamic>{'uid': instance.uid, 'email': instance.email};
