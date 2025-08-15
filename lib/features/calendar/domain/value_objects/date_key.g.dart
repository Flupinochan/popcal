// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DateKey _$DateKeyFromJson(Map<String, dynamic> json) =>
    _DateKey(DateTime.parse(json['value'] as String));

Map<String, dynamic> _$DateKeyToJson(_DateKey instance) => <String, dynamic>{
  'value': instance.value.toIso8601String(),
};
