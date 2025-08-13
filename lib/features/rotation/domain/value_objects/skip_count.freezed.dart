// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkipCount {

 int get skipCount;
/// Create a copy of SkipCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipCountCopyWith<SkipCount> get copyWith => _$SkipCountCopyWithImpl<SkipCount>(this as SkipCount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipCount&&(identical(other.skipCount, skipCount) || other.skipCount == skipCount));
}


@override
int get hashCode => Object.hash(runtimeType,skipCount);

@override
String toString() {
  return 'SkipCount(skipCount: $skipCount)';
}


}

/// @nodoc
abstract mixin class $SkipCountCopyWith<$Res>  {
  factory $SkipCountCopyWith(SkipCount value, $Res Function(SkipCount) _then) = _$SkipCountCopyWithImpl;
@useResult
$Res call({
 int skipCount
});




}
/// @nodoc
class _$SkipCountCopyWithImpl<$Res>
    implements $SkipCountCopyWith<$Res> {
  _$SkipCountCopyWithImpl(this._self, this._then);

  final SkipCount _self;
  final $Res Function(SkipCount) _then;

/// Create a copy of SkipCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? skipCount = null,}) {
  return _then(_self.copyWith(
skipCount: null == skipCount ? _self.skipCount : skipCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SkipCount].
extension SkipCountPatterns on SkipCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipCount value)  $default,){
final _that = this;
switch (_that) {
case _SkipCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipCount value)?  $default,){
final _that = this;
switch (_that) {
case _SkipCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int skipCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipCount() when $default != null:
return $default(_that.skipCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int skipCount)  $default,) {final _that = this;
switch (_that) {
case _SkipCount():
return $default(_that.skipCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int skipCount)?  $default,) {final _that = this;
switch (_that) {
case _SkipCount() when $default != null:
return $default(_that.skipCount);case _:
  return null;

}
}

}

/// @nodoc


class _SkipCount extends SkipCount {
  const _SkipCount({required this.skipCount}): super._();
  

@override final  int skipCount;

/// Create a copy of SkipCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipCountCopyWith<_SkipCount> get copyWith => __$SkipCountCopyWithImpl<_SkipCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipCount&&(identical(other.skipCount, skipCount) || other.skipCount == skipCount));
}


@override
int get hashCode => Object.hash(runtimeType,skipCount);

@override
String toString() {
  return 'SkipCount(skipCount: $skipCount)';
}


}

/// @nodoc
abstract mixin class _$SkipCountCopyWith<$Res> implements $SkipCountCopyWith<$Res> {
  factory _$SkipCountCopyWith(_SkipCount value, $Res Function(_SkipCount) _then) = __$SkipCountCopyWithImpl;
@override @useResult
$Res call({
 int skipCount
});




}
/// @nodoc
class __$SkipCountCopyWithImpl<$Res>
    implements _$SkipCountCopyWith<$Res> {
  __$SkipCountCopyWithImpl(this._self, this._then);

  final _SkipCount _self;
  final $Res Function(_SkipCount) _then;

/// Create a copy of SkipCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? skipCount = null,}) {
  return _then(_SkipCount(
skipCount: null == skipCount ? _self.skipCount : skipCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
