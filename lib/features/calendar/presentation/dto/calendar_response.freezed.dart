// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarDataResponse {

 RotationResponse get rotationResponse; Map<DateKey, CalendarDayResponse> get dayInfoMap;
/// Create a copy of CalendarDataResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDataResponseCopyWith<CalendarDataResponse> get copyWith => _$CalendarDataResponseCopyWithImpl<CalendarDataResponse>(this as CalendarDataResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDataResponse&&(identical(other.rotationResponse, rotationResponse) || other.rotationResponse == rotationResponse)&&const DeepCollectionEquality().equals(other.dayInfoMap, dayInfoMap));
}


@override
int get hashCode => Object.hash(runtimeType,rotationResponse,const DeepCollectionEquality().hash(dayInfoMap));

@override
String toString() {
  return 'CalendarDataResponse(rotationResponse: $rotationResponse, dayInfoMap: $dayInfoMap)';
}


}

/// @nodoc
abstract mixin class $CalendarDataResponseCopyWith<$Res>  {
  factory $CalendarDataResponseCopyWith(CalendarDataResponse value, $Res Function(CalendarDataResponse) _then) = _$CalendarDataResponseCopyWithImpl;
@useResult
$Res call({
 RotationResponse rotationResponse, Map<DateKey, CalendarDayResponse> dayInfoMap
});


$RotationResponseCopyWith<$Res> get rotationResponse;

}
/// @nodoc
class _$CalendarDataResponseCopyWithImpl<$Res>
    implements $CalendarDataResponseCopyWith<$Res> {
  _$CalendarDataResponseCopyWithImpl(this._self, this._then);

  final CalendarDataResponse _self;
  final $Res Function(CalendarDataResponse) _then;

/// Create a copy of CalendarDataResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationResponse = null,Object? dayInfoMap = null,}) {
  return _then(_self.copyWith(
rotationResponse: null == rotationResponse ? _self.rotationResponse : rotationResponse // ignore: cast_nullable_to_non_nullable
as RotationResponse,dayInfoMap: null == dayInfoMap ? _self.dayInfoMap : dayInfoMap // ignore: cast_nullable_to_non_nullable
as Map<DateKey, CalendarDayResponse>,
  ));
}
/// Create a copy of CalendarDataResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationResponseCopyWith<$Res> get rotationResponse {
  
  return $RotationResponseCopyWith<$Res>(_self.rotationResponse, (value) {
    return _then(_self.copyWith(rotationResponse: value));
  });
}
}


/// @nodoc


class _CalendarDataResponse extends CalendarDataResponse {
  const _CalendarDataResponse({required this.rotationResponse, required final  Map<DateKey, CalendarDayResponse> dayInfoMap}): _dayInfoMap = dayInfoMap,super._();
  

@override final  RotationResponse rotationResponse;
 final  Map<DateKey, CalendarDayResponse> _dayInfoMap;
@override Map<DateKey, CalendarDayResponse> get dayInfoMap {
  if (_dayInfoMap is EqualUnmodifiableMapView) return _dayInfoMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dayInfoMap);
}


/// Create a copy of CalendarDataResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDataResponseCopyWith<_CalendarDataResponse> get copyWith => __$CalendarDataResponseCopyWithImpl<_CalendarDataResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDataResponse&&(identical(other.rotationResponse, rotationResponse) || other.rotationResponse == rotationResponse)&&const DeepCollectionEquality().equals(other._dayInfoMap, _dayInfoMap));
}


@override
int get hashCode => Object.hash(runtimeType,rotationResponse,const DeepCollectionEquality().hash(_dayInfoMap));

@override
String toString() {
  return 'CalendarDataResponse(rotationResponse: $rotationResponse, dayInfoMap: $dayInfoMap)';
}


}

/// @nodoc
abstract mixin class _$CalendarDataResponseCopyWith<$Res> implements $CalendarDataResponseCopyWith<$Res> {
  factory _$CalendarDataResponseCopyWith(_CalendarDataResponse value, $Res Function(_CalendarDataResponse) _then) = __$CalendarDataResponseCopyWithImpl;
@override @useResult
$Res call({
 RotationResponse rotationResponse, Map<DateKey, CalendarDayResponse> dayInfoMap
});


@override $RotationResponseCopyWith<$Res> get rotationResponse;

}
/// @nodoc
class __$CalendarDataResponseCopyWithImpl<$Res>
    implements _$CalendarDataResponseCopyWith<$Res> {
  __$CalendarDataResponseCopyWithImpl(this._self, this._then);

  final _CalendarDataResponse _self;
  final $Res Function(_CalendarDataResponse) _then;

/// Create a copy of CalendarDataResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationResponse = null,Object? dayInfoMap = null,}) {
  return _then(_CalendarDataResponse(
rotationResponse: null == rotationResponse ? _self.rotationResponse : rotationResponse // ignore: cast_nullable_to_non_nullable
as RotationResponse,dayInfoMap: null == dayInfoMap ? _self._dayInfoMap : dayInfoMap // ignore: cast_nullable_to_non_nullable
as Map<DateKey, CalendarDayResponse>,
  ));
}

