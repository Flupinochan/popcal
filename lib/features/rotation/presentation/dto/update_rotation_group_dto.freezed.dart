// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_rotation_group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateRotationGroupDto {

 String get userId; String get rotationGroupId; String get rotationName; List<String> get rotationMembers; List<Weekday> get rotationDays; TimeOfDay get notificationTime;
/// Create a copy of UpdateRotationGroupDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateRotationGroupDtoCopyWith<UpdateRotationGroupDto> get copyWith => _$UpdateRotationGroupDtoCopyWithImpl<UpdateRotationGroupDto>(this as UpdateRotationGroupDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateRotationGroupDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationGroupId, rotationGroupId) || other.rotationGroupId == rotationGroupId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMembers, rotationMembers)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationGroupId,rotationName,const DeepCollectionEquality().hash(rotationMembers),const DeepCollectionEquality().hash(rotationDays),notificationTime);

@override
String toString() {
  return 'UpdateRotationGroupDto(userId: $userId, rotationGroupId: $rotationGroupId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class $UpdateRotationGroupDtoCopyWith<$Res>  {
  factory $UpdateRotationGroupDtoCopyWith(UpdateRotationGroupDto value, $Res Function(UpdateRotationGroupDto) _then) = _$UpdateRotationGroupDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String rotationGroupId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime
});




}
/// @nodoc
class _$UpdateRotationGroupDtoCopyWithImpl<$Res>
    implements $UpdateRotationGroupDtoCopyWith<$Res> {
  _$UpdateRotationGroupDtoCopyWithImpl(this._self, this._then);

  final UpdateRotationGroupDto _self;
  final $Res Function(UpdateRotationGroupDto) _then;

/// Create a copy of UpdateRotationGroupDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rotationGroupId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationGroupId: null == rotationGroupId ? _self.rotationGroupId : rotationGroupId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,
  ));
}

}


/// @nodoc


class _UpdateRotationGroupDto extends UpdateRotationGroupDto {
  const _UpdateRotationGroupDto({required this.userId, required this.rotationGroupId, required this.rotationName, required final  List<String> rotationMembers, required final  List<Weekday> rotationDays, required this.notificationTime}): _rotationMembers = rotationMembers,_rotationDays = rotationDays,super._();
  

@override final  String userId;
@override final  String rotationGroupId;
@override final  String rotationName;
 final  List<String> _rotationMembers;
@override List<String> get rotationMembers {
  if (_rotationMembers is EqualUnmodifiableListView) return _rotationMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationMembers);
}

 final  List<Weekday> _rotationDays;
@override List<Weekday> get rotationDays {
  if (_rotationDays is EqualUnmodifiableListView) return _rotationDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationDays);
}

@override final  TimeOfDay notificationTime;

/// Create a copy of UpdateRotationGroupDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateRotationGroupDtoCopyWith<_UpdateRotationGroupDto> get copyWith => __$UpdateRotationGroupDtoCopyWithImpl<_UpdateRotationGroupDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateRotationGroupDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationGroupId, rotationGroupId) || other.rotationGroupId == rotationGroupId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMembers, _rotationMembers)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationGroupId,rotationName,const DeepCollectionEquality().hash(_rotationMembers),const DeepCollectionEquality().hash(_rotationDays),notificationTime);

@override
String toString() {
  return 'UpdateRotationGroupDto(userId: $userId, rotationGroupId: $rotationGroupId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class _$UpdateRotationGroupDtoCopyWith<$Res> implements $UpdateRotationGroupDtoCopyWith<$Res> {
  factory _$UpdateRotationGroupDtoCopyWith(_UpdateRotationGroupDto value, $Res Function(_UpdateRotationGroupDto) _then) = __$UpdateRotationGroupDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String rotationGroupId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime
});




}
/// @nodoc
class __$UpdateRotationGroupDtoCopyWithImpl<$Res>
    implements _$UpdateRotationGroupDtoCopyWith<$Res> {
  __$UpdateRotationGroupDtoCopyWithImpl(this._self, this._then);

  final _UpdateRotationGroupDto _self;
  final $Res Function(_UpdateRotationGroupDto) _then;

/// Create a copy of UpdateRotationGroupDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rotationGroupId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,}) {
  return _then(_UpdateRotationGroupDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationGroupId: null == rotationGroupId ? _self.rotationGroupId : rotationGroupId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self._rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,
  ));
}


}

// dart format on
