// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_firebase_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserFirebaseModel {

 UserId get userId; Email get email;
/// Create a copy of UserFirebaseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFirebaseModelCopyWith<UserFirebaseModel> get copyWith => _$UserFirebaseModelCopyWithImpl<UserFirebaseModel>(this as UserFirebaseModel, _$identity);

  /// Serializes this UserFirebaseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFirebaseModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseModel(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserFirebaseModelCopyWith<$Res>  {
  factory $UserFirebaseModelCopyWith(UserFirebaseModel value, $Res Function(UserFirebaseModel) _then) = _$UserFirebaseModelCopyWithImpl;
@useResult
$Res call({
 UserId userId, Email email
});


$UserIdCopyWith<$Res> get userId;$EmailCopyWith<$Res> get email;

}
/// @nodoc
class _$UserFirebaseModelCopyWithImpl<$Res>
    implements $UserFirebaseModelCopyWith<$Res> {
  _$UserFirebaseModelCopyWithImpl(this._self, this._then);

  final UserFirebaseModel _self;
  final $Res Function(UserFirebaseModel) _then;

/// Create a copy of UserFirebaseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}
/// Create a copy of UserFirebaseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserFirebaseModel
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

class _UserFirebaseModel extends UserFirebaseModel {
  const _UserFirebaseModel({required this.userId, required this.email}): super._();
  factory _UserFirebaseModel.fromJson(Map<String, dynamic> json) => _$UserFirebaseModelFromJson(json);

@override final  UserId userId;
@override final  Email email;

/// Create a copy of UserFirebaseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFirebaseModelCopyWith<_UserFirebaseModel> get copyWith => __$UserFirebaseModelCopyWithImpl<_UserFirebaseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserFirebaseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFirebaseModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseModel(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserFirebaseModelCopyWith<$Res> implements $UserFirebaseModelCopyWith<$Res> {
  factory _$UserFirebaseModelCopyWith(_UserFirebaseModel value, $Res Function(_UserFirebaseModel) _then) = __$UserFirebaseModelCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, Email email
});


@override $UserIdCopyWith<$Res> get userId;@override $EmailCopyWith<$Res> get email;

}
/// @nodoc
class __$UserFirebaseModelCopyWithImpl<$Res>
    implements _$UserFirebaseModelCopyWith<$Res> {
  __$UserFirebaseModelCopyWithImpl(this._self, this._then);

  final _UserFirebaseModel _self;
  final $Res Function(_UserFirebaseModel) _then;

/// Create a copy of UserFirebaseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_UserFirebaseModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

/// Create a copy of UserFirebaseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserFirebaseModel
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
