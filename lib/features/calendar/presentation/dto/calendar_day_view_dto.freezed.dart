// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_day_view_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarDayViewDto {

 DateTime get date; String? get memberName; bool get isRotationDay; String get displayText; int get memberColorIndex;
/// Create a copy of CalendarDayViewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayViewDtoCopyWith<CalendarDayViewDto> get copyWith => _$CalendarDayViewDtoCopyWithImpl<CalendarDayViewDto>(this as CalendarDayViewDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDayViewDto&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.displayText, displayText) || other.displayText == displayText)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,displayText,memberColorIndex);

@override
String toString() {
  return 'CalendarDayViewDto(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, displayText: $displayText, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class $CalendarDayViewDtoCopyWith<$Res>  {
  factory $CalendarDayViewDtoCopyWith(CalendarDayViewDto value, $Res Function(CalendarDayViewDto) _then) = _$CalendarDayViewDtoCopyWithImpl;
@useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, String displayText, int memberColorIndex
});




}
/// @nodoc
class _$CalendarDayViewDtoCopyWithImpl<$Res>
    implements $CalendarDayViewDtoCopyWith<$Res> {
  _$CalendarDayViewDtoCopyWithImpl(this._self, this._then);

  final CalendarDayViewDto _self;
  final $Res Function(CalendarDayViewDto) _then;

/// Create a copy of CalendarDayViewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? displayText = null,Object? memberColorIndex = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,displayText: null == displayText ? _self.displayText : displayText // ignore: cast_nullable_to_non_nullable
as String,memberColorIndex: null == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _CalendarDayViewDto implements CalendarDayViewDto {
  const _CalendarDayViewDto({required this.date, required this.memberName, required this.isRotationDay, required this.displayText, required this.memberColorIndex});
  

@override final  DateTime date;
@override final  String? memberName;
@override final  bool isRotationDay;
@override final  String displayText;
@override final  int memberColorIndex;

/// Create a copy of CalendarDayViewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayViewDtoCopyWith<_CalendarDayViewDto> get copyWith => __$CalendarDayViewDtoCopyWithImpl<_CalendarDayViewDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDayViewDto&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.displayText, displayText) || other.displayText == displayText)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,displayText,memberColorIndex);

@override
String toString() {
  return 'CalendarDayViewDto(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, displayText: $displayText, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayViewDtoCopyWith<$Res> implements $CalendarDayViewDtoCopyWith<$Res> {
  factory _$CalendarDayViewDtoCopyWith(_CalendarDayViewDto value, $Res Function(_CalendarDayViewDto) _then) = __$CalendarDayViewDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, String displayText, int memberColorIndex
});




}
/// @nodoc
class __$CalendarDayViewDtoCopyWithImpl<$Res>
    implements _$CalendarDayViewDtoCopyWith<$Res> {
  __$CalendarDayViewDtoCopyWithImpl(this._self, this._then);

  final _CalendarDayViewDto _self;
  final $Res Function(_CalendarDayViewDto) _then;

/// Create a copy of CalendarDayViewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? displayText = null,Object? memberColorIndex = null,}) {
  return _then(_CalendarDayViewDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,displayText: null == displayText ? _self.displayText : displayText // ignore: cast_nullable_to_non_nullable
as String,memberColorIndex: null == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
