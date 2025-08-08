// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_schedule_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarScheduleResponse {

 RotationResponse get rotationResponse; Map<DateKey, ScheduleDayResponse> get scheduleMap;
/// Create a copy of CalendarScheduleResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarScheduleResponseCopyWith<CalendarScheduleResponse> get copyWith => _$CalendarScheduleResponseCopyWithImpl<CalendarScheduleResponse>(this as CalendarScheduleResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarScheduleResponse&&(identical(other.rotationResponse, rotationResponse) || other.rotationResponse == rotationResponse)&&const DeepCollectionEquality().equals(other.scheduleMap, scheduleMap));
}


@override
int get hashCode => Object.hash(runtimeType,rotationResponse,const DeepCollectionEquality().hash(scheduleMap));

@override
String toString() {
  return 'CalendarScheduleResponse(rotationResponse: $rotationResponse, scheduleMap: $scheduleMap)';
}


}

/// @nodoc
abstract mixin class $CalendarScheduleResponseCopyWith<$Res>  {
  factory $CalendarScheduleResponseCopyWith(CalendarScheduleResponse value, $Res Function(CalendarScheduleResponse) _then) = _$CalendarScheduleResponseCopyWithImpl;
@useResult
$Res call({
 RotationResponse rotationResponse, Map<DateKey, ScheduleDayResponse> scheduleMap
});


$RotationResponseCopyWith<$Res> get rotationResponse;

}
/// @nodoc
class _$CalendarScheduleResponseCopyWithImpl<$Res>
    implements $CalendarScheduleResponseCopyWith<$Res> {
  _$CalendarScheduleResponseCopyWithImpl(this._self, this._then);

  final CalendarScheduleResponse _self;
  final $Res Function(CalendarScheduleResponse) _then;

/// Create a copy of CalendarScheduleResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationResponse = null,Object? scheduleMap = null,}) {
  return _then(_self.copyWith(
rotationResponse: null == rotationResponse ? _self.rotationResponse : rotationResponse // ignore: cast_nullable_to_non_nullable
as RotationResponse,scheduleMap: null == scheduleMap ? _self.scheduleMap : scheduleMap // ignore: cast_nullable_to_non_nullable
as Map<DateKey, ScheduleDayResponse>,
  ));
}
/// Create a copy of CalendarScheduleResponse
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


class _CalendarScheduleResponse extends CalendarScheduleResponse {
  const _CalendarScheduleResponse({required this.rotationResponse, required final  Map<DateKey, ScheduleDayResponse> scheduleMap}): _scheduleMap = scheduleMap,super._();
  

@override final  RotationResponse rotationResponse;
 final  Map<DateKey, ScheduleDayResponse> _scheduleMap;
@override Map<DateKey, ScheduleDayResponse> get scheduleMap {
  if (_scheduleMap is EqualUnmodifiableMapView) return _scheduleMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scheduleMap);
}


/// Create a copy of CalendarScheduleResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarScheduleResponseCopyWith<_CalendarScheduleResponse> get copyWith => __$CalendarScheduleResponseCopyWithImpl<_CalendarScheduleResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarScheduleResponse&&(identical(other.rotationResponse, rotationResponse) || other.rotationResponse == rotationResponse)&&const DeepCollectionEquality().equals(other._scheduleMap, _scheduleMap));
}


@override
int get hashCode => Object.hash(runtimeType,rotationResponse,const DeepCollectionEquality().hash(_scheduleMap));

@override
String toString() {
  return 'CalendarScheduleResponse(rotationResponse: $rotationResponse, scheduleMap: $scheduleMap)';
}


}

