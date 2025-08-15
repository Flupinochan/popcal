// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DateKey {

 DateTime get value;
/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateKeyCopyWith<DateKey> get copyWith => _$DateKeyCopyWithImpl<DateKey>(this as DateKey, _$identity);

  /// Serializes this DateKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateKey&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'DateKey(value: $value)';
}


}

/// @nodoc
abstract mixin class $DateKeyCopyWith<$Res>  {
  factory $DateKeyCopyWith(DateKey value, $Res Function(DateKey) _then) = _$DateKeyCopyWithImpl;
@useResult
$Res call({
 DateTime value
});




}
/// @nodoc
class _$DateKeyCopyWithImpl<$Res>
    implements $DateKeyCopyWith<$Res> {
  _$DateKeyCopyWithImpl(this._self, this._then);

  final DateKey _self;
  final $Res Function(DateKey) _then;

/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DateKey].
extension DateKeyPatterns on DateKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DateKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DateKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DateKey value)  $default,){
final _that = this;
switch (_that) {
case _DateKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DateKey value)?  $default,){
final _that = this;
switch (_that) {
case _DateKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DateKey() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime value)  $default,) {final _that = this;
switch (_that) {
case _DateKey():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime value)?  $default,) {final _that = this;
switch (_that) {
case _DateKey() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DateKey extends DateKey {
  const _DateKey(this.value): super._();
  factory _DateKey.fromJson(Map<String, dynamic> json) => _$DateKeyFromJson(json);

@override final  DateTime value;

/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateKeyCopyWith<_DateKey> get copyWith => __$DateKeyCopyWithImpl<_DateKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DateKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateKey&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'DateKey(value: $value)';
}


}

/// @nodoc
abstract mixin class _$DateKeyCopyWith<$Res> implements $DateKeyCopyWith<$Res> {
  factory _$DateKeyCopyWith(_DateKey value, $Res Function(_DateKey) _then) = __$DateKeyCopyWithImpl;
@override @useResult
$Res call({
 DateTime value
});




}
/// @nodoc
class __$DateKeyCopyWithImpl<$Res>
    implements _$DateKeyCopyWith<$Res> {
  __$DateKeyCopyWithImpl(this._self, this._then);

  final _DateKey _self;
  final $Res Function(_DateKey) _then;

/// Create a copy of DateKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_DateKey(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
