// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarDataModel {

 UserResponse get userViewModelDto; RotationGroup get rotationGroup; Map<String, CalendarDayViewModel> get dayInfoMap;
/// Create a copy of CalendarDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDataModelCopyWith<CalendarDataModel> get copyWith => _$CalendarDataModelCopyWithImpl<CalendarDataModel>(this as CalendarDataModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDataModel&&(identical(other.userViewModelDto, userViewModelDto) || other.userViewModelDto == userViewModelDto)&&(identical(other.rotationGroup, rotationGroup) || other.rotationGroup == rotationGroup)&&const DeepCollectionEquality().equals(other.dayInfoMap, dayInfoMap));
}


@override
int get hashCode => Object.hash(runtimeType,userViewModelDto,rotationGroup,const DeepCollectionEquality().hash(dayInfoMap));

@override
String toString() {
  return 'CalendarDataModel(userViewModelDto: $userViewModelDto, rotationGroup: $rotationGroup, dayInfoMap: $dayInfoMap)';
}


}

/// @nodoc
abstract mixin class $CalendarDataModelCopyWith<$Res>  {
  factory $CalendarDataModelCopyWith(CalendarDataModel value, $Res Function(CalendarDataModel) _then) = _$CalendarDataModelCopyWithImpl;
@useResult
$Res call({
 UserResponse userViewModelDto, RotationGroup rotationGroup, Map<String, CalendarDayViewModel> dayInfoMap
});


$UserResponseCopyWith<$Res> get userViewModelDto;

}
/// @nodoc
class _$CalendarDataModelCopyWithImpl<$Res>
    implements $CalendarDataModelCopyWith<$Res> {
  _$CalendarDataModelCopyWithImpl(this._self, this._then);

  final CalendarDataModel _self;
  final $Res Function(CalendarDataModel) _then;

/// Create a copy of CalendarDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userViewModelDto = null,Object? rotationGroup = null,Object? dayInfoMap = null,}) {
  return _then(_self.copyWith(
userViewModelDto: null == userViewModelDto ? _self.userViewModelDto : userViewModelDto // ignore: cast_nullable_to_non_nullable
as UserResponse,rotationGroup: null == rotationGroup ? _self.rotationGroup : rotationGroup // ignore: cast_nullable_to_non_nullable
as RotationGroup,dayInfoMap: null == dayInfoMap ? _self.dayInfoMap : dayInfoMap // ignore: cast_nullable_to_non_nullable
as Map<String, CalendarDayViewModel>,
  ));
}
/// Create a copy of CalendarDataModel
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


class _CalendarDataModel extends CalendarDataModel {
  const _CalendarDataModel({required this.userViewModelDto, required this.rotationGroup, required final  Map<String, CalendarDayViewModel> dayInfoMap}): _dayInfoMap = dayInfoMap,super._();
  

@override final  UserResponse userViewModelDto;
@override final  RotationGroup rotationGroup;
 final  Map<String, CalendarDayViewModel> _dayInfoMap;
@override Map<String, CalendarDayViewModel> get dayInfoMap {
  if (_dayInfoMap is EqualUnmodifiableMapView) return _dayInfoMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dayInfoMap);
}


/// Create a copy of CalendarDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDataModelCopyWith<_CalendarDataModel> get copyWith => __$CalendarDataModelCopyWithImpl<_CalendarDataModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDataModel&&(identical(other.userViewModelDto, userViewModelDto) || other.userViewModelDto == userViewModelDto)&&(identical(other.rotationGroup, rotationGroup) || other.rotationGroup == rotationGroup)&&const DeepCollectionEquality().equals(other._dayInfoMap, _dayInfoMap));
}


@override
int get hashCode => Object.hash(runtimeType,userViewModelDto,rotationGroup,const DeepCollectionEquality().hash(_dayInfoMap));

@override
String toString() {
  return 'CalendarDataModel(userViewModelDto: $userViewModelDto, rotationGroup: $rotationGroup, dayInfoMap: $dayInfoMap)';
}


}

