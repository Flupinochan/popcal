// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_firebase_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserFirebaseDto {

 UserId get userId; Email get email;
/// Create a copy of UserFirebaseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFirebaseDtoCopyWith<UserFirebaseDto> get copyWith => _$UserFirebaseDtoCopyWithImpl<UserFirebaseDto>(this as UserFirebaseDto, _$identity);

  /// Serializes this UserFirebaseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFirebaseDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseDto(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserFirebaseDtoCopyWith<$Res>  {
  factory $UserFirebaseDtoCopyWith(UserFirebaseDto value, $Res Function(UserFirebaseDto) _then) = _$UserFirebaseDtoCopyWithImpl;
@useResult
$Res call({
 UserId userId, Email email
});


$UserIdCopyWith<$Res> get userId;$EmailCopyWith<$Res> get email;

}
/// @nodoc
class _$UserFirebaseDtoCopyWithImpl<$Res>
    implements $UserFirebaseDtoCopyWith<$Res> {
  _$UserFirebaseDtoCopyWithImpl(this._self, this._then);

  final UserFirebaseDto _self;
  final $Res Function(UserFirebaseDto) _then;

/// Create a copy of UserFirebaseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}
/// Create a copy of UserFirebaseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserFirebaseDto
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

class _UserFirebaseDto extends UserFirebaseDto {
  const _UserFirebaseDto({required this.userId, required this.email}): super._();
  factory _UserFirebaseDto.fromJson(Map<String, dynamic> json) => _$UserFirebaseDtoFromJson(json);

@override final  UserId userId;
@override final  Email email;

/// Create a copy of UserFirebaseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFirebaseDtoCopyWith<_UserFirebaseDto> get copyWith => __$UserFirebaseDtoCopyWithImpl<_UserFirebaseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserFirebaseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFirebaseDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseDto(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserFirebaseDtoCopyWith<$Res> implements $UserFirebaseDtoCopyWith<$Res> {
  factory _$UserFirebaseDtoCopyWith(_UserFirebaseDto value, $Res Function(_UserFirebaseDto) _then) = __$UserFirebaseDtoCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, Email email
});


@override $UserIdCopyWith<$Res> get userId;@override $EmailCopyWith<$Res> get email;

}
/// @nodoc
class __$UserFirebaseDtoCopyWithImpl<$Res>
    implements _$UserFirebaseDtoCopyWith<$Res> {
  __$UserFirebaseDtoCopyWithImpl(this._self, this._then);

  final _UserFirebaseDto _self;
  final $Res Function(_UserFirebaseDto) _then;

/// Create a copy of UserFirebaseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_UserFirebaseDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

/// Create a copy of UserFirebaseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserFirebaseDto
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
