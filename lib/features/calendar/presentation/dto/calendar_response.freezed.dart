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
mixin _$CalendarResponse {

 UserResponse get userViewModelDto; RotationGroup get rotationGroup; Map<String, CalendarDayViewModel> get dayInfoMap;
/// Create a copy of CalendarResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarResponseCopyWith<CalendarResponse> get copyWith => _$CalendarResponseCopyWithImpl<CalendarResponse>(this as CalendarResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarResponse&&(identical(other.userViewModelDto, userViewModelDto) || other.userViewModelDto == userViewModelDto)&&(identical(other.rotationGroup, rotationGroup) || other.rotationGroup == rotationGroup)&&const DeepCollectionEquality().equals(other.dayInfoMap, dayInfoMap));
}


@override
int get hashCode => Object.hash(runtimeType,userViewModelDto,rotationGroup,const DeepCollectionEquality().hash(dayInfoMap));

@override
String toString() {
  return 'CalendarResponse(userViewModelDto: $userViewModelDto, rotationGroup: $rotationGroup, dayInfoMap: $dayInfoMap)';
}


}

/// @nodoc
abstract mixin class $CalendarResponseCopyWith<$Res>  {
  factory $CalendarResponseCopyWith(CalendarResponse value, $Res Function(CalendarResponse) _then) = _$CalendarResponseCopyWithImpl;
@useResult
$Res call({
 UserResponse userViewModelDto, RotationGroup rotationGroup, Map<String, CalendarDayViewModel> dayInfoMap
});


$UserResponseCopyWith<$Res> get userViewModelDto;

}
/// @nodoc
class _$CalendarResponseCopyWithImpl<$Res>
    implements $CalendarResponseCopyWith<$Res> {
  _$CalendarResponseCopyWithImpl(this._self, this._then);

  final CalendarResponse _self;
  final $Res Function(CalendarResponse) _then;

/// Create a copy of CalendarResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userViewModelDto = null,Object? rotationGroup = null,Object? dayInfoMap = null,}) {
  return _then(_self.copyWith(
userViewModelDto: null == userViewModelDto ? _self.userViewModelDto : userViewModelDto // ignore: cast_nullable_to_non_nullable
as UserResponse,rotationGroup: null == rotationGroup ? _self.rotationGroup : rotationGroup // ignore: cast_nullable_to_non_nullable
as RotationGroup,dayInfoMap: null == dayInfoMap ? _self.dayInfoMap : dayInfoMap // ignore: cast_nullable_to_non_nullable
as Map<String, CalendarDayViewModel>,
  ));
}
/// Create a copy of CalendarResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseCopyWith<$Res> get userViewModelDto {
  
  return $UserResponseCopyWith<$Res>(_self.userViewModelDto, (value) {
    return _then(_self.copyWith(userViewModelDto: value));
  });
}
}


/// @nodoc


class _CalendarResponse extends CalendarResponse {
  const _CalendarResponse({required this.userViewModelDto, required this.rotationGroup, required final  Map<String, CalendarDayViewModel> dayInfoMap}): _dayInfoMap = dayInfoMap,super._();
  

@override final  UserResponse userViewModelDto;
@override final  RotationGroup rotationGroup;
 final  Map<String, CalendarDayViewModel> _dayInfoMap;
@override Map<String, CalendarDayViewModel> get dayInfoMap {
  if (_dayInfoMap is EqualUnmodifiableMapView) return _dayInfoMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dayInfoMap);
}


/// Create a copy of CalendarResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarResponseCopyWith<_CalendarResponse> get copyWith => __$CalendarResponseCopyWithImpl<_CalendarResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarResponse&&(identical(other.userViewModelDto, userViewModelDto) || other.userViewModelDto == userViewModelDto)&&(identical(other.rotationGroup, rotationGroup) || other.rotationGroup == rotationGroup)&&const DeepCollectionEquality().equals(other._dayInfoMap, _dayInfoMap));
}


@override
int get hashCode => Object.hash(runtimeType,userViewModelDto,rotationGroup,const DeepCollectionEquality().hash(_dayInfoMap));

@override
String toString() {
  return 'CalendarResponse(userViewModelDto: $userViewModelDto, rotationGroup: $rotationGroup, dayInfoMap: $dayInfoMap)';
}


}