/// @nodoc
abstract mixin class _$CalendarDataModelCopyWith<$Res> implements $CalendarDataModelCopyWith<$Res> {
  factory _$CalendarDataModelCopyWith(_CalendarDataModel value, $Res Function(_CalendarDataModel) _then) = __$CalendarDataModelCopyWithImpl;
@override @useResult
$Res call({
 UserResponse userViewModelDto, RotationGroup rotationGroup, Map<String, CalendarDayViewModel> dayInfoMap
});


@override $UserResponseCopyWith<$Res> get userViewModelDto;

}
/// @nodoc
class __$CalendarDataModelCopyWithImpl<$Res>
    implements _$CalendarDataModelCopyWith<$Res> {
  __$CalendarDataModelCopyWithImpl(this._self, this._then);

  final _CalendarDataModel _self;
  final $Res Function(_CalendarDataModel) _then;

/// Create a copy of CalendarDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userViewModelDto = null,Object? rotationGroup = null,Object? dayInfoMap = null,}) {
  return _then(_CalendarDataModel(
userViewModelDto: null == userViewModelDto ? _self.userViewModelDto : userViewModelDto // ignore: cast_nullable_to_non_nullable
as UserResponse,rotationGroup: null == rotationGroup ? _self.rotationGroup : rotationGroup // ignore: cast_nullable_to_non_nullable
as RotationGroup,dayInfoMap: null == dayInfoMap ? _self._dayInfoMap : dayInfoMap // ignore: cast_nullable_to_non_nullable
as Map<String, CalendarDayViewModel>,
  ));
}

/// Create a copy of CalendarDataModel
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
mixin _$CalendarDayDto {

 DateTime get date; String? get memberName; bool get isRotationDay; String get displayText;
/// Create a copy of CalendarDayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayDtoCopyWith<CalendarDayDto> get copyWith => _$CalendarDayDtoCopyWithImpl<CalendarDayDto>(this as CalendarDayDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDayDto&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.displayText, displayText) || other.displayText == displayText));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,displayText);

@override
String toString() {
  return 'CalendarDayDto(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, displayText: $displayText)';
}


}

/// @nodoc
abstract mixin class $CalendarDayDtoCopyWith<$Res>  {
  factory $CalendarDayDtoCopyWith(CalendarDayDto value, $Res Function(CalendarDayDto) _then) = _$CalendarDayDtoCopyWithImpl;
@useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, String displayText
});




}
/// @nodoc
class _$CalendarDayDtoCopyWithImpl<$Res>
    implements $CalendarDayDtoCopyWith<$Res> {
  _$CalendarDayDtoCopyWithImpl(this._self, this._then);

  final CalendarDayDto _self;
  final $Res Function(CalendarDayDto) _then;

/// Create a copy of CalendarDayDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? displayText = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,displayText: null == displayText ? _self.displayText : displayText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _CalendarDayDto implements CalendarDayDto {
  const _CalendarDayDto({required this.date, required this.memberName, required this.isRotationDay, required this.displayText});
  

@override final  DateTime date;
@override final  String? memberName;
@override final  bool isRotationDay;
@override final  String displayText;

/// Create a copy of CalendarDayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayDtoCopyWith<_CalendarDayDto> get copyWith => __$CalendarDayDtoCopyWithImpl<_CalendarDayDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDayDto&&(identical(other.date, date) || other.date == date)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.isRotationDay, isRotationDay) || other.isRotationDay == isRotationDay)&&(identical(other.displayText, displayText) || other.displayText == displayText));
}


@override
int get hashCode => Object.hash(runtimeType,date,memberName,isRotationDay,displayText);

@override
String toString() {
  return 'CalendarDayDto(date: $date, memberName: $memberName, isRotationDay: $isRotationDay, displayText: $displayText)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayDtoCopyWith<$Res> implements $CalendarDayDtoCopyWith<$Res> {
  factory _$CalendarDayDtoCopyWith(_CalendarDayDto value, $Res Function(_CalendarDayDto) _then) = __$CalendarDayDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String? memberName, bool isRotationDay, String displayText
});




}
/// @nodoc
class __$CalendarDayDtoCopyWithImpl<$Res>
    implements _$CalendarDayDtoCopyWith<$Res> {
  __$CalendarDayDtoCopyWithImpl(this._self, this._then);

  final _CalendarDayDto _self;
  final $Res Function(_CalendarDayDto) _then;

/// Create a copy of CalendarDayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? memberName = freezed,Object? isRotationDay = null,Object? displayText = null,}) {
  return _then(_CalendarDayDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: freezed == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String?,isRotationDay: null == isRotationDay ? _self.isRotationDay : isRotationDay // ignore: cast_nullable_to_non_nullable
as bool,displayText: null == displayText ? _self.displayText : displayText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
