// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 RotationId get rotationId; UserId get userId; RotationName get rotationName; RotationMemberNames get rotationMembers; RotationDays get rotationDays; NotificationTime get notificationTime; RotationIndex get currentRotationIndex; RotationCreatedAt get createdAt; RotationUpdatedAt get updatedAt; SkipEvents get skipEvents; String get displayDays; String get displayMembers; String get displayNotificationTime;
/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationResponseCopyWith<RotationResponse> get copyWith => _$RotationResponseCopyWithImpl<RotationResponse>(this as RotationResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMembers, rotationMembers) || other.rotationMembers == rotationMembers)&&(identical(other.rotationDays, rotationDays) || other.rotationDays == rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents)&&(identical(other.displayDays, displayDays) || other.displayDays == displayDays)&&(identical(other.displayMembers, displayMembers) || other.displayMembers == displayMembers)&&(identical(other.displayNotificationTime, displayNotificationTime) || other.displayNotificationTime == displayNotificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,rotationMembers,rotationDays,notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents,displayDays,displayMembers,displayNotificationTime);

@override
String toString() {
  return 'RotationResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents, displayDays: $displayDays, displayMembers: $displayMembers, displayNotificationTime: $displayNotificationTime)';
}


}

/// @nodoc
abstract mixin class $RotationResponseCopyWith<$Res>  {
  factory $RotationResponseCopyWith(RotationResponse value, $Res Function(RotationResponse) _then) = _$RotationResponseCopyWithImpl;
@useResult
$Res call({
 RotationId rotationId, UserId userId, RotationName rotationName, RotationMemberNames rotationMembers, RotationDays rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt, SkipEvents skipEvents, String displayDays, String displayMembers, String displayNotificationTime
});


$UserIdCopyWith<$Res> get userId;$RotationNameCopyWith<$Res> get rotationName;$RotationMemberNamesCopyWith<$Res> get rotationMembers;$RotationDaysCopyWith<$Res> get rotationDays;$NotificationTimeCopyWith<$Res> get notificationTime;$RotationIndexCopyWith<$Res> get currentRotationIndex;$SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class _$RotationResponseCopyWithImpl<$Res>
    implements $RotationResponseCopyWith<$Res> {
  _$RotationResponseCopyWithImpl(this._self, this._then);

  final RotationResponse _self;
  final $Res Function(RotationResponse) _then;

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,Object? displayDays = null,Object? displayMembers = null,Object? displayNotificationTime = null,}) {
  return _then(_self.copyWith(
rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as RotationDays,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,displayDays: null == displayDays ? _self.displayDays : displayDays // ignore: cast_nullable_to_non_nullable
as String,displayMembers: null == displayMembers ? _self.displayMembers : displayMembers // ignore: cast_nullable_to_non_nullable
as String,displayNotificationTime: null == displayNotificationTime ? _self.displayNotificationTime : displayNotificationTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationNameCopyWith<$Res> get rotationName {
  
  return $RotationNameCopyWith<$Res>(_self.rotationName, (value) {
    return _then(_self.copyWith(rotationName: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMembers {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMembers, (value) {
    return _then(_self.copyWith(rotationMembers: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<$Res> get rotationDays {
  
  return $RotationDaysCopyWith<$Res>(_self.rotationDays, (value) {
    return _then(_self.copyWith(rotationDays: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationIndexCopyWith<$Res> get currentRotationIndex {
  
  return $RotationIndexCopyWith<$Res>(_self.currentRotationIndex, (value) {
    return _then(_self.copyWith(currentRotationIndex: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<$Res> get skipEvents {
  
  return $SkipEventsCopyWith<$Res>(_self.skipEvents, (value) {
    return _then(_self.copyWith(skipEvents: value));
  });
}
}


/// Adds pattern-matching-related methods to [RotationResponse].
extension RotationResponsePatterns on RotationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RotationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RotationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RotationResponse value)  $default,){
final _that = this;
switch (_that) {
case _RotationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RotationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RotationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RotationId rotationId,  UserId userId,  RotationName rotationName,  RotationMemberNames rotationMembers,  RotationDays rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  SkipEvents skipEvents,  String displayDays,  String displayMembers,  String displayNotificationTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RotationResponse() when $default != null:
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.displayDays,_that.displayMembers,_that.displayNotificationTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RotationId rotationId,  UserId userId,  RotationName rotationName,  RotationMemberNames rotationMembers,  RotationDays rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  SkipEvents skipEvents,  String displayDays,  String displayMembers,  String displayNotificationTime)  $default,) {final _that = this;
switch (_that) {
case _RotationResponse():
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.displayDays,_that.displayMembers,_that.displayNotificationTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RotationId rotationId,  UserId userId,  RotationName rotationName,  RotationMemberNames rotationMembers,  RotationDays rotationDays,  NotificationTime notificationTime,  RotationIndex currentRotationIndex,  RotationCreatedAt createdAt,  RotationUpdatedAt updatedAt,  SkipEvents skipEvents,  String displayDays,  String displayMembers,  String displayNotificationTime)?  $default,) {final _that = this;
switch (_that) {
case _RotationResponse() when $default != null:
return $default(_that.rotationId,_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.currentRotationIndex,_that.createdAt,_that.updatedAt,_that.skipEvents,_that.displayDays,_that.displayMembers,_that.displayNotificationTime);case _:
  return null;

}
}

}

/// @nodoc


class _RotationResponse extends RotationResponse {
  const _RotationResponse({required this.rotationId, required this.userId, required this.rotationName, required this.rotationMembers, required this.rotationDays, required this.notificationTime, required this.currentRotationIndex, required this.createdAt, required this.updatedAt, required this.skipEvents, required this.displayDays, required this.displayMembers, required this.displayNotificationTime}): super._();
  

@override final  RotationId rotationId;
@override final  UserId userId;
@override final  RotationName rotationName;
@override final  RotationMemberNames rotationMembers;
@override final  RotationDays rotationDays;
@override final  NotificationTime notificationTime;
@override final  RotationIndex currentRotationIndex;
@override final  RotationCreatedAt createdAt;
@override final  RotationUpdatedAt updatedAt;
@override final  SkipEvents skipEvents;
@override final  String displayDays;
@override final  String displayMembers;
@override final  String displayNotificationTime;

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationResponseCopyWith<_RotationResponse> get copyWith => __$RotationResponseCopyWithImpl<_RotationResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationResponse&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMembers, rotationMembers) || other.rotationMembers == rotationMembers)&&(identical(other.rotationDays, rotationDays) || other.rotationDays == rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.currentRotationIndex, currentRotationIndex) || other.currentRotationIndex == currentRotationIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents)&&(identical(other.displayDays, displayDays) || other.displayDays == displayDays)&&(identical(other.displayMembers, displayMembers) || other.displayMembers == displayMembers)&&(identical(other.displayNotificationTime, displayNotificationTime) || other.displayNotificationTime == displayNotificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,rotationId,userId,rotationName,rotationMembers,rotationDays,notificationTime,currentRotationIndex,createdAt,updatedAt,skipEvents,displayDays,displayMembers,displayNotificationTime);

@override
String toString() {
  return 'RotationResponse(rotationId: $rotationId, userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, currentRotationIndex: $currentRotationIndex, createdAt: $createdAt, updatedAt: $updatedAt, skipEvents: $skipEvents, displayDays: $displayDays, displayMembers: $displayMembers, displayNotificationTime: $displayNotificationTime)';
}


}

/// @nodoc
abstract mixin class _$RotationResponseCopyWith<$Res> implements $RotationResponseCopyWith<$Res> {
  factory _$RotationResponseCopyWith(_RotationResponse value, $Res Function(_RotationResponse) _then) = __$RotationResponseCopyWithImpl;
@override @useResult
$Res call({
 RotationId rotationId, UserId userId, RotationName rotationName, RotationMemberNames rotationMembers, RotationDays rotationDays, NotificationTime notificationTime, RotationIndex currentRotationIndex, RotationCreatedAt createdAt, RotationUpdatedAt updatedAt, SkipEvents skipEvents, String displayDays, String displayMembers, String displayNotificationTime
});


@override $UserIdCopyWith<$Res> get userId;@override $RotationNameCopyWith<$Res> get rotationName;@override $RotationMemberNamesCopyWith<$Res> get rotationMembers;@override $RotationDaysCopyWith<$Res> get rotationDays;@override $NotificationTimeCopyWith<$Res> get notificationTime;@override $RotationIndexCopyWith<$Res> get currentRotationIndex;@override $SkipEventsCopyWith<$Res> get skipEvents;

}
/// @nodoc
class __$RotationResponseCopyWithImpl<$Res>
    implements _$RotationResponseCopyWith<$Res> {
  __$RotationResponseCopyWithImpl(this._self, this._then);

  final _RotationResponse _self;
  final $Res Function(_RotationResponse) _then;

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? currentRotationIndex = null,Object? createdAt = null,Object? updatedAt = null,Object? skipEvents = null,Object? displayDays = null,Object? displayMembers = null,Object? displayNotificationTime = null,}) {
  return _then(_RotationResponse(
rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as RotationId,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as RotationDays,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,currentRotationIndex: null == currentRotationIndex ? _self.currentRotationIndex : currentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,displayDays: null == displayDays ? _self.displayDays : displayDays // ignore: cast_nullable_to_non_nullable
as String,displayMembers: null == displayMembers ? _self.displayMembers : displayMembers // ignore: cast_nullable_to_non_nullable
as String,displayNotificationTime: null == displayNotificationTime ? _self.displayNotificationTime : displayNotificationTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationNameCopyWith<$Res> get rotationName {
  
  return $RotationNameCopyWith<$Res>(_self.rotationName, (value) {
    return _then(_self.copyWith(rotationName: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMembers {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMembers, (value) {
    return _then(_self.copyWith(rotationMembers: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<$Res> get rotationDays {
  
  return $RotationDaysCopyWith<$Res>(_self.rotationDays, (value) {
    return _then(_self.copyWith(rotationDays: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}/// Create a copy of RotationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationIndexCopyWith<$Res> get currentRotationIndex {
  
  return $RotationIndexCopyWith<$Res>(_self.currentRotationIndex, (value) {
    return _then(_self.copyWith(currentRotationIndex: value));
  });
}/// Create a copy of RotationResponse
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
