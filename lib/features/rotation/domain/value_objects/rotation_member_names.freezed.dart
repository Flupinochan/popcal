// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_member_names.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationMemberNames {

 List<String> get value;
/// Create a copy of RotationMemberNames
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotationMemberNamesCopyWith<RotationMemberNames> get copyWith => _$RotationMemberNamesCopyWithImpl<RotationMemberNames>(this as RotationMemberNames, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationMemberNames&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'RotationMemberNames(value: $value)';
}


}

/// @nodoc
abstract mixin class $RotationMemberNamesCopyWith<$Res>  {
  factory $RotationMemberNamesCopyWith(RotationMemberNames value, $Res Function(RotationMemberNames) _then) = _$RotationMemberNamesCopyWithImpl;
@useResult
$Res call({
 List<String> value
});




}
/// @nodoc
class _$RotationMemberNamesCopyWithImpl<$Res>
    implements $RotationMemberNamesCopyWith<$Res> {
  _$RotationMemberNamesCopyWithImpl(this._self, this._then);

  final RotationMemberNames _self;
  final $Res Function(RotationMemberNames) _then;

/// Create a copy of RotationMemberNames
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RotationMemberNames].
extension RotationMemberNamesPatterns on RotationMemberNames {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RotationMemberNames value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RotationMemberNames() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RotationMemberNames value)  $default,){
final _that = this;
switch (_that) {
case _RotationMemberNames():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RotationMemberNames value)?  $default,){
final _that = this;
switch (_that) {
case _RotationMemberNames() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RotationMemberNames() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> value)  $default,) {final _that = this;
switch (_that) {
case _RotationMemberNames():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> value)?  $default,) {final _that = this;
switch (_that) {
case _RotationMemberNames() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _RotationMemberNames extends RotationMemberNames {
  const _RotationMemberNames(final  List<String> value): _value = value,super._();
  

 final  List<String> _value;
@override List<String> get value {
  if (_value is EqualUnmodifiableListView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_value);
}


/// Create a copy of RotationMemberNames
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RotationMemberNamesCopyWith<_RotationMemberNames> get copyWith => __$RotationMemberNamesCopyWithImpl<_RotationMemberNames>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RotationMemberNames&&const DeepCollectionEquality().equals(other._value, _value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_value));

@override
String toString() {
  return 'RotationMemberNames(value: $value)';
}


}

/// @nodoc
abstract mixin class _$RotationMemberNamesCopyWith<$Res> implements $RotationMemberNamesCopyWith<$Res> {
  factory _$RotationMemberNamesCopyWith(_RotationMemberNames value, $Res Function(_RotationMemberNames) _then) = __$RotationMemberNamesCopyWithImpl;
@override @useResult
$Res call({
 List<String> value
});




}
/// @nodoc
class __$RotationMemberNamesCopyWithImpl<$Res>
    implements _$RotationMemberNamesCopyWith<$Res> {
  __$RotationMemberNamesCopyWithImpl(this._self, this._then);

  final _RotationMemberNames _self;
  final $Res Function(_RotationMemberNames) _then;

/// Create a copy of RotationMemberNames
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_RotationMemberNames(
null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
