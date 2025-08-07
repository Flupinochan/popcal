// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_rotation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateRotationRequest {

 String get userId; String get rotationName; List<String> get rotationMembers; List<Weekday> get rotationDays; TimeOfDay get notificationTime;
/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateRotationRequestCopyWith<CreateRotationRequest> get copyWith => _$CreateRotationRequestCopyWithImpl<CreateRotationRequest>(this as CreateRotationRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateRotationRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMembers, rotationMembers)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,const DeepCollectionEquality().hash(rotationMembers),const DeepCollectionEquality().hash(rotationDays),notificationTime);

@override
String toString() {
  return 'CreateRotationRequest(userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class $CreateRotationRequestCopyWith<$Res>  {
  factory $CreateRotationRequestCopyWith(CreateRotationRequest value, $Res Function(CreateRotationRequest) _then) = _$CreateRotationRequestCopyWithImpl;
@useResult
$Res call({
 String userId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime
});




}
/// @nodoc
class _$CreateRotationRequestCopyWithImpl<$Res>
    implements $CreateRotationRequestCopyWith<$Res> {
  _$CreateRotationRequestCopyWithImpl(this._self, this._then);

  final CreateRotationRequest _self;
  final $Res Function(CreateRotationRequest) _then;

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,
  ));
}

}


/// @nodoc


class _CreateRotationRequest extends CreateRotationRequest {
  const _CreateRotationRequest({required this.userId, required this.rotationName, required final  List<String> rotationMembers, required final  List<Weekday> rotationDays, required this.notificationTime}): _rotationMembers = rotationMembers,_rotationDays = rotationDays,super._();
  

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

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateRotationRequestCopyWith<_CreateRotationRequest> get copyWith => __$CreateRotationRequestCopyWithImpl<_CreateRotationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateRotationRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMembers, _rotationMembers)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,const DeepCollectionEquality().hash(_rotationMembers),const DeepCollectionEquality().hash(_rotationDays),notificationTime);

@override
String toString() {
  return 'CreateRotationRequest(userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class _$CreateRotationRequestCopyWith<$Res> implements $CreateRotationRequestCopyWith<$Res> {
  factory _$CreateRotationRequestCopyWith(_CreateRotationRequest value, $Res Function(_CreateRotationRequest) _then) = __$CreateRotationRequestCopyWithImpl;
@override @useResult
$Res call({
 String userId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime
});




}
/// @nodoc
class __$CreateRotationRequestCopyWithImpl<$Res>
    implements _$CreateRotationRequestCopyWith<$Res> {
  __$CreateRotationRequestCopyWithImpl(this._self, this._then);

  final _CreateRotationRequest _self;
  final $Res Function(_CreateRotationRequest) _then;

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,}) {
  return _then(_CreateRotationRequest(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self._rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,
  ));
}


}

// dart format on
