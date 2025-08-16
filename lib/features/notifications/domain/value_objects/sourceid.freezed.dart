// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sourceid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SourceId {

 String get value;
/// Create a copy of SourceId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceIdCopyWith<SourceId> get copyWith => _$SourceIdCopyWithImpl<SourceId>(this as SourceId, _$identity);

  /// Serializes this SourceId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SourceId(value: $value)';
}


}

/// @nodoc
abstract mixin class $SourceIdCopyWith<$Res>  {
  factory $SourceIdCopyWith(SourceId value, $Res Function(SourceId) _then) = _$SourceIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$SourceIdCopyWithImpl<$Res>
    implements $SourceIdCopyWith<$Res> {
  _$SourceIdCopyWithImpl(this._self, this._then);

  final SourceId _self;
  final $Res Function(SourceId) _then;

/// Create a copy of SourceId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SourceId].
extension SourceIdPatterns on SourceId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SourceId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourceId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SourceId value)  $default,){
final _that = this;
switch (_that) {
case _SourceId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SourceId value)?  $default,){
final _that = this;
switch (_that) {
case _SourceId() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourceId() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value)  $default,) {final _that = this;
switch (_that) {
case _SourceId():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value)?  $default,) {final _that = this;
switch (_that) {
case _SourceId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SourceId extends SourceId {
  const _SourceId({required this.value}): super._();
  factory _SourceId.fromJson(Map<String, dynamic> json) => _$SourceIdFromJson(json);

@override final  String value;

/// Create a copy of SourceId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceIdCopyWith<_SourceId> get copyWith => __$SourceIdCopyWithImpl<_SourceId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SourceId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SourceIdCopyWith<$Res> implements $SourceIdCopyWith<$Res> {
  factory _$SourceIdCopyWith(_SourceId value, $Res Function(_SourceId) _then) = __$SourceIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$SourceIdCopyWithImpl<$Res>
    implements _$SourceIdCopyWith<$Res> {
  __$SourceIdCopyWithImpl(this._self, this._then);

  final _SourceId _self;
  final $Res Function(_SourceId) _then;

/// Create a copy of SourceId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SourceId(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
