// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationResponse {

 String get rotationId; String get userId; String get rotationName; List<String> get rotationMembers; List<Weekday> get rotationDays; TimeOfDay get notificationTime; int get currentRotationIndex; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationResponseCopyWith<RotationResponse> get copyWith => _$RotationResponseCopyWithImpl<RotationResponse>(this as RotationResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMembers, rotationMembers)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,const DeepCollectionEquality().hash(rotationMembers),const DeepCollectionEquality().hash(rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt);

@override
String toString() {
  return 'RotationResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RotationResponseCopyWith<$Res>  {
  factory $RotationResponseCopyWith(RotationResponse value, $Res Function(RotationResponse) _then) = _$RotationResponseCopyWithImpl;
@useResult
$Res call({
 String rotationId, String userId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime, int currentRotationIndex, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$RotationResponseCopyWithImpl<$Res>
    implements $RotationResponseCopyWith<$Res> {
  _$RotationResponseCopyWithImpl(this._self, this._then);

  final RotationResponse _self;
  final $Res Function(RotationResponse) _then;

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _RotationResponse extends RotationResponse {
  const _RotationResponse({required this.rotationId, required this.userId, required this.rotationName, required final  List<String> rotationMembers, required final  List<Weekday> rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt}): _rotationMembers = rotationMembers,_rotationDays = rotationDays,super._();
  

@override final  String rotationId;
@override final  String userId;
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
@override final  int currentRotationIndex;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationResponseCopyWith<_RotationResponse> get copyWith => __$RotationResponseCopyWithImpl<_RotationResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMembers, _rotationMembers)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,const DeepCollectionEquality().hash(_rotationMembers),const DeepCollectionEquality().hash(_rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt);

@override
String toString() {
  return 'RotationResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RotationResponseCopyWith<$Res> implements $RotationResponseCopyWith<$Res> {
  factory _$RotationResponseCopyWith(_RotationResponse value, $Res Function(_RotationResponse) _then) = __$RotationResponseCopyWithImpl;
@override @useResult
$Res call({
 String rotationId, String userId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime, int currentRotationIndex, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$RotationResponseCopyWithImpl<$Res>
    implements _$RotationResponseCopyWith<$Res> {
  __$RotationResponseCopyWithImpl(this._self, this._then);

  final _RotationResponse _self;
  final $Res Function(_RotationResponse) _then;

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RotationResponse(
rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self._rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
