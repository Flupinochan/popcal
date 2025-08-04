// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserViewModel {

 UserId get userId; Email get email;
/// Create a copy of UserViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserViewModelCopyWith<UserViewModel> get copyWith => _$UserViewModelCopyWithImpl<UserViewModel>(this as UserViewModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserViewModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserViewModel(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserViewModelCopyWith<$Res>  {
  factory $UserViewModelCopyWith(UserViewModel value, $Res Function(UserViewModel) _then) = _$UserViewModelCopyWithImpl;
@useResult
$Res call({
 UserId userId, Email email
});


$UserIdCopyWith<$Res> get userId;$EmailCopyWith<$Res> get email;

}
/// @nodoc
class _$UserViewModelCopyWithImpl<$Res>
    implements $UserViewModelCopyWith<$Res> {
  _$UserViewModelCopyWithImpl(this._self, this._then);

  final UserViewModel _self;
  final $Res Function(UserViewModel) _then;

/// Create a copy of UserViewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}
/// Create a copy of UserViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserViewModel
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


class _UserViewModel extends UserViewModel {
  const _UserViewModel({required this.userId, required this.email}): super._();
  

@override final  UserId userId;
@override final  Email email;

/// Create a copy of UserViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserViewModelCopyWith<_UserViewModel> get copyWith => __$UserViewModelCopyWithImpl<_UserViewModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserViewModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserViewModel(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserViewModelCopyWith<$Res> implements $UserViewModelCopyWith<$Res> {
  factory _$UserViewModelCopyWith(_UserViewModel value, $Res Function(_UserViewModel) _then) = __$UserViewModelCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, Email email
});


@override $UserIdCopyWith<$Res> get userId;@override $EmailCopyWith<$Res> get email;

}
/// @nodoc
class __$UserViewModelCopyWithImpl<$Res>
    implements _$UserViewModelCopyWith<$Res> {
  __$UserViewModelCopyWithImpl(this._self, this._then);

  final _UserViewModel _self;
  final $Res Function(_UserViewModel) _then;

/// Create a copy of UserViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_UserViewModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

/// Create a copy of UserViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserViewModel
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
