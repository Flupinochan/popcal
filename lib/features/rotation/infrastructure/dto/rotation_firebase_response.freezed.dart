// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 RotationId? get rotationId; UserId get userId; RotationName get rotationName; RotationMemberNames get rotationMemberNames; List<int> get rotationDays; NotificationTime get notificationTime; RotationIndex get currentRotationIndex;// firestoreに保存する際はTimestampが適切
// Widget(UI)はDateTimeが適切
 RotationCreatedAt get createdAt; RotationUpdatedAt get updatedAt; List<SkipEvent> get skipEvents;
/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationFirebaseResponseCopyWith<RotationFirebaseResponse> get copyWith => _$RotationFirebaseResponseCopyWithImpl<RotationFirebaseResponse>(this as RotationFirebaseResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationFirebaseResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMemberNames, rotationMemberNames) || other.rotationMemberNames == rotationMemberNames)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.skipEvents, skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,rotationMemberNames,const DeepCollectionEquality().hash(rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt,const DeepCollectionEquality().hash(skipEvents));

@override
String toString() {
  return 'RotationFirebaseResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents)';
}


}

/// @nodoc
abstract mixin class $RotationFirebaseResponseCopyWith<$Res>  {
  factory $RotationFirebaseResponseCopyWith(RotationFirebaseResponse value, $Res Function(RotationFirebaseResponse) _then) = _$RotationFirebaseResponseCopyWithImpl;
@useResult
$Res call({
 RotationId? rotationId, UserId userId, RotationName rotationName, RotationMemberNames rotationMemberNames, List<int> rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt, List<SkipEvent> skipEvents
});


$UserIdCopyWith<$Res> get userId;$RotationNameCopyWith<$Res> get rotationName;$RotationMemberNamesCopyWith<$Res> get rotationMemberNames;$RotationIndexCopyWith<$Res> get currentRotationIndex;

}
/// @nodoc
class _$RotationFirebaseResponseCopyWithImpl<$Res>
    implements $RotationFirebaseResponseCopyWith<$Res> {
  _$RotationFirebaseResponseCopyWithImpl(this._self, this._then);

  final RotationFirebaseResponse _self;
  final $Res Function(RotationFirebaseResponse) _then;

/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationId = freezed,Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,}) {
  return _then(_self.copyWith(
rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<int>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as List<SkipEvent>,
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
$RotationNameCopyWith<$Res> get rotationName {
  
  return $RotationNameCopyWith<$Res>(_self.rotationName, (value) {
    return _then(_self.copyWith(rotationName: value));
  });
}/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMemberNames {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMemberNames, (value) {
    return _then(_self.copyWith(rotationMemberNames: value));
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


/// Adds pattern-matching-related methods to [RotationFirebaseResponse].
extension RotationFirebaseResponsePatterns on RotationFirebaseResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RotationFirebaseResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RotationFirebaseResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RotationFirebaseResponse value)  $default,){
final _that = this;
switch (_that) {
case _RotationFirebaseResponse():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RotationFirebaseResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RotationFirebaseResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RotationId? rotationId,  UserId userId,  RotationName rotationName,  RotationMemberNames rotationMemberNames,  List<int> rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  List<SkipEvent> skipEvents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RotationFirebaseResponse() when $default != null:
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RotationId? rotationId,  UserId userId,  RotationName rotationName,  RotationMemberNames rotationMemberNames,  List<int> rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  List<SkipEvent> skipEvents)  $default,) {final _that = this;
switch (_that) {
case _RotationFirebaseResponse():
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RotationId? rotationId,  UserId userId,  RotationName rotationName,  RotationMemberNames rotationMemberNames,  List<int> rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  List<SkipEvent> skipEvents)?  $default,) {final _that = this;
switch (_that) {
case _RotationFirebaseResponse() when $default != null:
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents);case _:
  return null;

}
}

}

/// @nodoc


class _RotationFirebaseResponse extends RotationFirebaseResponse {
  const _RotationFirebaseResponse({required this.rotationId, required this.userId, required this.rotationName, required this.rotationMemberNames, required final  List<int> rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt, required final  List<SkipEvent> skipEvents}): _rotationDays = rotationDays,_skipEvents = skipEvents,super._();
  

@override final  RotationId? rotationId;
@override final  UserId userId;
@override final  RotationName rotationName;
@override final  RotationMemberNames rotationMemberNames;
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
 final  List<SkipEvent> _skipEvents;
@override List<SkipEvent> get skipEvents {
  if (_skipEvents is EqualUnmodifiableListView) return _skipEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skipEvents);
}


/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationFirebaseResponseCopyWith<_RotationFirebaseResponse> get copyWith => __$RotationFirebaseResponseCopyWithImpl<_RotationFirebaseResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationFirebaseResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMemberNames, rotationMemberNames) || other.rotationMemberNames == rotationMemberNames)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._skipEvents, _skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,rotationMemberNames,const DeepCollectionEquality().hash(_rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt,const DeepCollectionEquality().hash(_skipEvents));

@override
String toString() {
  return 'RotationFirebaseResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents)';
}


}

/// @nodoc
abstract mixin class _$RotationFirebaseResponseCopyWith<$Res> implements $RotationFirebaseResponseCopyWith<$Res> {
  factory _$RotationFirebaseResponseCopyWith(_RotationFirebaseResponse value, $Res Function(_RotationFirebaseResponse) _then) = __$RotationFirebaseResponseCopyWithImpl;
@override @useResult
$Res call({
 RotationId? rotationId, UserId userId, RotationName rotationName, RotationMemberNames rotationMemberNames, List<int> rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt, List<SkipEvent> skipEvents
});


@override $UserIdCopyWith<$Res> get userId;@override $RotationNameCopyWith<$Res> get rotationName;@override $RotationMemberNamesCopyWith<$Res> get rotationMemberNames;@override $RotationIndexCopyWith<$Res> get currentRotationIndex;

}
/// @nodoc
class __$RotationFirebaseResponseCopyWithImpl<$Res>
    implements _$RotationFirebaseResponseCopyWith<$Res> {
  __$RotationFirebaseResponseCopyWithImpl(this._self, this._then);

  final _RotationFirebaseResponse _self;
  final $Res Function(_RotationFirebaseResponse) _then;

/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationId = freezed,Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,}) {
  return _then(_RotationFirebaseResponse(
rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<int>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,skipEvents: null == skipEvents ? _self._skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as List<SkipEvent>,
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
$RotationNameCopyWith<$Res> get rotationName {
  
  return $RotationNameCopyWith<$Res>(_self.rotationName, (value) {
    return _then(_self.copyWith(rotationName: value));
  });
}/// Create a copy of RotationFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMemberNames {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMemberNames, (value) {
    return _then(_self.copyWith(rotationMemberNames: value));
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
