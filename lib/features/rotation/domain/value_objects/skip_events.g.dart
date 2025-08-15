// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skip_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkipEvents _$SkipEventsFromJson(Map<String, dynamic> json) => _SkipEvents(
  (json['value'] as List<dynamic>)
      .map((e) => SkipEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SkipEventsToJson(_SkipEvents instance) =>
    <String, dynamic>{'value': instance.value};
