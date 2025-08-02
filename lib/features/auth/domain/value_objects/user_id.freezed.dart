// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserId {

 String get value;
/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserIdCopyWith<UserId> get copyWith => _$UserIdCopyWithImpl<UserId>(this as UserId, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserId&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);



}

/// @nodoc
abstract mixin class $UserIdCopyWith<$Res>  {
  factory $UserIdCopyWith(UserId value, $Res Function(UserId) _then) = _$UserIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$UserIdCopyWithImpl<$Res>
    implements $UserIdCopyWith<$Res> {
  _$UserIdCopyWithImpl(this._self, this._then);

  final UserId _self;
  final $Res Function(UserId) _then;

/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _UserId extends UserId {
  const _UserId(this.value): super._();
  

@override final  String value;

/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserIdCopyWith<_UserId> get copyWith => __$UserIdCopyWithImpl<_UserId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserId&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);



}

/// @nodoc
abstract mixin class _$UserIdCopyWith<$Res> implements $UserIdCopyWith<$Res> {
  factory _$UserIdCopyWith(_UserId value, $Res Function(_UserId) _then) = __$UserIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$UserIdCopyWithImpl<$Res>
    implements _$UserIdCopyWith<$Res> {
  __$UserIdCopyWithImpl(this._self, this._then);

  final _UserId _self;
  final $Res Function(_UserId) _then;

/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_UserId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
