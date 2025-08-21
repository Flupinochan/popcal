// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deadline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Deadline {

 bool get isEnabled; NotificationTime get notificationTime;
/// Create a copy of Deadline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeadlineCopyWith<Deadline> get copyWith => _$DeadlineCopyWithImpl<Deadline>(this as Deadline, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Deadline&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled,notificationTime);

@override
String toString() {
  return 'Deadline(isEnabled: $isEnabled, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class $DeadlineCopyWith<$Res>  {
  factory $DeadlineCopyWith(Deadline value, $Res Function(Deadline) _then) = _$DeadlineCopyWithImpl;
@useResult
$Res call({
 bool isEnabled, NotificationTime notificationTime
});


$NotificationTimeCopyWith<$Res> get notificationTime;

}
/// @nodoc
class _$DeadlineCopyWithImpl<$Res>
    implements $DeadlineCopyWith<$Res> {
  _$DeadlineCopyWithImpl(this._self, this._then);

  final Deadline _self;
  final $Res Function(Deadline) _then;

/// Create a copy of Deadline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,Object? notificationTime = null,}) {
  return _then(_self.copyWith(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,
  ));
}
/// Create a copy of Deadline
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get notificationTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.notificationTime, (value) {
    return _then(_self.copyWith(notificationTime: value));
  });
}
}


/// Adds pattern-matching-related methods to [Deadline].
extension DeadlinePatterns on Deadline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Deadline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Deadline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Deadline value)  $default,){
final _that = this;
switch (_that) {
case _Deadline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Deadline value)?  $default,){
final _that = this;
switch (_that) {
case _Deadline() when $default != null:
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
case _Deadline() when $default != null:
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
case _Deadline():
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
case _Deadline() when $default != null:
return $default(_that.isEnabled,_that.notificationTime);case _:
  return null;

}
}

}

/// @nodoc


class _Deadline extends Deadline {
  const _Deadline({required this.isEnabled, required this.notificationTime}): super._();
  

@override final  bool isEnabled;
@override final  NotificationTime notificationTime;

/// Create a copy of Deadline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeadlineCopyWith<_Deadline> get copyWith => __$DeadlineCopyWithImpl<_Deadline>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Deadline&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled,notificationTime);

@override
String toString() {
  return 'Deadline(isEnabled: $isEnabled, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class _$DeadlineCopyWith<$Res> implements $DeadlineCopyWith<$Res> {
  factory _$DeadlineCopyWith(_Deadline value, $Res Function(_Deadline) _then) = __$DeadlineCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled, NotificationTime notificationTime
});


@override $NotificationTimeCopyWith<$Res> get notificationTime;

}
/// @nodoc
class __$DeadlineCopyWithImpl<$Res>
    implements _$DeadlineCopyWith<$Res> {
  __$DeadlineCopyWithImpl(this._self, this._then);

  final _Deadline _self;
  final $Res Function(_Deadline) _then;

/// Create a copy of Deadline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,Object? notificationTime = null,}) {
  return _then(_Deadline(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,
  ));
}

/// Create a copy of Deadline
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