/// @nodoc
abstract mixin class _$CalendarResponseCopyWith<$Res> implements $CalendarResponseCopyWith<$Res> {
  factory _$CalendarResponseCopyWith(_CalendarResponse value, $Res Function(_CalendarResponse) _then) = __$CalendarResponseCopyWithImpl;
@override @useResult
$Res call({
 UserResponse userViewModelDto, RotationGroup rotationGroup, Map<String, CalendarDayViewModel> dayInfoMap
});


@override $UserResponseCopyWith<$Res> get userViewModelDto;

}
/// @nodoc
class __$CalendarResponseCopyWithImpl<$Res>
    implements _$CalendarResponseCopyWith<$Res> {
  __$CalendarResponseCopyWithImpl(this._self, this._then);

  final _CalendarResponse _self;
  final $Res Function(_CalendarResponse) _then;

/// Create a copy of CalendarResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userViewModelDto = null,Object? rotationGroup = null,Object? dayInfoMap = null,}) {
  return _then(_CalendarResponse(
userViewModelDto: null == userViewModelDto ? _self.userViewModelDto : userViewModelDto // ignore: cast_nullable_to_non_nullable
as UserResponse,rotationGroup: null == rotationGroup ? _self.rotationGroup : rotationGroup // ignore: cast_nullable_to_non_nullable
as RotationGroup,dayInfoMap: null == dayInfoMap ? _self._dayInfoMap : dayInfoMap // ignore: cast_nullable_to_non_nullable
as Map<String, CalendarDayViewModel>,
  ));
}

/// Create a copy of CalendarResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseCopyWith<$Res> get userViewModelDto {
  
  return $UserResponseCopyWith<$Res>(_self.userViewModelDto, (value) {
    return _then(_self.copyWith(userViewModelDto: value));
  });
}
}

/// @nodoc
mixin _$CalendarDayViewModel {

 DateTime get date; String? get memberName; bool get isRotationDay; int? get memberColorIndex;
/// Create a copy of CalendarDayViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayViewModelCopyWith<CalendarDayViewModel> get copyWith => _$CalendarDayViewModelCopyWithImpl<CalendarDayViewModel>(this as CalendarDayViewModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDayViewModel&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,memberColorIndex);

@override
String toString() {
  return 'CalendarDayViewModel(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class $CalendarDayViewModelCopyWith<$Res>  {
  factory $CalendarDayViewModelCopyWith(CalendarDayViewModel value, $Res Function(CalendarDayViewModel) _then) = _$CalendarDayViewModelCopyWithImpl;
@useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, int? memberColorIndex
});




}
/// @nodoc
class _$CalendarDayViewModelCopyWithImpl<$Res>
    implements $CalendarDayViewModelCopyWith<$Res> {
  _$CalendarDayViewModelCopyWithImpl(this._self, this._then);

  final CalendarDayViewModel _self;
  final $Res Function(CalendarDayViewModel) _then;

/// Create a copy of CalendarDayViewModel
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


class _CalendarDayViewModel extends CalendarDayViewModel {
  const _CalendarDayViewModel({required this.date, required this.memberName, required this.isRotationDay, required this.memberColorIndex}): super._();
  

@override final  DateTime date;
@override final  String? memberName;
@override final  bool isRotationDay;
@override final  int? memberColorIndex;

/// Create a copy of CalendarDayViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayViewModelCopyWith<_CalendarDayViewModel> get copyWith => __$CalendarDayViewModelCopyWithImpl<_CalendarDayViewModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDayViewModel&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.memberColorIndex, memberColorIndex) || other.memberColorIndex == memberColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,memberColorIndex);

@override
String toString() {
  return 'CalendarDayViewModel(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, memberColorIndex: $memberColorIndex)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayViewModelCopyWith<$Res> implements $CalendarDayViewModelCopyWith<$Res> {
  factory _$CalendarDayViewModelCopyWith(_CalendarDayViewModel value, $Res Function(_CalendarDayViewModel) _then) = __$CalendarDayViewModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, int? memberColorIndex
});




}
/// @nodoc
class __$CalendarDayViewModelCopyWithImpl<$Res>
    implements _$CalendarDayViewModelCopyWith<$Res> {
  __$CalendarDayViewModelCopyWithImpl(this._self, this._then);

  final _CalendarDayViewModel _self;
  final $Res Function(_CalendarDayViewModel) _then;

/// Create a copy of CalendarDayViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? memberColorIndex = freezed,}) {
  return _then(_CalendarDayViewModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,memberColorIndex: freezed == memberColorIndex ? _self.memberColorIndex : memberColorIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
