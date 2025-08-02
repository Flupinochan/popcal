// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarDataDto {

 UserViewModelDto get userViewModelDto; RotationGroup get rotationGroup; List<NotificationDetail> get notificationDetails;
/// Create a copy of CalendarDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDataDtoCopyWith<CalendarDataDto> get copyWith => _$CalendarDataDtoCopyWithImpl<CalendarDataDto>(this as CalendarDataDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDataDto&&(identical(other.userViewModelDto, userViewModelDto) || other.userViewModelDto == userViewModelDto)&&(identical(other.rotationGroup, rotationGroup) || other.rotationGroup == rotationGroup)&&const DeepCollectionEquality().equals(other.notificationDetails, notificationDetails));
}


@override
int get hashCode => Object.hash(runtimeType,userViewModelDto,rotationGroup,const DeepCollectionEquality().hash(notificationDetails));

@override
String toString() {
  return 'CalendarDataDto(userViewModelDto: $userViewModelDto, rotationGroup: $rotationGroup, notificationDetails: $notificationDetails)';
}


}

/// @nodoc
abstract mixin class $CalendarDataDtoCopyWith<$Res>  {
  factory $CalendarDataDtoCopyWith(CalendarDataDto value, $Res Function(CalendarDataDto) _then) = _$CalendarDataDtoCopyWithImpl;
@useResult
$Res call({
 UserViewModelDto userViewModelDto, RotationGroup rotationGroup, List<NotificationDetail> notificationDetails
});


$UserViewModelDtoCopyWith<$Res> get userViewModelDto;

}
/// @nodoc
class _$CalendarDataDtoCopyWithImpl<$Res>
    implements $CalendarDataDtoCopyWith<$Res> {
  _$CalendarDataDtoCopyWithImpl(this._self, this._then);

  final CalendarDataDto _self;
  final $Res Function(CalendarDataDto) _then;

/// Create a copy of CalendarDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userViewModelDto = null,Object? rotationGroup = null,Object? notificationDetails = null,}) {
  return _then(_self.copyWith(
userViewModelDto: null == userViewModelDto ? _self.userViewModelDto : userViewModelDto // ignore: cast_nullable_to_non_nullable
as UserViewModelDto,rotationGroup: null == rotationGroup ? _self.rotationGroup : rotationGroup // ignore: cast_nullable_to_non_nullable
as RotationGroup,notificationDetails: null == notificationDetails ? _self.notificationDetails : notificationDetails // ignore: cast_nullable_to_non_nullable
as List<NotificationDetail>,
  ));
}
/// Create a copy of CalendarDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserViewModelDtoCopyWith<$Res> get userViewModelDto {
  
  return $UserViewModelDtoCopyWith<$Res>(_self.userViewModelDto, (value) {
    return _then(_self.copyWith(userViewModelDto: value));
  });
}
}


/// @nodoc


class _CalendarDataDto extends CalendarDataDto {
  const _CalendarDataDto({required this.userViewModelDto, required this.rotationGroup, required final  List<NotificationDetail> notificationDetails}): _notificationDetails = notificationDetails,super._();
  

@override final  UserViewModelDto userViewModelDto;
@override final  RotationGroup rotationGroup;
 final  List<NotificationDetail> _notificationDetails;
@override List<NotificationDetail> get notificationDetails {
  if (_notificationDetails is EqualUnmodifiableListView) return _notificationDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationDetails);
}


/// Create a copy of CalendarDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDataDtoCopyWith<_CalendarDataDto> get copyWith => __$CalendarDataDtoCopyWithImpl<_CalendarDataDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDataDto&&(identical(other.userViewModelDto, userViewModelDto) || other.userViewModelDto == userViewModelDto)&&(identical(other.rotationGroup, rotationGroup) || other.rotationGroup == rotationGroup)&&const DeepCollectionEquality().equals(other._notificationDetails, _notificationDetails));
}


@override
int get hashCode => Object.hash(runtimeType,userViewModelDto,rotationGroup,const DeepCollectionEquality().hash(_notificationDetails));

@override
String toString() {
  return 'CalendarDataDto(userViewModelDto: $userViewModelDto, rotationGroup: $rotationGroup, notificationDetails: $notificationDetails)';
}


}

/// @nodoc
abstract mixin class _$CalendarDataDtoCopyWith<$Res> implements $CalendarDataDtoCopyWith<$Res> {
  factory _$CalendarDataDtoCopyWith(_CalendarDataDto value, $Res Function(_CalendarDataDto) _then) = __$CalendarDataDtoCopyWithImpl;
@override @useResult
$Res call({
 UserViewModelDto userViewModelDto, RotationGroup rotationGroup, List<NotificationDetail> notificationDetails
});


@override $UserViewModelDtoCopyWith<$Res> get userViewModelDto;

}
/// @nodoc
class __$CalendarDataDtoCopyWithImpl<$Res>
    implements _$CalendarDataDtoCopyWith<$Res> {
  __$CalendarDataDtoCopyWithImpl(this._self, this._then);

  final _CalendarDataDto _self;
  final $Res Function(_CalendarDataDto) _then;

/// Create a copy of CalendarDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userViewModelDto = null,Object? rotationGroup = null,Object? notificationDetails = null,}) {
  return _then(_CalendarDataDto(
userViewModelDto: null == userViewModelDto ? _self.userViewModelDto : userViewModelDto // ignore: cast_nullable_to_non_nullable
as UserViewModelDto,rotationGroup: null == rotationGroup ? _self.rotationGroup : rotationGroup // ignore: cast_nullable_to_non_nullable
as RotationGroup,notificationDetails: null == notificationDetails ? _self._notificationDetails : notificationDetails // ignore: cast_nullable_to_non_nullable
as List<NotificationDetail>,
  ));
}

/// Create a copy of CalendarDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserViewModelDtoCopyWith<$Res> get userViewModelDto {
  
  return $UserViewModelDtoCopyWith<$Res>(_self.userViewModelDto, (value) {
    return _then(_self.copyWith(userViewModelDto: value));
  });
}
}

// dart format on
