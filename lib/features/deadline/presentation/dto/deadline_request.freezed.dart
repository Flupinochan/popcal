// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deadline_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeadlineRequest {

 bool get isEnabled; NotificationTime get notificationTime;
/// Create a copy of DeadlineRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeadlineRequestCopyWith<DeadlineRequest> get copyWith => _$DeadlineRequestCopyWithImpl<DeadlineRequest>(this as DeadlineRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeadlineRequest&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled,notificationTime);

@override
String toString() {
  return 'DeadlineRequest(isEnabled: $isEnabled, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class $DeadlineRequestCopyWith<$Res>  {
  factory $DeadlineRequestCopyWith(DeadlineRequest value, $Res Function(DeadlineRequest) _then) = _$DeadlineRequestCopyWithImpl;
@useResult
$Res call({
 bool isEnabled, NotificationTime notificationTime
});


$NotificationTimeCopyWith<$Res> get notificationTime;

}
/// @nodoc
class _$DeadlineRequestCopyWithImpl<$Res>
    implements $DeadlineRequestCopyWith<$Res> {
  _$DeadlineRequestCopyWithImpl(this._self, this._then);

  final DeadlineRequest _self;
  final $Res Function(DeadlineRequest) _then;

/// Create a copy of DeadlineRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,Object? notificationTime = null,}) {
  return _then(_self.copyWith(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,
  ));
}
/// Create a copy of DeadlineRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeadlineRequest].
extension DeadlineRequestPatterns on DeadlineRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeadlineRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeadlineRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeadlineRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeadlineRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeadlineRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeadlineRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isEnabled,  NotificationTime notificationTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeadlineRequest() when $default != null:
return $default(_that.isEnabled,_that.notificationTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isEnabled,  NotificationTime notificationTime)  $default,) {final _that = this;
switch (_that) {
case _DeadlineRequest():
return $default(_that.isEnabled,_that.notificationTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isEnabled,  NotificationTime notificationTime)?  $default,) {final _that = this;
switch (_that) {
case _DeadlineRequest() when $default != null:
return $default(_that.isEnabled,_that.notificationTime);case _:
  return null;

}
}

}

/// @nodoc


class _DeadlineRequest extends DeadlineRequest {
   _DeadlineRequest({required this.isEnabled, required this.notificationTime}): super._();
  

@override final  bool isEnabled;
@override final  NotificationTime notificationTime;

/// Create a copy of DeadlineRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeadlineRequestCopyWith<_DeadlineRequest> get copyWith => __$DeadlineRequestCopyWithImpl<_DeadlineRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeadlineRequest&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled,notificationTime);

@override
String toString() {
  return 'DeadlineRequest(isEnabled: $isEnabled, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class _$DeadlineRequestCopyWith<$Res> implements $DeadlineRequestCopyWith<$Res> {
  factory _$DeadlineRequestCopyWith(_DeadlineRequest value, $Res Function(_DeadlineRequest) _then) = __$DeadlineRequestCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled, NotificationTime notificationTime
});


@override $NotificationTimeCopyWith<$Res> get notificationTime;

}
/// @nodoc
class __$DeadlineRequestCopyWithImpl<$Res>
    implements _$DeadlineRequestCopyWith<$Res> {
  __$DeadlineRequestCopyWithImpl(this._self, this._then);

  final _DeadlineRequest _self;
  final $Res Function(_DeadlineRequest) _then;

/// Create a copy of DeadlineRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,Object? notificationTime = null,}) {
  return _then(_DeadlineRequest(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,
  ));
}

/// Create a copy of DeadlineRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}
}

// dart format on
