// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 UserId get userId; RotationName get rotationName; RotationMemberNames get rotationMembers; RotationDays get rotationDays; NotificationTime get notificationTime; List<SkipEvent> get skipEvents;
/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateRotationRequestCopyWith<CreateRotationRequest> get copyWith => _$CreateRotationRequestCopyWithImpl<CreateRotationRequest>(this as CreateRotationRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateRotationRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMembers, rotationMembers) || other.rotationMembers == rotationMembers)&&(identical(other.rotationDays, rotationDays) || other.rotationDays == rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&const DeepCollectionEquality().equals(other.skipEvents, skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,rotationMembers,rotationDays,notificationTime,const DeepCollectionEquality().hash(skipEvents));

@override
String toString() {
  return 'CreateRotationRequest(userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, skipEvents: $skipEvents)';
}


}

/// @nodoc
abstract mixin class $CreateRotationRequestCopyWith<$Res>  {
  factory $CreateRotationRequestCopyWith(CreateRotationRequest value, $Res Function(CreateRotationRequest) _then) = _$CreateRotationRequestCopyWithImpl;
@useResult
$Res call({
 UserId userId, RotationName rotationName, RotationMemberNames rotationMembers, RotationDays rotationDays, NotificationTime notificationTime, List<SkipEvent> skipEvents
});


$UserIdCopyWith<$Res> get userId;$RotationNameCopyWith<$Res> get rotationName;$RotationMemberNamesCopyWith<$Res> get rotationMembers;$RotationDaysCopyWith<$Res> get rotationDays;

}
/// @nodoc
class _$CreateRotationRequestCopyWithImpl<$Res>
    implements $CreateRotationRequestCopyWith<$Res> {
  _$CreateRotationRequestCopyWithImpl(this._self, this._then);

  final CreateRotationRequest _self;
  final $Res Function(CreateRotationRequest) _then;

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? skipEvents = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as RotationDays,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as List<SkipEvent>,
  ));
}
/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationNameCopyWith<$Res> get rotationName {
  
  return $RotationNameCopyWith<$Res>(_self.rotationName, (value) {
    return _then(_self.copyWith(rotationName: value));
  });
}/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMembers {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMembers, (value) {
    return _then(_self.copyWith(rotationMembers: value));
  });
}/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<$Res> get rotationDays {
  
  return $RotationDaysCopyWith<$Res>(_self.rotationDays, (value) {
    return _then(_self.copyWith(rotationDays: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateRotationRequest].
extension CreateRotationRequestPatterns on CreateRotationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateRotationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateRotationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateRotationRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateRotationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateRotationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateRotationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserId userId,  RotationName rotationName,  RotationMemberNames rotationMembers,  RotationDays rotationDays,  NotificationTime notificationTime,  List<SkipEvent> skipEvents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateRotationRequest() when $default != null:
return $default(_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.skipEvents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserId userId,  RotationName rotationName,  RotationMemberNames rotationMembers,  RotationDays rotationDays,  NotificationTime notificationTime,  List<SkipEvent> skipEvents)  $default,) {final _that = this;
switch (_that) {
case _CreateRotationRequest():
return $default(_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.skipEvents);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserId userId,  RotationName rotationName,  RotationMemberNames rotationMembers,  RotationDays rotationDays,  NotificationTime notificationTime,  List<SkipEvent> skipEvents)?  $default,) {final _that = this;
switch (_that) {
case _CreateRotationRequest() when $default != null:
return $default(_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.skipEvents);case _:
  return null;

}
}

}

/// @nodoc


class _CreateRotationRequest extends CreateRotationRequest {
  const _CreateRotationRequest({required this.userId, required this.rotationName, required this.rotationMembers, required this.rotationDays, required this.notificationTime, required final  List<SkipEvent> skipEvents}): _skipEvents = skipEvents,super._();
  

@override final  UserId userId;
@override final  RotationName rotationName;
@override final  RotationMemberNames rotationMembers;
@override final  RotationDays rotationDays;
@override final  NotificationTime notificationTime;
 final  List<SkipEvent> _skipEvents;
@override List<SkipEvent> get skipEvents {
  if (_skipEvents is EqualUnmodifiableListView) return _skipEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skipEvents);
}


/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateRotationRequestCopyWith<_CreateRotationRequest> get copyWith => __$CreateRotationRequestCopyWithImpl<_CreateRotationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateRotationRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.rotationMembers, rotationMembers) || other.rotationMembers == rotationMembers)&&(identical(other.rotationDays, rotationDays) || other.rotationDays == rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&const DeepCollectionEquality().equals(other._skipEvents, _skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,rotationMembers,rotationDays,notificationTime,const DeepCollectionEquality().hash(_skipEvents));

@override
String toString() {
  return 'CreateRotationRequest(userId: $userId, rotationName: $rotationName, rotationMembers: $rotationMembers, rotationDays: $rotationDays, notificationTime: $notificationTime, skipEvents: $skipEvents)';
}


}

/// @nodoc
abstract mixin class _$CreateRotationRequestCopyWith<$Res> implements $CreateRotationRequestCopyWith<$Res> {
  factory _$CreateRotationRequestCopyWith(_CreateRotationRequest value, $Res Function(_CreateRotationRequest) _then) = __$CreateRotationRequestCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, RotationName rotationName, RotationMemberNames rotationMembers, RotationDays rotationDays, NotificationTime notificationTime, List<SkipEvent> skipEvents
});


@override $UserIdCopyWith<$Res> get userId;@override $RotationNameCopyWith<$Res> get rotationName;@override $RotationMemberNamesCopyWith<$Res> get rotationMembers;@override $RotationDaysCopyWith<$Res> get rotationDays;

}
/// @nodoc
class __$CreateRotationRequestCopyWithImpl<$Res>
    implements _$CreateRotationRequestCopyWith<$Res> {
  __$CreateRotationRequestCopyWithImpl(this._self, this._then);

  final _CreateRotationRequest _self;
  final $Res Function(_CreateRotationRequest) _then;

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rotationName = null,Object? rotationMembers = null,Object? rotationDays = null,Object? notificationTime = null,Object? skipEvents = null,}) {
  return _then(_CreateRotationRequest(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as RotationName,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as RotationMemberNames,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as RotationDays,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,skipEvents: null == skipEvents ? _self._skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as List<SkipEvent>,
  ));
}

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationNameCopyWith<$Res> get rotationName {
  
  return $RotationNameCopyWith<$Res>(_self.rotationName, (value) {
    return _then(_self.copyWith(rotationName: value));
  });
}/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<$Res> get rotationMembers {
  
  return $RotationMemberNamesCopyWith<$Res>(_self.rotationMembers, (value) {
    return _then(_self.copyWith(rotationMembers: value));
  });
}/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<$Res> get rotationDays {
  
  return $RotationDaysCopyWith<$Res>(_self.rotationDays, (value) {
    return _then(_self.copyWith(rotationDays: value));
  });
}
}

// dart format on
