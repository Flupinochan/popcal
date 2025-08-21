// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Rotation {

 UserId get userId; RotationName get rotationName; RotationMemberNames get rotationMemberNames; RotationDays get rotationDays; NotificationTime get notificationTime; RotationIndex get currentRotationIndex; RotationCreatedAt get createdAt; RotationUpdatedAt get updatedAt; SkipEvents get skipEvents;// RotationIdはfirebaseの機能によって作成されるため、作成時はoptional
 RotationId? get rotationId;
/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationCopyWith<Rotation> get copyWith => _$RotationCopyWithImpl<Rotation>(this as Rotation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rotation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMemberNames, rotationMemberNames) || other.rotationMemberNames == rotationMemberNames)&&(identical(other.rotationDays, rotationDays) || other.rotationDays == rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents)&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,rotationMemberNames,rotationDays,notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents,rotationId);

@override
String toString() {
  return 'Rotation(userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents, rotationId: $rotationId)';
}


}

/// @nodoc
abstract mixin class $RotationCopyWith<$Res>  {
  factory $RotationCopyWith(Rotation value, $Res Function(Rotation) _then) = _$RotationCopyWithImpl;
@useResult
$Res call({
 UserId userId, RotationName rotationName, RotationMemberNames rotationMemberNames, RotationDays rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt, SkipEvents skipEvents, RotationId? rotationId
});


$RotationMemberNamesCopyWith<$Res> get rotationMemberNames;$RotationDaysCopyWith<$Res> get rotationDays;$NotificationTimeCopyWith<$Res> get notificationTime;$SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class _$RotationCopyWithImpl<$Res>
    implements $RotationCopyWith<$Res> {
  _$RotationCopyWithImpl(this._self, this._then);

  final Rotation _self;
  final $Res Function(Rotation) _then;

/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,Object? rotationId = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as RotationDays,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId?,
  ));
}
/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMemberNames {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMemberNames, (value) {
    return _then(_self.copyWith(rotationMemberNames: value));
  });
}/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<$Res> get rotationDays {
  
  return $RotationDaysCopyWith<$Res>(_self.rotationDays, (value) {
    return _then(_self.copyWith(rotationDays: value));
  });
}/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<$Res> get skipEvents {
  
  return $SkipEventsCopyWith<$Res>(_self.skipEvents, (value) {
    return _then(_self.copyWith(skipEvents: value));
  });
}
}


/// Adds pattern-matching-related methods to [Rotation].
extension RotationPatterns on Rotation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rotation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rotation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rotation value)  $default,){
final _that = this;
switch (_that) {
case _Rotation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rotation value)?  $default,){
final _that = this;
switch (_that) {
case _Rotation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserId userId,  RotationName rotationName,  RotationMemberNames rotationMemberNames,  RotationDays rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  SkipEvents skipEvents,  RotationId? rotationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rotation() when $default != null:
return $default(_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.rotationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserId userId,  RotationName rotationName,  RotationMemberNames rotationMemberNames,  RotationDays rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  SkipEvents skipEvents,  RotationId? rotationId)  $default,) {final _that = this;
switch (_that) {
case _Rotation():
return $default(_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.rotationId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserId userId,  RotationName rotationName,  RotationMemberNames rotationMemberNames,  RotationDays rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  SkipEvents skipEvents,  RotationId? rotationId)?  $default,) {final _that = this;
switch (_that) {
case _Rotation() when $default != null:
return $default(_that.userId,_that.rotationName,_that.rotationMemberNames,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.rotationId);case _:
  return null;

}
}

}

/// @nodoc


class _Rotation extends Rotation {
   _Rotation({required this.userId, required this.rotationName, required this.rotationMemberNames, required this.rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt, required this.skipEvents, this.rotationId}): super._();
  

@override final  UserId userId;
@override final  RotationName rotationName;
@override final  RotationMemberNames rotationMemberNames;
@override final  RotationDays rotationDays;
@override final  NotificationTime notificationTime;
@override final  RotationIndex currentRotationIndex;
@override final  RotationCreatedAt createdAt;
@override final  RotationUpdatedAt updatedAt;
@override final  SkipEvents skipEvents;
// RotationIdはfirebaseの機能によって作成されるため、作成時はoptional
@override final  RotationId? rotationId;

/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationCopyWith<_Rotation> get copyWith => __$RotationCopyWithImpl<_Rotation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rotation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMemberNames, rotationMemberNames) || other.rotationMemberNames == rotationMemberNames)&&(identical(other.rotationDays, rotationDays) || other.rotationDays == rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents)&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,rotationMemberNames,rotationDays,notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents,rotationId);

@override
String toString() {
  return 'Rotation(userId: $userId, rotationName: $rotationName, rotationMemberNames: $rotationMemberNames, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents, rotationId: $rotationId)';
}


}

/// @nodoc
abstract mixin class _$RotationCopyWith<$Res> implements $RotationCopyWith<$Res> {
  factory _$RotationCopyWith(_Rotation value, $Res Function(_Rotation) _then) = __$RotationCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, RotationName rotationName, RotationMemberNames rotationMemberNames, RotationDays rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt, SkipEvents skipEvents, RotationId? rotationId
});


@override $RotationMemberNamesCopyWith<$Res> get rotationMemberNames;@override $RotationDaysCopyWith<$Res> get rotationDays;@override $NotificationTimeCopyWith<$Res> get notificationTime;@override $SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class __$RotationCopyWithImpl<$Res>
    implements _$RotationCopyWith<$Res> {
  __$RotationCopyWithImpl(this._self, this._then);

  final _Rotation _self;
  final $Res Function(_Rotation) _then;

/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rotationName = null,Object? rotationMemberNames = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,Object? rotationId = freezed,}) {
  return _then(_Rotation(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMemberNames: null == rotationMemberNames ? _self.rotationMemberNames : rotationMemberNames // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as RotationDays,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,rotationId: freezed == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId?,
  ));
}

/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMemberNames {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMemberNames, (value) {
    return _then(_self.copyWith(rotationMemberNames: value));
  });
}/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<$Res> get rotationDays {
  
  return $RotationDaysCopyWith<$Res>(_self.rotationDays, (value) {
    return _then(_self.copyWith(rotationDays: value));
  });
}/// Create a copy of Rotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}/// Create a copy of Rotation
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
