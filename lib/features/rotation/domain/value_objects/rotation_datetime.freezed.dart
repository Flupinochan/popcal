// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
