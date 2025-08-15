// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_days.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RotationDays {

 List<Weekday> get value;
/// Create a copy of RotationDays
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationDaysCopyWith<RotationDays> get copyWith => _$RotationDaysCopyWithImpl<RotationDays>(this as RotationDays, _$identity);

  /// Serializes this RotationDays to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationDays&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));



}

/// @nodoc
abstract mixin class $RotationDaysCopyWith<$Res>  {
  factory $RotationDaysCopyWith(RotationDays value, $Res Function(RotationDays) _then) = _$RotationDaysCopyWithImpl;
@useResult
$Res call({
 List<Weekday> value
});




}
/// @nodoc
class _$RotationDaysCopyWithImpl<$Res>
    implements $RotationDaysCopyWith<$Res> {
  _$RotationDaysCopyWithImpl(this._self, this._then);

  final RotationDays _self;
  final $Res Function(RotationDays) _then;

/// Create a copy of RotationDays
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as List<Weekday>,
  ));
}

}


/// Adds pattern-matching-related methods to [RotationDays].
extension RotationDaysPatterns on RotationDays {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RotationDays value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RotationDays() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RotationDays value)  $default,){
final _that = this;
switch (_that) {
case _RotationDays():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RotationDays value)?  $default,){
final _that = this;
switch (_that) {
case _RotationDays() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Weekday> value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RotationDays() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Weekday> value)  $default,) {final _that = this;
switch (_that) {
case _RotationDays():
return $default(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Weekday> value)?  $default,) {final _that = this;
switch (_that) {
case _RotationDays() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RotationDays extends RotationDays {
  const _RotationDays(final  List<Weekday> value): _value = value,super._();
  factory _RotationDays.fromJson(Map<String, dynamic> json) => _$RotationDaysFromJson(json);

 final  List<Weekday> _value;
@override List<Weekday> get value {
  if (_value is EqualUnmodifiableListView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_value);
}


/// Create a copy of RotationDays
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationDaysCopyWith<_RotationDays> get copyWith => __$RotationDaysCopyWithImpl<_RotationDays>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RotationDaysToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationDays&&const DeepCollectionEquality().equals(other._value, _value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_value));



}

/// @nodoc
abstract mixin class _$RotationDaysCopyWith<$Res> implements $RotationDaysCopyWith<$Res> {
  factory _$RotationDaysCopyWith(_RotationDays value, $Res Function(_RotationDays) _then) = __$RotationDaysCopyWithImpl;
@override @useResult
$Res call({
 List<Weekday> value
});




}
/// @nodoc
class __$RotationDaysCopyWithImpl<$Res>
    implements _$RotationDaysCopyWith<$Res> {
  __$RotationDaysCopyWithImpl(this._self, this._then);

  final _RotationDays _self;
  final $Res Function(_RotationDays) _then;

/// Create a copy of RotationDays
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_RotationDays(
null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as List<Weekday>,
  ));
}


}

// dart format on
