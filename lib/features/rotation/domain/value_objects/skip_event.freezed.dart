// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkipEvent {

 DateKey get dateKey; DayType get dayType; SkipCount get skipCount;
/// Create a copy of SkipEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipEventCopyWith<SkipEvent> get copyWith => _$SkipEventCopyWithImpl<SkipEvent>(this as SkipEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipEvent&&(identical(other.dateKey, dateKey) || other.dateKey == dateKey)&&(identical(other.dayType, dayType) || other.dayType == dayType)&&(identical(other.skipCount, skipCount) || other.skipCount == skipCount));
}


@override
int get hashCode => Object.hash(runtimeType,dateKey,dayType,skipCount);

@override
String toString() {
  return 'SkipEvent(dateKey: $dateKey, dayType: $dayType, skipCount: $skipCount)';
}


}

/// @nodoc
abstract mixin class $SkipEventCopyWith<$Res>  {
  factory $SkipEventCopyWith(SkipEvent value, $Res Function(SkipEvent) _then) = _$SkipEventCopyWithImpl;
@useResult
$Res call({
 DateKey dateKey, DayType dayType, SkipCount skipCount
});




}
/// @nodoc
class _$SkipEventCopyWithImpl<$Res>
    implements $SkipEventCopyWith<$Res> {
  _$SkipEventCopyWithImpl(this._self, this._then);

  final SkipEvent _self;
  final $Res Function(SkipEvent) _then;

/// Create a copy of SkipEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateKey = null,Object? dayType = null,Object? skipCount = null,}) {
  return _then(_self.copyWith(
dateKey: null == dateKey ? _self.dateKey : dateKey // ignore: cast_nullable_to_non_nullable
as DateKey,dayType: null == dayType ? _self.dayType : dayType // ignore: cast_nullable_to_non_nullable
as DayType,skipCount: null == skipCount ? _self.skipCount : skipCount // ignore: cast_nullable_to_non_nullable
as SkipCount,
  ));
}

}


/// Adds pattern-matching-related methods to [SkipEvent].
extension SkipEventPatterns on SkipEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipEvent value)  $default,){
final _that = this;
switch (_that) {
case _SkipEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SkipEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateKey dateKey,  DayType dayType,  SkipCount skipCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipEvent() when $default != null:
return $default(_that.dateKey,_that.dayType,_that.skipCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateKey dateKey,  DayType dayType,  SkipCount skipCount)  $default,) {final _that = this;
switch (_that) {
case _SkipEvent():
return $default(_that.dateKey,_that.dayType,_that.skipCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateKey dateKey,  DayType dayType,  SkipCount skipCount)?  $default,) {final _that = this;
switch (_that) {
case _SkipEvent() when $default != null:
return $default(_that.dateKey,_that.dayType,_that.skipCount);case _:
  return null;

}
}

}

/// @nodoc


class _SkipEvent extends SkipEvent {
  const _SkipEvent({required this.dateKey, required this.dayType, required this.skipCount}): super._();
  

@override final  DateKey dateKey;
@override final  DayType dayType;
@override final  SkipCount skipCount;

/// Create a copy of SkipEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipEventCopyWith<_SkipEvent> get copyWith => __$SkipEventCopyWithImpl<_SkipEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipEvent&&(identical(other.dateKey, dateKey) || other.dateKey == dateKey)&&(identical(other.dayType, dayType) || other.dayType == dayType)&&(identical(other.skipCount, skipCount) || other.skipCount == skipCount));
}


@override
int get hashCode => Object.hash(runtimeType,dateKey,dayType,skipCount);

@override
String toString() {
  return 'SkipEvent(dateKey: $dateKey, dayType: $dayType, skipCount: $skipCount)';
}


}

/// @nodoc
abstract mixin class _$SkipEventCopyWith<$Res> implements $SkipEventCopyWith<$Res> {
  factory _$SkipEventCopyWith(_SkipEvent value, $Res Function(_SkipEvent) _then) = __$SkipEventCopyWithImpl;
@override @useResult
$Res call({
 DateKey dateKey, DayType dayType, SkipCount skipCount
});




}
/// @nodoc
class __$SkipEventCopyWithImpl<$Res>
    implements _$SkipEventCopyWith<$Res> {
  __$SkipEventCopyWithImpl(this._self, this._then);

  final _SkipEvent _self;
  final $Res Function(_SkipEvent) _then;

/// Create a copy of SkipEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateKey = null,Object? dayType = null,Object? skipCount = null,}) {
  return _then(_SkipEvent(
dateKey: null == dateKey ? _self.dateKey : dateKey // ignore: cast_nullable_to_non_nullable
as DateKey,dayType: null == dayType ? _self.dayType : dayType // ignore: cast_nullable_to_non_nullable
as DayType,skipCount: null == skipCount ? _self.skipCount : skipCount // ignore: cast_nullable_to_non_nullable
as SkipCount,
  ));
}


}

// dart format on