/// @nodoc
abstract mixin class _$CalendarScheduleResponseCopyWith<$Res> implements $CalendarScheduleResponseCopyWith<$Res> {
  factory _$CalendarScheduleResponseCopyWith(_CalendarScheduleResponse value, $Res Function(_CalendarScheduleResponse) _then) = __$CalendarScheduleResponseCopyWithImpl;
@override @useResult
$Res call({
 RotationResponse rotationResponse, Map<DateKey, ScheduleDayResponse> scheduleMap
});


@override $RotationResponseCopyWith<$Res> get rotationResponse;

}
/// @nodoc
class __$CalendarScheduleResponseCopyWithImpl<$Res>
    implements _$CalendarScheduleResponseCopyWith<$Res> {
  __$CalendarScheduleResponseCopyWithImpl(this._self, this._then);

  final _CalendarScheduleResponse _self;
  final $Res Function(_CalendarScheduleResponse) _then;

/// Create a copy of CalendarScheduleResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationResponse = null,Object? scheduleMap = null,}) {
  return _then(_CalendarScheduleResponse(
rotationResponse: null == rotationResponse ? _self.rotationResponse : rotationResponse // ignore: cast_nullable_to_non_nullable
as RotationResponse,scheduleMap: null == scheduleMap ? _self._scheduleMap : scheduleMap // ignore: cast_nullable_to_non_nullable
as Map<DateKey, ScheduleDayResponse>,
  ));
}

/// Create a copy of CalendarScheduleResponse
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
mixin _$ScheduleDayResponse {

 NotificationDateTime get date; RotationMemberName get memberName; bool get isRotationDay; int? get memberColorIndex;
/// Create a copy of ScheduleDayResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleDayResponseCopyWith<ScheduleDayResponse> get copyWith => _$ScheduleDayResponseCopyWithImpl<ScheduleDayResponse>(this as ScheduleDayResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleDayResponse&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,memberColorIndex);

@override
String toString() {
  return 'ScheduleDayResponse(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class $ScheduleDayResponseCopyWith<$Res>  {
  factory $ScheduleDayResponseCopyWith(ScheduleDayResponse value, $Res Function(ScheduleDayResponse) _then) = _$ScheduleDayResponseCopyWithImpl;
@useResult
$Res call({
 NotificationDateTime date, RotationMemberName memberName, bool isRotationDay, int? memberColorIndex
});




}
/// @nodoc
class _$ScheduleDayResponseCopyWithImpl<$Res>
    implements $ScheduleDayResponseCopyWith<$Res> {
  _$ScheduleDayResponseCopyWithImpl(this._self, this._then);

  final ScheduleDayResponse _self;
  final $Res Function(ScheduleDayResponse) _then;

/// Create a copy of ScheduleDayResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? memberName = null,Object? isRotationDay = null,Object? memberColorIndex = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as RotationMemberName,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,memberColorIndex: freezed == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc


class _ScheduleDayResponse extends ScheduleDayResponse {
  const _ScheduleDayResponse({required this.date, required this.memberName, required this.isRotationDay, required this.memberColorIndex}): super._();
  

@override final  NotificationDateTime date;
@override final  RotationMemberName memberName;
@override final  bool isRotationDay;
@override final  int? memberColorIndex;

/// Create a copy of ScheduleDayResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleDayResponseCopyWith<_ScheduleDayResponse> get copyWith => __$ScheduleDayResponseCopyWithImpl<_ScheduleDayResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleDayResponse&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,memberColorIndex);

@override
String toString() {
  return 'ScheduleDayResponse(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class _$ScheduleDayResponseCopyWith<$Res> implements $ScheduleDayResponseCopyWith<$Res> {
  factory _$ScheduleDayResponseCopyWith(_ScheduleDayResponse value, $Res Function(_ScheduleDayResponse) _then) = __$ScheduleDayResponseCopyWithImpl;
@override @useResult
$Res call({
 NotificationDateTime date, RotationMemberName memberName, bool isRotationDay, int? memberColorIndex
});




}
/// @nodoc
class __$ScheduleDayResponseCopyWithImpl<$Res>
    implements _$ScheduleDayResponseCopyWith<$Res> {
  __$ScheduleDayResponseCopyWithImpl(this._self, this._then);

  final _ScheduleDayResponse _self;
  final $Res Function(_ScheduleDayResponse) _then;

/// Create a copy of ScheduleDayResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? memberName = null,Object? isRotationDay = null,Object? memberColorIndex = freezed,}) {
  return _then(_ScheduleDayResponse(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as RotationMemberName,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,memberColorIndex: freezed == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
