// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_firebase_mapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationFirebaseMapper {

 String get rotationId; String get userId; String get rotationName; List<String> get rotationMemberNames; List<Weekday> get rotationDays; TimeOfDay get notificationTime; int get currentRotationIndex; DateTime get createdAt; DateTime get updatedAt; SkipEvents get skipEvents;
/// Create a copy of RotationFirebaseMapper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationFirebaseMapperCopyWith<RotationFirebaseMapper> get copyWith => _$RotationFirebaseMapperCopyWithImpl<RotationFirebaseMapper>(this as RotationFirebaseMapper, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationFirebaseMapper&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMemberNames, rotationMemberNames)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,const DeepCollectionEquality().hash(rotationMemberNames),const DeepCollectionEquality().hash(rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents);

@override
String toString() {
  return 'RotationFirebaseMapper(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents)';
}


}

/// @nodoc
abstract mixin class $RotationFirebaseMapperCopyWith<$Res>  {
  factory $RotationFirebaseMapperCopyWith(RotationFirebaseMapper value, $Res Function(RotationFirebaseMapper) _then) = _$RotationFirebaseMapperCopyWithImpl;
@useResult
$Res call({
 String rotationId, String userId, String rotationName, List<String> rotationMemberNames, List<Weekday> rotationDays, TimeOfDay notificationTime, int currentRotationIndex, DateTime createdAt, DateTime updatedAt, SkipEvents skipEvents
});


$SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class _$RotationFirebaseMapperCopyWithImpl<$Res>
    implements $RotationFirebaseMapperCopyWith<$Res> {
  _$RotationFirebaseMapperCopyWithImpl(this._self, this._then);

  final RotationFirebaseMapper _self;
  final $Res Function(RotationFirebaseMapper) _then;

/// Create a copy of RotationFirebaseMapper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,}) {
  return _then(_self.copyWith(
rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,
  ));
}
/// Create a copy of RotationFirebaseMapper
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<$Res> get skipEvents {
  
  return $SkipEventsCopyWith<$Res>(_self.skipEvents, (value) {
    return _then(_self.copyWith(skipEvents: value));
  });
}
}


/// Adds pattern-matching-related methods to [RotationFirebaseMapper].
extension RotationFirebaseMapperPatterns on RotationFirebaseMapper {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RotationFirebaseMapper value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RotationFirebaseMapper() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RotationFirebaseMapper value)  $default,){
final _that = this;
switch (_that) {
case _RotationFirebaseMapper():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RotationFirebaseMapper value)?  $default,){
final _that = this;
switch (_that) {
case _RotationFirebaseMapper() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rotationId,  String userId,  String rotationName,  List<String> rotationMemberNames,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  int currentRotationIndex,  DateTime createdAt,  DateTime updatedAt,  SkipEvents skipEvents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RotationFirebaseMapper() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rotationId,  String userId,  String rotationName,  List<String> rotationMemberNames,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  int currentRotationIndex,  DateTime createdAt,  DateTime updatedAt,  SkipEvents skipEvents)  $default,) {final _that = this;
switch (_that) {
case _RotationFirebaseMapper():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rotationId,  String userId,  String rotationName,  List<String> rotationMemberNames,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  int currentRotationIndex,  DateTime createdAt,  DateTime updatedAt,  SkipEvents skipEvents)?  $default,) {final _that = this;
switch (_that) {
case _RotationFirebaseMapper() when $default != null:
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents);case _:
  return null;

}
}

}

/// @nodoc


class _RotationFirebaseMapper extends RotationFirebaseMapper {
  const _RotationFirebaseMapper({required this.rotationId, required this.userId, required this.rotationName, required final  List<String> rotationMemberNames, required final  List<Weekday> rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt, required this.skipEvents}): _rotationMemberNames = rotationMemberNames,_rotationDays = rotationDays,super._();
  

@override final  String rotationId;
@override final  String userId;
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

/// Create a copy of RotationFirebaseMapper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationFirebaseMapperCopyWith<_RotationFirebaseMapper> get copyWith => __$RotationFirebaseMapperCopyWithImpl<_RotationFirebaseMapper>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationFirebaseMapper&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMemberNames, _rotationMemberNames)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,const DeepCollectionEquality().hash(_rotationMemberNames),const DeepCollectionEquality().hash(_rotationDays),notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents);

@override
String toString() {
  return 'RotationFirebaseMapper(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents)';
}


}

/// @nodoc
abstract mixin class _$RotationFirebaseMapperCopyWith<$Res> implements $RotationFirebaseMapperCopyWith<$Res> {
  factory _$RotationFirebaseMapperCopyWith(_RotationFirebaseMapper value, $Res Function(_RotationFirebaseMapper) _then) = __$RotationFirebaseMapperCopyWithImpl;
@override @useResult
$Res call({
 String rotationId, String userId, String rotationName, List<String> rotationMemberNames, List<Weekday> rotationDays, TimeOfDay notificationTime, int currentRotationIndex, DateTime createdAt, DateTime updatedAt, SkipEvents skipEvents
});


@override $SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class __$RotationFirebaseMapperCopyWithImpl<$Res>
    implements _$RotationFirebaseMapperCopyWith<$Res> {
  __$RotationFirebaseMapperCopyWithImpl(this._self, this._then);

  final _RotationFirebaseMapper _self;
  final $Res Function(_RotationFirebaseMapper) _then;

/// Create a copy of RotationFirebaseMapper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,}) {
  return _then(_RotationFirebaseMapper(
rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMemberNames: null == rotationMemberNames ? _self._rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,
  ));
}

/// Create a copy of RotationFirebaseMapper
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
