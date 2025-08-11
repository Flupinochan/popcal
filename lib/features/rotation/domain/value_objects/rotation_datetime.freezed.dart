// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rotation_datetime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RotationDateTime {

 Object? get value;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotationDateTime&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'RotationDateTime(value: $value)';
}


}

/// @nodoc
class $RotationDateTimeCopyWith<$Res>  {
$RotationDateTimeCopyWith(RotationDateTime _, $Res Function(RotationDateTime) __);
}


/// Adds pattern-matching-related methods to [RotationDateTime].
extension RotationDateTimePatterns on RotationDateTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CreatedAt value)?  createdAt,TResult Function( _UpdatedAt value)?  updatedAt,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedAt() when createdAt != null:
return createdAt(_that);case _UpdatedAt() when updatedAt != null:
return updatedAt(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CreatedAt value)  createdAt,required TResult Function( _UpdatedAt value)  updatedAt,}){
final _that = this;
switch (_that) {
case _CreatedAt():
return createdAt(_that);case _UpdatedAt():
return updatedAt(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CreatedAt value)?  createdAt,TResult? Function( _UpdatedAt value)?  updatedAt,}){
final _that = this;
switch (_that) {
case _CreatedAt() when createdAt != null:
return createdAt(_that);case _UpdatedAt() when updatedAt != null:
return updatedAt(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RotationCreatedAt value)?  createdAt,TResult Function( RotationUpdatedAt value)?  updatedAt,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedAt() when createdAt != null:
return createdAt(_that.value);case _UpdatedAt() when updatedAt != null:
return updatedAt(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RotationCreatedAt value)  createdAt,required TResult Function( RotationUpdatedAt value)  updatedAt,}) {final _that = this;
switch (_that) {
case _CreatedAt():
return createdAt(_that.value);case _UpdatedAt():
return updatedAt(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RotationCreatedAt value)?  createdAt,TResult? Function( RotationUpdatedAt value)?  updatedAt,}) {final _that = this;
switch (_that) {
case _CreatedAt() when createdAt != null:
return createdAt(_that.value);case _UpdatedAt() when updatedAt != null:
return updatedAt(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _CreatedAt extends RotationDateTime {
  const _CreatedAt(this.value): super._();
  

@override final  RotationCreatedAt value;

/// Create a copy of RotationDateTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedAtCopyWith<_CreatedAt> get copyWith => __$CreatedAtCopyWithImpl<_CreatedAt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedAt&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'RotationDateTime.createdAt(value: $value)';
}


}

/// @nodoc
abstract mixin class _$CreatedAtCopyWith<$Res> implements $RotationDateTimeCopyWith<$Res> {
  factory _$CreatedAtCopyWith(_CreatedAt value, $Res Function(_CreatedAt) _then) = __$CreatedAtCopyWithImpl;
@useResult
$Res call({
 RotationCreatedAt value
});




}
/// @nodoc
class __$CreatedAtCopyWithImpl<$Res>
    implements _$CreatedAtCopyWith<$Res> {
  __$CreatedAtCopyWithImpl(this._self, this._then);

  final _CreatedAt _self;
  final $Res Function(_CreatedAt) _then;

/// Create a copy of RotationDateTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_CreatedAt(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as RotationCreatedAt,
  ));
}


}

/// @nodoc


class _UpdatedAt extends RotationDateTime {
  const _UpdatedAt(this.value): super._();
  

@override final  RotationUpdatedAt value;

/// Create a copy of RotationDateTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatedAtCopyWith<_UpdatedAt> get copyWith => __$UpdatedAtCopyWithImpl<_UpdatedAt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatedAt&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'RotationDateTime.updatedAt(value: $value)';
}


}

/// @nodoc
abstract mixin class _$UpdatedAtCopyWith<$Res> implements $RotationDateTimeCopyWith<$Res> {
  factory _$UpdatedAtCopyWith(_UpdatedAt value, $Res Function(_UpdatedAt) _then) = __$UpdatedAtCopyWithImpl;
@useResult
$Res call({
 RotationUpdatedAt value
});




}
/// @nodoc
class __$UpdatedAtCopyWithImpl<$Res>
    implements _$UpdatedAtCopyWith<$Res> {
  __$UpdatedAtCopyWithImpl(this._self, this._then);

  final _UpdatedAt _self;
  final $Res Function(_UpdatedAt) _then;

/// Create a copy of RotationDateTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_UpdatedAt(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as RotationUpdatedAt,
  ));
}


}

// dart format on
