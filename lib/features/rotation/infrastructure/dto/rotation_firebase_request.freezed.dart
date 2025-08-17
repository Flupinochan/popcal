// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_firebase_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationFirebaseRequest {

 String get rotationName; List<String> get rotationMemberNames; List<Weekday> get rotationDays; TimeOfDay get notificationTime; int get currentRotationIndex; DateTime get createdAt; DateTime get updatedAt; SkipEvents get skipEvents; String get userId; String? get rotationId;
/// Create a copy of RotationFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationFirebaseRequestCopyWith<RotationFirebaseRequest> get copyWith => _$RotationFirebaseRequestCopyWithImpl<RotationFirebaseRequest>(this as RotationFirebaseRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationFirebaseRequest&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMemberNames, rotationMemberNames)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId));
}


@override
int get hashCode => Object.hash(runtimeType,rotationName,const DeepCollectionEquality().hash(rotationMemberNames),const DeepCollectionEquality().hash(rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents,userId,rotationId);

@override
String toString() {
  return 'RotationFirebaseRequest(rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents, userId: $userId, rotationId: $rotationId)';
}


}

/// @nodoc
abstract mixin class $RotationFirebaseRequestCopyWith<$Res>  {
  factory $RotationFirebaseRequestCopyWith(RotationFirebaseRequest value, $Res Function(RotationFirebaseRequest) _then) = _$RotationFirebaseRequestCopyWithImpl;
@useResult
$Res call({
 String rotationName, List<String> rotationMemberNames, List<Weekday> rotationDays, TimeOfDay notificationTime, int currentRotationIndex, DateTime createdAt, DateTime updatedAt, SkipEvents skipEvents, String userId, String? rotationId
});


$SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class _$RotationFirebaseRequestCopyWithImpl<$Res>
    implements $RotationFirebaseRequestCopyWith<$Res> {
  _$RotationFirebaseRequestCopyWithImpl(this._self, this._then);

  final RotationFirebaseRequest _self;
  final $Res Function(RotationFirebaseRequest) _then;

/// Create a copy of RotationFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,Object? userId = null,Object? rotationId = freezed,}) {
  return _then(_self.copyWith(
rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RotationFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<$Res> get skipEvents {
  
  return $SkipEventsCopyWith<$Res>(_self.skipEvents, (value) {
    return _then(_self.copyWith(skipEvents: value));
  });
}
}


/// Adds pattern-matching-related methods to [RotationFirebaseRequest].
extension RotationFirebaseRequestPatterns on RotationFirebaseRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RotationFirebaseRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RotationFirebaseRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RotationFirebaseRequest value)  $default,){
final _that = this;
switch (_that) {
case _RotationFirebaseRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RotationFirebaseRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RotationFirebaseRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rotationName,  List<String> rotationMemberNames,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  int currentRotationIndex,  DateTime createdAt,  DateTime updatedAt,  SkipEvents skipEvents,  String userId,  String? rotationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RotationFirebaseRequest() when $default != null:
return $default(_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.userId,_that.rotationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rotationName,  List<String> rotationMemberNames,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  int currentRotationIndex,  DateTime createdAt,  DateTime updatedAt,  SkipEvents skipEvents,  String userId,  String? rotationId)  $default,) {final _that = this;
switch (_that) {
case _RotationFirebaseRequest():
return $default(_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.userId,_that.rotationId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rotationName,  List<String> rotationMemberNames,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  int currentRotationIndex,  DateTime createdAt,  DateTime updatedAt,  SkipEvents skipEvents,  String userId,  String? rotationId)?  $default,) {final _that = this;
switch (_that) {
case _RotationFirebaseRequest() when $default != null:
return $default(_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.userId,_that.rotationId);case _:
  return null;

}
}

}

/// @nodoc


class _RotationFirebaseRequest extends RotationFirebaseRequest {
  const _RotationFirebaseRequest({required this.rotationName, required final  List<String> rotationMemberNames, required final  List<Weekday> rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt, required this.skipEvents, required this.userId, this.rotationId}): _rotationMemberNames = rotationMemberNames,_rotationDays = rotationDays,super._();
  

@override final  String rotationName;
 final  List<String> _rotationMemberNames;
@override List<String> get rotationMemberNames {
  if (_rotationMemberNames is EqualUnmodifiableListView) return _rotationMemberNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rotationMemberNames);
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
@override final  SkipEvents skipEvents;
@override final  String userId;
@override final  String? rotationId;

/// Create a copy of RotationFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationFirebaseRequestCopyWith<_RotationFirebaseRequest> get copyWith => __$RotationFirebaseRequestCopyWithImpl<_RotationFirebaseRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationFirebaseRequest&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMemberNames, _rotationMemberNames)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId));
}


@override
int get hashCode => Object.hash(runtimeType,rotationName,const DeepCollectionEquality().hash(_rotationMemberNames),const DeepCollectionEquality().hash(_rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents,userId,rotationId);

@override
String toString() {
  return 'RotationFirebaseRequest(rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents, userId: $userId, rotationId: $rotationId)';
}


}

/// @nodoc
abstract mixin class _$RotationFirebaseRequestCopyWith<$Res> implements $RotationFirebaseRequestCopyWith<$Res> {
  factory _$RotationFirebaseRequestCopyWith(_RotationFirebaseRequest value, $Res Function(_RotationFirebaseRequest) _then) = __$RotationFirebaseRequestCopyWithImpl;
@override @useResult
$Res call({
 String rotationName, List<String> rotationMemberNames, List<Weekday> rotationDays, TimeOfDay notificationTime, int currentRotationIndex, DateTime createdAt, DateTime updatedAt, SkipEvents skipEvents, String userId, String? rotationId
});


@override $SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class __$RotationFirebaseRequestCopyWithImpl<$Res>
    implements _$RotationFirebaseRequestCopyWith<$Res> {
  __$RotationFirebaseRequestCopyWithImpl(this._self, this._then);

  final _RotationFirebaseRequest _self;
  final $Res Function(_RotationFirebaseRequest) _then;

/// Create a copy of RotationFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,Object? userId = null,Object? rotationId = freezed,}) {
  return _then(_RotationFirebaseRequest(
rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMemberNames: null == rotationMemberNames ? _self._rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RotationFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<$Res> get skipEvents {
  
  return $SkipEventsCopyWith<$Res>(_self.skipEvents, (value) {
    return _then(_self.copyWith(skipEvents: value));
  });
}
}

// dart format on
