// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_sign_in_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailSignInRequestDto {

 Email get email; Password get password;
/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailSignInRequestDtoCopyWith<EmailSignInRequestDto> get copyWith => _$EmailSignInRequestDtoCopyWithImpl<EmailSignInRequestDto>(this as EmailSignInRequestDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailSignInRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'EmailSignInRequestDto(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $EmailSignInRequestDtoCopyWith<$Res>  {
  factory $EmailSignInRequestDtoCopyWith(EmailSignInRequestDto value, $Res Function(EmailSignInRequestDto) _then) = _$EmailSignInRequestDtoCopyWithImpl;
@useResult
$Res call({
 Email email, Password password
});


$EmailCopyWith<$Res> get email;$PasswordCopyWith<$Res> get password;

}
/// @nodoc
class _$EmailSignInRequestDtoCopyWithImpl<$Res>
    implements $EmailSignInRequestDtoCopyWith<$Res> {
  _$EmailSignInRequestDtoCopyWithImpl(this._self, this._then);

  final EmailSignInRequestDto _self;
  final $Res Function(EmailSignInRequestDto) _then;

/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}
/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailCopyWith<$Res> get email {
  
  return $EmailCopyWith<$Res>(_self.email, (value) {
    return _then(_self.copyWith(email: value));
  });
}/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PasswordCopyWith<$Res> get password {
  
  return $PasswordCopyWith<$Res>(_self.password, (value) {
    return _then(_self.copyWith(password: value));
  });
}
}


/// @nodoc


class _EmailSignInRequestDto extends EmailSignInRequestDto {
  const _EmailSignInRequestDto({required this.email, required this.password}): super._();
  

@override final  Email email;
@override final  Password password;

/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailSignInRequestDtoCopyWith<_EmailSignInRequestDto> get copyWith => __$EmailSignInRequestDtoCopyWithImpl<_EmailSignInRequestDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailSignInRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'EmailSignInRequestDto(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$EmailSignInRequestDtoCopyWith<$Res> implements $EmailSignInRequestDtoCopyWith<$Res> {
  factory _$EmailSignInRequestDtoCopyWith(_EmailSignInRequestDto value, $Res Function(_EmailSignInRequestDto) _then) = __$EmailSignInRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 Email email, Password password
});


@override $EmailCopyWith<$Res> get email;@override $PasswordCopyWith<$Res> get password;

}
/// @nodoc
class __$EmailSignInRequestDtoCopyWithImpl<$Res>
    implements _$EmailSignInRequestDtoCopyWith<$Res> {
  __$EmailSignInRequestDtoCopyWithImpl(this._self, this._then);

  final _EmailSignInRequestDto _self;
  final $Res Function(_EmailSignInRequestDto) _then;

/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_EmailSignInRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}

/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailCopyWith<$Res> get email {
  
  return $EmailCopyWith<$Res>(_self.email, (value) {
    return _then(_self.copyWith(email: value));
  });
}/// Create a copy of EmailSignInRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PasswordCopyWith<$Res> get password {
  
  return $PasswordCopyWith<$Res>(_self.password, (value) {
    return _then(_self.copyWith(password: value));
  });
}
}

// dart format on
