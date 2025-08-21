// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarSchedule {

 Rotation get rotation; Map<DateKey, ScheduleDay> get scheduleMap;
/// Create a copy of CalendarSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarScheduleCopyWith<CalendarSchedule> get copyWith => _$CalendarScheduleCopyWithImpl<CalendarSchedule>(this as CalendarSchedule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarSchedule&&(identical(other.rotation, rotation) || other.rotation == rotation)&&const DeepCollectionEquality().equals(other.scheduleMap, scheduleMap));
}


@override
int get hashCode => Object.hash(runtimeType,rotation,const DeepCollectionEquality().hash(scheduleMap));

@override
String toString() {
  return 'CalendarSchedule(rotation: $rotation, scheduleMap: $scheduleMap)';
}


}

/// @nodoc
abstract mixin class $CalendarScheduleCopyWith<$Res>  {
  factory $CalendarScheduleCopyWith(CalendarSchedule value, $Res Function(CalendarSchedule) _then) = _$CalendarScheduleCopyWithImpl;
@useResult
$Res call({
 Rotation rotation, Map<DateKey, ScheduleDay> scheduleMap
});


$RotationCopyWith<$Res> get rotation;

}
/// @nodoc
class _$CalendarScheduleCopyWithImpl<$Res>
    implements $CalendarScheduleCopyWith<$Res> {
  _$CalendarScheduleCopyWithImpl(this._self, this._then);

  final CalendarSchedule _self;
  final $Res Function(CalendarSchedule) _then;

/// Create a copy of CalendarSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotation = null,Object? scheduleMap = null,}) {
  return _then(_self.copyWith(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as Rotation,scheduleMap: null == scheduleMap ? _self.scheduleMap : scheduleMap // ignore: cast_nullable_to_non_nullable
as Map<DateKey, ScheduleDay>,
  ));
}
/// Create a copy of CalendarSchedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationCopyWith<$Res> get rotation {
  
  return $RotationCopyWith<$Res>(_self.rotation, (value) {
    return _then(_self.copyWith(rotation: value));
  });
}
}


/// Adds pattern-matching-related methods to [CalendarSchedule].
extension CalendarSchedulePatterns on CalendarSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarSchedule value)  $default,){
final _that = this;
switch (_that) {
case _CalendarSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Rotation rotation,  Map<DateKey, ScheduleDay> scheduleMap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarSchedule() when $default != null:
return $default(_that.rotation,_that.scheduleMap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Rotation rotation,  Map<DateKey, ScheduleDay> scheduleMap)  $default,) {final _that = this;
switch (_that) {
case _CalendarSchedule():
return $default(_that.rotation,_that.scheduleMap);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Rotation rotation,  Map<DateKey, ScheduleDay> scheduleMap)?  $default,) {final _that = this;
switch (_that) {
case _CalendarSchedule() when $default != null:
return $default(_that.rotation,_that.scheduleMap);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarSchedule extends CalendarSchedule {
  const _CalendarSchedule({required this.rotation, required final  Map<DateKey, ScheduleDay> scheduleMap}): _scheduleMap = scheduleMap,super._();
  

@override final  Rotation rotation;
 final  Map<DateKey, ScheduleDay> _scheduleMap;
@override Map<DateKey, ScheduleDay> get scheduleMap {
  if (_scheduleMap is EqualUnmodifiableMapView) return _scheduleMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scheduleMap);
}


/// Create a copy of CalendarSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarScheduleCopyWith<_CalendarSchedule> get copyWith => __$CalendarScheduleCopyWithImpl<_CalendarSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarSchedule&&(identical(other.rotation, rotation) || other.rotation == rotation)&&const DeepCollectionEquality().equals(other._scheduleMap, _scheduleMap));
}


@override
int get hashCode => Object.hash(runtimeType,rotation,const DeepCollectionEquality().hash(_scheduleMap));

@override
String toString() {
  return 'CalendarSchedule(rotation: $rotation, scheduleMap: $scheduleMap)';
}


}

/// @nodoc
abstract mixin class _$CalendarScheduleCopyWith<$Res> implements $CalendarScheduleCopyWith<$Res> {
  factory _$CalendarScheduleCopyWith(_CalendarSchedule value, $Res Function(_CalendarSchedule) _then) = __$CalendarScheduleCopyWithImpl;
@override @useResult
$Res call({
 Rotation rotation, Map<DateKey, ScheduleDay> scheduleMap
});


@override $RotationCopyWith<$Res> get rotation;

}
/// @nodoc
class __$CalendarScheduleCopyWithImpl<$Res>
    implements _$CalendarScheduleCopyWith<$Res> {
  __$CalendarScheduleCopyWithImpl(this._self, this._then);

  final _CalendarSchedule _self;
  final $Res Function(_CalendarSchedule) _then;

/// Create a copy of CalendarSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? scheduleMap = null,}) {
  return _then(_CalendarSchedule(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as Rotation,scheduleMap: null == scheduleMap ? _self._scheduleMap : scheduleMap // ignore: cast_nullable_to_non_nullable
as Map<DateKey, ScheduleDay>,
  ));
}

/// Create a copy of CalendarSchedule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RotationCopyWith<$Res> get rotation {
  
  return $RotationCopyWith<$Res>(_self.rotation, (value) {
    return _then(_self.copyWith(rotation: value));
  });
}
}

// dart format on
