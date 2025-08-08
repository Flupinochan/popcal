// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_firebase_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationFirebaseResponse {

 RotationId? get rotationId; UserId get userId; RotationName get rotationName; List<RotationMemberName> get rotationMemberNames; List<int> get rotationDays; NotificationTime get notificationTime; RotationIndex get currentRotationIndex;// firestoreに保存する際はTimestampが適切
// Widget(UI)はDateTimeが適切
 RotationCreatedAt get createdAt; RotationUpdatedAt get updatedAt;
/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationFirebaseResponseCopyWith<RotationFirebaseResponse> get copyWith => _$RotationFirebaseResponseCopyWithImpl<RotationFirebaseResponse>(this as RotationFirebaseResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationFirebaseResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMemberNames, rotationMemberNames)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,const DeepCollectionEquality().hash(rotationMemberNames),const DeepCollectionEquality().hash(rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt);

@override
String toString() {
  return 'RotationFirebaseResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RotationFirebaseResponseCopyWith<$Res>  {
  factory $RotationFirebaseResponseCopyWith(RotationFirebaseResponse value, $Res Function(RotationFirebaseResponse) _then) = _$RotationFirebaseResponseCopyWithImpl;
@useResult
$Res call({
 RotationId? rotationId, UserId userId, RotationName rotationName, List<RotationMemberName> rotationMemberNames, List<int> rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt
});


$UserIdCopyWith<$Res> get userId;$RotationIndexCopyWith<$Res> get currentRotationIndex;

}
/// @nodoc
class _$RotationFirebaseResponseCopyWithImpl<$Res>
    implements $RotationFirebaseResponseCopyWith<$Res> {
  _$RotationFirebaseResponseCopyWithImpl(this._self, this._then);

  final RotationFirebaseResponse _self;
  final $Res Function(RotationFirebaseResponse) _then;

/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationId = freezed,Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as List<RotationMemberName>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<int>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,
  ));
}
/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationIndexCopyWith<$Res> get currentRotationIndex {
  
  return $RotationIndexCopyWith<$Res>(_self.currentRotationIndex, (value) {
    return _then(_self.copyWith(currentRotationIndex: value));
  });
}
}


/// @nodoc


class _RotationFirebaseResponse extends RotationFirebaseResponse {
  const _RotationFirebaseResponse({required this.rotationId, required this.userId, required this.rotationName, required final  List<RotationMemberName> rotationMemberNames, required final  List<int> rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt}): _rotationMemberNames = rotationMemberNames,_rotationDays = rotationDays,super._();
  

@override final  RotationId? rotationId;
@override final  UserId userId;
@override final  RotationName rotationName;
 final  List<RotationMemberName> _rotationMemberNames;
@override List<RotationMemberName> get rotationMemberNames {
  if (_rotationMemberNames is EqualUnmodifiableListView) return _rotationMemberNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationMemberNames);
}

 final  List<int> _rotationDays;
@override List<int> get rotationDays {
  if (_rotationDays is EqualUnmodifiableListView) return _rotationDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationDays);
}

@override final  NotificationTime notificationTime;
@override final  RotationIndex currentRotationIndex;
// firestoreに保存する際はTimestampが適切
// Widget(UI)はDateTimeが適切
@override final  RotationCreatedAt createdAt;
@override final  RotationUpdatedAt updatedAt;

/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationFirebaseResponseCopyWith<_RotationFirebaseResponse> get copyWith => __$RotationFirebaseResponseCopyWithImpl<_RotationFirebaseResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationFirebaseResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMemberNames, _rotationMemberNames)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,const DeepCollectionEquality().hash(_rotationMemberNames),const DeepCollectionEquality().hash(_rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt);

@override
String toString() {
  return 'RotationFirebaseResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RotationFirebaseResponseCopyWith<$Res> implements $RotationFirebaseResponseCopyWith<$Res> {
  factory _$RotationFirebaseResponseCopyWith(_RotationFirebaseResponse value, $Res Function(_RotationFirebaseResponse) _then) = __$RotationFirebaseResponseCopyWithImpl;
@override @useResult
$Res call({
 RotationId? rotationId, UserId userId, RotationName rotationName, List<RotationMemberName> rotationMemberNames, List<int> rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt
});


@override $UserIdCopyWith<$Res> get userId;@override $RotationIndexCopyWith<$Res> get currentRotationIndex;

}
/// @nodoc
class __$RotationFirebaseResponseCopyWithImpl<$Res>
    implements _$RotationFirebaseResponseCopyWith<$Res> {
  __$RotationFirebaseResponseCopyWithImpl(this._self, this._then);

  final _RotationFirebaseResponse _self;
  final $Res Function(_RotationFirebaseResponse) _then;

/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationId = freezed,Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RotationFirebaseResponse(
rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMemberNames: null == rotationMemberNames ? _self._rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as List<RotationMemberName>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<int>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,
  ));
}

/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationIndexCopyWith<$Res> get currentRotationIndex {
  
  return $RotationIndexCopyWith<$Res>(_self.currentRotationIndex, (value) {
    return _then(_self.copyWith(currentRotationIndex: value));
  });
}
}

// dart format on
