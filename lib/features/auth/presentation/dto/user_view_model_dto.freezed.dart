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

 UserId get uid; Email get email;
/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserViewModelDtoCopyWith<UserViewModelDto> get copyWith => _$UserViewModelDtoCopyWithImpl<UserViewModelDto>(this as UserViewModelDto, _$identity);

  /// Serializes this UserViewModelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserViewModelDto&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email);

@override
String toString() {
  return 'UserViewModelDto(uid: $uid, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserViewModelDtoCopyWith<$Res>  {
  factory $UserViewModelDtoCopyWith(UserViewModelDto value, $Res Function(UserViewModelDto) _then) = _$UserViewModelDtoCopyWithImpl;
@useResult
$Res call({
 UserId uid, Email email
});


$UserIdCopyWith<$Res> get uid;$EmailCopyWith<$Res> get email;

}
/// @nodoc
class _$UserViewModelDtoCopyWithImpl<$Res>
    implements $UserViewModelDtoCopyWith<$Res> {
  _$UserViewModelDtoCopyWithImpl(this._self, this._then);

  final UserViewModelDto _self;
  final $Res Function(UserViewModelDto) _then;

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}
/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get uid {
  
  return $UserIdCopyWith<$Res>(_self.uid, (value) {
    return _then(_self.copyWith(uid: value));
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
@JsonSerializable()

class _UserViewModelDto extends UserViewModelDto {
  const _UserViewModelDto({required this.uid, required this.email}): super._();
  factory _UserViewModelDto.fromJson(Map<String, dynamic> json) => _$UserViewModelDtoFromJson(json);

@override final  UserId uid;
@override final  Email email;

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserViewModelDtoCopyWith<_UserViewModelDto> get copyWith => __$UserViewModelDtoCopyWithImpl<_UserViewModelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserViewModelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserViewModelDto&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email);

@override
String toString() {
  return 'UserViewModelDto(uid: $uid, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserViewModelDtoCopyWith<$Res> implements $UserViewModelDtoCopyWith<$Res> {
  factory _$UserViewModelDtoCopyWith(_UserViewModelDto value, $Res Function(_UserViewModelDto) _then) = __$UserViewModelDtoCopyWithImpl;
@override @useResult
$Res call({
 UserId uid, Email email
});


@override $UserIdCopyWith<$Res> get uid;@override $EmailCopyWith<$Res> get email;

}
/// @nodoc
class __$UserViewModelDtoCopyWithImpl<$Res>
    implements _$UserViewModelDtoCopyWith<$Res> {
  __$UserViewModelDtoCopyWithImpl(this._self, this._then);

  final _UserViewModelDto _self;
  final $Res Function(_UserViewModelDto) _then;

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,}) {
  return _then(_UserViewModelDto(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

/// Create a copy of UserViewModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get uid {
  
  return $UserIdCopyWith<$Res>(_self.uid, (value) {
    return _then(_self.copyWith(uid: value));
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
