// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_firebase_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserFirebaseResponse {

 UserId get userId; Email get email;
/// Create a copy of UserFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFirebaseResponseCopyWith<UserFirebaseResponse> get copyWith => _$UserFirebaseResponseCopyWithImpl<UserFirebaseResponse>(this as UserFirebaseResponse, _$identity);

  /// Serializes this UserFirebaseResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFirebaseResponse&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseResponse(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserFirebaseResponseCopyWith<$Res>  {
  factory $UserFirebaseResponseCopyWith(UserFirebaseResponse value, $Res Function(UserFirebaseResponse) _then) = _$UserFirebaseResponseCopyWithImpl;
@useResult
$Res call({
 UserId userId, Email email
});


$UserIdCopyWith<$Res> get userId;$EmailCopyWith<$Res> get email;

}
/// @nodoc
class _$UserFirebaseResponseCopyWithImpl<$Res>
    implements $UserFirebaseResponseCopyWith<$Res> {
  _$UserFirebaseResponseCopyWithImpl(this._self, this._then);

  final UserFirebaseResponse _self;
  final $Res Function(UserFirebaseResponse) _then;

/// Create a copy of UserFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}
/// Create a copy of UserFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserFirebaseResponse
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

class _UserFirebaseResponse extends UserFirebaseResponse {
  const _UserFirebaseResponse({required this.userId, required this.email}): super._();
  factory _UserFirebaseResponse.fromJson(Map<String, dynamic> json) => _$UserFirebaseResponseFromJson(json);

@override final  UserId userId;
@override final  Email email;

/// Create a copy of UserFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFirebaseResponseCopyWith<_UserFirebaseResponse> get copyWith => __$UserFirebaseResponseCopyWithImpl<_UserFirebaseResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserFirebaseResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFirebaseResponse&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseResponse(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserFirebaseResponseCopyWith<$Res> implements $UserFirebaseResponseCopyWith<$Res> {
  factory _$UserFirebaseResponseCopyWith(_UserFirebaseResponse value, $Res Function(_UserFirebaseResponse) _then) = __$UserFirebaseResponseCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, Email email
});


@override $UserIdCopyWith<$Res> get userId;@override $EmailCopyWith<$Res> get email;

}
/// @nodoc
class __$UserFirebaseResponseCopyWithImpl<$Res>
    implements _$UserFirebaseResponseCopyWith<$Res> {
  __$UserFirebaseResponseCopyWithImpl(this._self, this._then);

  final _UserFirebaseResponse _self;
  final $Res Function(_UserFirebaseResponse) _then;

/// Create a copy of UserFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_UserFirebaseResponse(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

/// Create a copy of UserFirebaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserFirebaseResponse
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
