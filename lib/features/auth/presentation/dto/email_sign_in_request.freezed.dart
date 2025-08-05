// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_sign_in_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailSignInRequest {

 Email get email; Password get password;
/// Create a copy of EmailSignInRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailSignInRequestCopyWith<EmailSignInRequest> get copyWith => _$EmailSignInRequestCopyWithImpl<EmailSignInRequest>(this as EmailSignInRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailSignInRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'EmailSignInRequest(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $EmailSignInRequestCopyWith<$Res>  {
  factory $EmailSignInRequestCopyWith(EmailSignInRequest value, $Res Function(EmailSignInRequest) _then) = _$EmailSignInRequestCopyWithImpl;
@useResult
$Res call({
 Email email, Password password
});


$EmailCopyWith<$Res> get email;$PasswordCopyWith<$Res> get password;

}
/// @nodoc
class _$EmailSignInRequestCopyWithImpl<$Res>
    implements $EmailSignInRequestCopyWith<$Res> {
  _$EmailSignInRequestCopyWithImpl(this._self, this._then);

  final EmailSignInRequest _self;
  final $Res Function(EmailSignInRequest) _then;

/// Create a copy of EmailSignInRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}
/// Create a copy of EmailSignInRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailCopyWith<$Res> get email {
  
  return $EmailCopyWith<$Res>(_self.email, (value) {
    return _then(_self.copyWith(email: value));
  });
}/// Create a copy of EmailSignInRequest
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


class _EmailSignInRequest extends EmailSignInRequest {
  const _EmailSignInRequest({required this.email, required this.password}): super._();
  

@override final  Email email;
@override final  Password password;

/// Create a copy of EmailSignInRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailSignInRequestCopyWith<_EmailSignInRequest> get copyWith => __$EmailSignInRequestCopyWithImpl<_EmailSignInRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailSignInRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'EmailSignInRequest(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$EmailSignInRequestCopyWith<$Res> implements $EmailSignInRequestCopyWith<$Res> {
  factory _$EmailSignInRequestCopyWith(_EmailSignInRequest value, $Res Function(_EmailSignInRequest) _then) = __$EmailSignInRequestCopyWithImpl;
@override @useResult
$Res call({
 Email email, Password password
});


@override $EmailCopyWith<$Res> get email;@override $PasswordCopyWith<$Res> get password;

}
/// @nodoc
class __$EmailSignInRequestCopyWithImpl<$Res>
    implements _$EmailSignInRequestCopyWith<$Res> {
  __$EmailSignInRequestCopyWithImpl(this._self, this._then);

  final _EmailSignInRequest _self;
  final $Res Function(_EmailSignInRequest) _then;

/// Create a copy of EmailSignInRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_EmailSignInRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}

/// Create a copy of EmailSignInRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailCopyWith<$Res> get email {
  
  return $EmailCopyWith<$Res>(_self.email, (value) {
    return _then(_self.copyWith(email: value));
  });
}/// Create a copy of EmailSignInRequest
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
