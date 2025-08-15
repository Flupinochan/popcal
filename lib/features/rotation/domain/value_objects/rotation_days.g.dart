// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RotationDays _$RotationDaysFromJson(Map<String, dynamic> json) =>
    _RotationDays(
      (json['value'] as List<dynamic>)
          .map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$RotationDaysToJson(_RotationDays instance) =>
    <String, dynamic>{
      'value': instance.value.map((e) => _$WeekdayEnumMap[e]!).toList(),
    };

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};
