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

 String get userId; String get rotationName; List<String> get rotationMembers; List<Weekday> get rotationDays; TimeOfDay get notificationTime; SkipEvents get skipEvents;
/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateRotationRequestCopyWith<CreateRotationRequest> get copyWith => _$CreateRotationRequestCopyWithImpl<CreateRotationRequest>(this as CreateRotationRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateRotationRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other.rotationMembers, rotationMembers)&&const DeepCollectionEquality().equals(other.rotationDays, rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,const DeepCollectionEquality().hash(rotationMembers),const DeepCollectionEquality().hash(rotationDays),notificationTime,skipEvents);

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
 String userId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime, SkipEvents skipEvents
});


$SkipEventsCopyWith<$Res> get skipEvents;

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
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self.rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self.rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,
  ));
}
/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<$Res> get skipEvents {
  
  return $SkipEventsCopyWith<$Res>(_self.skipEvents, (value) {
    return _then(_self.copyWith(skipEvents: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String rotationName,  List<String> rotationMembers,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  SkipEvents skipEvents)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String rotationName,  List<String> rotationMembers,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  SkipEvents skipEvents)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String rotationName,  List<String> rotationMembers,  List<Weekday> rotationDays,  TimeOfDay notificationTime,  SkipEvents skipEvents)?  $default,) {final _that = this;
switch (_that) {
case _CreateRotationRequest() when $default != null:
return $default(_that.userId,_that.rotationName,_that.rotationMembers,_that.rotationDays,_that.notificationTime,_that.skipEvents);case _:
  return null;

}
}

}

/// @nodoc


class _CreateRotationRequest extends CreateRotationRequest {
  const _CreateRotationRequest({required this.userId, required this.rotationName, required final  List<String> rotationMembers, required final  List<Weekday> rotationDays, required this.notificationTime, required this.skipEvents}): _rotationMembers = rotationMembers,_rotationDays = rotationDays,super._();
  

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
@override final  SkipEvents skipEvents;

/// Create a copy of CreateRotationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateRotationRequestCopyWith<_CreateRotationRequest> get copyWith => __$CreateRotationRequestCopyWithImpl<_CreateRotationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateRotationRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&const DeepCollectionEquality().equals(other._rotationMembers, _rotationMembers)&&const DeepCollectionEquality().equals(other._rotationDays, _rotationDays)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.skipEvents, skipEvents) || other.skipEvents == skipEvents));
}


@override
int get hashCode => Object.hash(runtimeType,userId,rotationName,const DeepCollectionEquality().hash(_rotationMembers),const DeepCollectionEquality().hash(_rotationDays),notificationTime,skipEvents);

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
 String userId, String rotationName, List<String> rotationMembers, List<Weekday> rotationDays, TimeOfDay notificationTime, SkipEvents skipEvents
});


@override $SkipEventsCopyWith<$Res> get skipEvents;

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
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,rotationMembers: null == rotationMembers ? _self._rotationMembers : rotationMembers // ignore: cast_nullable_to_non_nullable
as List<String>,rotationDays: null == rotationDays ? _self._rotationDays : rotationDays // ignore: cast_nullable_to_non_nullable
as List<Weekday>,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,skipEvents: null == skipEvents ? _self.skipEvents : skipEvents // ignore: cast_nullable_to_non_nullable
as SkipEvents,
  ));
}

/// Create a copy of CreateRotationRequest
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