/// Create a copy of CalendarDataResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationResponseCopyWith<$Res> get rotationResponse {
  
  return $RotationResponseCopyWith<$Res>(_self.rotationResponse, (value) {
    return _then(_self.copyWith(rotationResponse: value));
  });
}
}

/// @nodoc
mixin _$CalendarDayResponse {

 DateTime get date; String? get memberName; bool get isRotationDay; int? get memberColorIndex;
/// Create a copy of CalendarDayResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayResponseCopyWith<CalendarDayResponse> get copyWith => _$CalendarDayResponseCopyWithImpl<CalendarDayResponse>(this as CalendarDayResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDayResponse&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,memberColorIndex);

@override
String toString() {
  return 'CalendarDayResponse(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class $CalendarDayResponseCopyWith<$Res>  {
  factory $CalendarDayResponseCopyWith(CalendarDayResponse value, $Res Function(CalendarDayResponse) _then) = _$CalendarDayResponseCopyWithImpl;
@useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, int? memberColorIndex
});




}
/// @nodoc
class _$CalendarDayResponseCopyWithImpl<$Res>
    implements $CalendarDayResponseCopyWith<$Res> {
  _$CalendarDayResponseCopyWithImpl(this._self, this._then);

  final CalendarDayResponse _self;
  final $Res Function(CalendarDayResponse) _then;

/// Create a copy of CalendarDayResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? memberColorIndex = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,memberColorIndex: freezed == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc


class _CalendarDayResponse extends CalendarDayResponse {
  const _CalendarDayResponse({required this.date, required this.memberName, required this.isRotationDay, required this.memberColorIndex}): super._();
  

@override final  DateTime date;
@override final  String? memberName;
@override final  bool isRotationDay;
@override final  int? memberColorIndex;

/// Create a copy of CalendarDayResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayResponseCopyWith<_CalendarDayResponse> get copyWith => __$CalendarDayResponseCopyWithImpl<_CalendarDayResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDayResponse&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,memberColorIndex);

@override
String toString() {
  return 'CalendarDayResponse(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayResponseCopyWith<$Res> implements $CalendarDayResponseCopyWith<$Res> {
  factory _$CalendarDayResponseCopyWith(_CalendarDayResponse value, $Res Function(_CalendarDayResponse) _then) = __$CalendarDayResponseCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, int? memberColorIndex
});




}
/// @nodoc
class __$CalendarDayResponseCopyWithImpl<$Res>
    implements _$CalendarDayResponseCopyWith<$Res> {
  __$CalendarDayResponseCopyWithImpl(this._self, this._then);

  final _CalendarDayResponse _self;
  final $Res Function(_CalendarDayResponse) _then;

/// Create a copy of CalendarDayResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? memberColorIndex = freezed,}) {
  return _then(_CalendarDayResponse(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,memberColorIndex: freezed == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$DateKey {

 int get year; int get month; int get day;
/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateKeyCopyWith<DateKey> get copyWith => _$DateKeyCopyWithImpl<DateKey>(this as DateKey, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateKey&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'DateKey(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class $DateKeyCopyWith<$Res>  {
  factory $DateKeyCopyWith(DateKey value, $Res Function(DateKey) _then) = _$DateKeyCopyWithImpl;
@useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class _$DateKeyCopyWithImpl<$Res>
    implements $DateKeyCopyWith<$Res> {
  _$DateKeyCopyWithImpl(this._self, this._then);

  final DateKey _self;
  final $Res Function(DateKey) _then;

/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _DateKey implements DateKey {
  const _DateKey({required this.year, required this.month, required this.day});
  

@override final  int year;
@override final  int month;
@override final  int day;

/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateKeyCopyWith<_DateKey> get copyWith => __$DateKeyCopyWithImpl<_DateKey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateKey&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'DateKey(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class _$DateKeyCopyWith<$Res> implements $DateKeyCopyWith<$Res> {
  factory _$DateKeyCopyWith(_DateKey value, $Res Function(_DateKey) _then) = __$DateKeyCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class __$DateKeyCopyWithImpl<$Res>
    implements _$DateKeyCopyWith<$Res> {
  __$DateKeyCopyWithImpl(this._self, this._then);

  final _DateKey _self;
  final $Res Function(_DateKey) _then;

/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_DateKey(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
