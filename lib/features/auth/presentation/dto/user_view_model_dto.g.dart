// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_view_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserViewModelDto _$UserViewModelDtoFromJson(Map<String, dynamic> json) =>
    _UserViewModelDto(
      userId: UserId.fromJson(json['userId'] as String),
      email: Email.fromJson(json['email'] as String),
    );

Map<String, dynamic> _$UserViewModelDtoToJson(_UserViewModelDto instance) =>
    <String, dynamic>{'userId': instance.userId, 'email': instance.email};
