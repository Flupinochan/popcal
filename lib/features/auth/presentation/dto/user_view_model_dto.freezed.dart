// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_view_model_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserViewModelDto {

 UserId get userId; Email get email;
/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserViewModelDtoCopyWith<UserViewModelDto> get copyWith => _$UserViewModelDtoCopyWithImpl<UserViewModelDto>(this as UserViewModelDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserViewModelDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserViewModelDto(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserViewModelDtoCopyWith<$Res>  {
  factory $UserViewModelDtoCopyWith(UserViewModelDto value, $Res Function(UserViewModelDto) _then) = _$UserViewModelDtoCopyWithImpl;
@useResult
$Res call({
 UserId userId, Email email
});


$UserIdCopyWith<$Res> get userId;$EmailCopyWith<$Res> get email;

}
/// @nodoc
class _$UserViewModelDtoCopyWithImpl<$Res>
    implements $UserViewModelDtoCopyWith<$Res> {
  _$UserViewModelDtoCopyWithImpl(this._self, this._then);

  final UserViewModelDto _self;
  final $Res Function(UserViewModelDto) _then;

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}
/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailCopyWith<$Res> get email {
  
  return $EmailCopyWith<$Res>(_self.email, (value) {
    return _then(_self.copyWith(email: value));
  });
}
}


/// @nodoc


class _UserViewModelDto extends UserViewModelDto {
  const _UserViewModelDto({required this.userId, required this.email}): super._();
  

@override final  UserId userId;
@override final  Email email;

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserViewModelDtoCopyWith<_UserViewModelDto> get copyWith => __$UserViewModelDtoCopyWithImpl<_UserViewModelDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserViewModelDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserViewModelDto(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserViewModelDtoCopyWith<$Res> implements $UserViewModelDtoCopyWith<$Res> {
  factory _$UserViewModelDtoCopyWith(_UserViewModelDto value, $Res Function(_UserViewModelDto) _then) = __$UserViewModelDtoCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, Email email
});


@override $UserIdCopyWith<$Res> get userId;@override $EmailCopyWith<$Res> get email;

}
/// @nodoc
class __$UserViewModelDtoCopyWithImpl<$Res>
    implements _$UserViewModelDtoCopyWith<$Res> {
  __$UserViewModelDtoCopyWithImpl(this._self, this._then);

  final _UserViewModelDto _self;
  final $Res Function(_UserViewModelDto) _then;

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_UserViewModelDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailCopyWith<$Res> get email {
  
  return $EmailCopyWith<$Res>(_self.email, (value) {
    return _then(_self.copyWith(email: value));
  });
}
}

// dart format on
