// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTime {

 int get hour; int get minute;
/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<NotificationTime> get copyWith => _$NotificationTimeCopyWithImpl<NotificationTime>(this as NotificationTime, _$identity);

  /// Serializes this NotificationTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'NotificationTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $NotificationTimeCopyWith<$Res>  {
  factory $NotificationTimeCopyWith(NotificationTime value, $Res Function(NotificationTime) _then) = _$NotificationTimeCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$NotificationTimeCopyWithImpl<$Res>
    implements $NotificationTimeCopyWith<$Res> {
  _$NotificationTimeCopyWithImpl(this._self, this._then);

  final NotificationTime _self;
  final $Res Function(NotificationTime) _then;

/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_self.copyWith(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTime].
extension NotificationTimePatterns on NotificationTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTime value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTime value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int hour,  int minute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTime() when $default != null:
return $default(_that.hour,_that.minute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int hour,  int minute)  $default,) {final _that = this;
switch (_that) {
case _NotificationTime():
return $default(_that.hour,_that.minute);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int hour,  int minute)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTime() when $default != null:
return $default(_that.hour,_that.minute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTime extends NotificationTime {
  const _NotificationTime({required this.hour, required this.minute}): super._();
  factory _NotificationTime.fromJson(Map<String, dynamic> json) => _$NotificationTimeFromJson(json);

@override final  int hour;
@override final  int minute;

/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTimeCopyWith<_NotificationTime> get copyWith => __$NotificationTimeCopyWithImpl<_NotificationTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'NotificationTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$NotificationTimeCopyWith<$Res> implements $NotificationTimeCopyWith<$Res> {
  factory _$NotificationTimeCopyWith(_NotificationTime value, $Res Function(_NotificationTime) _then) = __$NotificationTimeCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$NotificationTimeCopyWithImpl<$Res>
    implements _$NotificationTimeCopyWith<$Res> {
  __$NotificationTimeCopyWithImpl(this._self, this._then);

  final _NotificationTime _self;
  final $Res Function(_NotificationTime) _then;

/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_NotificationTime(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
