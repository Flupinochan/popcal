// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_group_firebase_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationGroupFirebaseResponse {

 String? get rotationGroupId; String get userId; String get rotationName; List<String> get rotationMembers; List<int> get rotationDays; Map<String, int> get notificationTime; int get currentRotationIndex;// firestoreに保存する際はTimestampが適切
// Widget(UI)はDateTimeが適切
 Timestamp get createdAt; Timestamp get updatedAt;
/// Create a copy of RotationGroupFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationGroupFirebaseResponseCopyWith<RotationGroupFirebaseResponse> get copyWith => _$RotationGroupFirebaseResponseCopyWithImpl<RotationGroupFirebaseResponse>(this as RotationGroupFirebaseResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationGroupFirebaseResponse&&(identical(other.rotationGroupId, rotationGroupId) || other.rotationGroupId == rotationGroupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMembers, rotationMembers)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&const DeepCollectionEquality().equals(other.notificationTime, notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,rotationGroupId,userId,rotationName,const DeepCollectionEquality().hash(rotationMembers),const DeepCollectionEquality().hash(rotationDays),const DeepCollectionEquality().hash(notificationTime),currentRotationIndex,createdAt,updatedAt);

@override
String toString() {
  return 'RotationGroupFirebaseResponse(rotationGroupId: $rotationGroupId, userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RotationGroupFirebaseResponseCopyWith<$Res>  {
  factory $RotationGroupFirebaseResponseCopyWith(RotationGroupFirebaseResponse value, $Res Function(RotationGroupFirebaseResponse) _then) = _$RotationGroupFirebaseResponseCopyWithImpl;
@useResult
$Res call({
 String? rotationGroupId, String userId, String rotationName, List<String> rotationMembers, List<int> rotationDays, Map<String, int> notificationTime, int currentRotationIndex, Timestamp createdAt, Timestamp updatedAt
});




}
/// @nodoc
class _$RotationGroupFirebaseResponseCopyWithImpl<$Res>
    implements $RotationGroupFirebaseResponseCopyWith<$Res> {
  _$RotationGroupFirebaseResponseCopyWithImpl(this._self, this._then);

  final RotationGroupFirebaseResponse _self;
  final $Res Function(RotationGroupFirebaseResponse) _then;

/// Create a copy of RotationGroupFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationGroupId = freezed,Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
rotationGroupId: freezed == rotationGroupId ? _self.rotationGroupId : rotationGroupId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<int>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as Map<String, int>,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// @nodoc


class _RotationGroupFirebaseResponse extends RotationGroupFirebaseResponse {
  const _RotationGroupFirebaseResponse({required this.rotationGroupId, required this.userId, required this.rotationName, required final  List<String> rotationMembers, required final  List<int> rotationDays, required final  Map<String, int> notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt}): _rotationMembers = rotationMembers,_rotationDays = rotationDays,_notificationTime = notificationTime,super._();
  

@override final  String? rotationGroupId;
@override final  String userId;
@override final  String rotationName;
 final  List<String> _rotationMembers;
@override List<String> get rotationMembers {
  if (_rotationMembers is EqualUnmodifiableListView) return _rotationMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationMembers);
}

 final  List<int> _rotationDays;
@override List<int> get rotationDays {
  if (_rotationDays is EqualUnmodifiableListView) return _rotationDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationDays);
}

 final  Map<String, int> _notificationTime;
@override Map<String, int> get notificationTime {
  if (_notificationTime is EqualUnmodifiableMapView) return _notificationTime;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_notificationTime);
}

@override final  int currentRotationIndex;
// firestoreに保存する際はTimestampが適切
// Widget(UI)はDateTimeが適切
@override final  Timestamp createdAt;
@override final  Timestamp updatedAt;

/// Create a copy of RotationGroupFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationGroupFirebaseResponseCopyWith<_RotationGroupFirebaseResponse> get copyWith => __$RotationGroupFirebaseResponseCopyWithImpl<_RotationGroupFirebaseResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationGroupFirebaseResponse&&(identical(other.rotationGroupId, rotationGroupId) || other.rotationGroupId == rotationGroupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMembers, _rotationMembers)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&const DeepCollectionEquality().equals(other._notificationTime, _notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,rotationGroupId,userId,rotationName,const DeepCollectionEquality().hash(_rotationMembers),const DeepCollectionEquality().hash(_rotationDays),const DeepCollectionEquality().hash(_notificationTime),currentRotationIndex,createdAt,updatedAt);

@override
String toString() {
  return 'RotationGroupFirebaseResponse(rotationGroupId: $rotationGroupId, userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RotationGroupFirebaseResponseCopyWith<$Res> implements $RotationGroupFirebaseResponseCopyWith<$Res> {
  factory _$RotationGroupFirebaseResponseCopyWith(_RotationGroupFirebaseResponse value, $Res Function(_RotationGroupFirebaseResponse) _then) = __$RotationGroupFirebaseResponseCopyWithImpl;
@override @useResult
$Res call({
 String? rotationGroupId, String userId, String rotationName, List<String> rotationMembers, List<int> rotationDays, Map<String, int> notificationTime, int currentRotationIndex, Timestamp createdAt, Timestamp updatedAt
});




}
/// @nodoc
class __$RotationGroupFirebaseResponseCopyWithImpl<$Res>
    implements _$RotationGroupFirebaseResponseCopyWith<$Res> {
  __$RotationGroupFirebaseResponseCopyWithImpl(this._self, this._then);

  final _RotationGroupFirebaseResponse _self;
  final $Res Function(_RotationGroupFirebaseResponse) _then;

/// Create a copy of RotationGroupFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationGroupId = freezed,Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RotationGroupFirebaseResponse(
rotationGroupId: freezed == rotationGroupId ? _self.rotationGroupId : rotationGroupId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self._rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<int>,notificationTime: null == notificationTime ? _self._notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as Map<String, int>,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
