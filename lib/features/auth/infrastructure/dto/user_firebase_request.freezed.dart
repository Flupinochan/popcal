// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_firebase_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserFirebaseRequest {

 String get userId; String get email;
/// Create a copy of UserFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFirebaseRequestCopyWith<UserFirebaseRequest> get copyWith => _$UserFirebaseRequestCopyWithImpl<UserFirebaseRequest>(this as UserFirebaseRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFirebaseRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseRequest(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserFirebaseRequestCopyWith<$Res>  {
  factory $UserFirebaseRequestCopyWith(UserFirebaseRequest value, $Res Function(UserFirebaseRequest) _then) = _$UserFirebaseRequestCopyWithImpl;
@useResult
$Res call({
 String userId, String email
});




}
/// @nodoc
class _$UserFirebaseRequestCopyWithImpl<$Res>
    implements $UserFirebaseRequestCopyWith<$Res> {
  _$UserFirebaseRequestCopyWithImpl(this._self, this._then);

  final UserFirebaseRequest _self;
  final $Res Function(UserFirebaseRequest) _then;

/// Create a copy of UserFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFirebaseRequest].
extension UserFirebaseRequestPatterns on UserFirebaseRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFirebaseRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFirebaseRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFirebaseRequest value)  $default,){
final _that = this;
switch (_that) {
case _UserFirebaseRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFirebaseRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UserFirebaseRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFirebaseRequest() when $default != null:
return $default(_that.userId,_that.email);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String email)  $default,) {final _that = this;
switch (_that) {
case _UserFirebaseRequest():
return $default(_that.userId,_that.email);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String email)?  $default,) {final _that = this;
switch (_that) {
case _UserFirebaseRequest() when $default != null:
return $default(_that.userId,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _UserFirebaseRequest implements UserFirebaseRequest {
  const _UserFirebaseRequest({required this.userId, required this.email});
  

@override final  String userId;
@override final  String email;

/// Create a copy of UserFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFirebaseRequestCopyWith<_UserFirebaseRequest> get copyWith => __$UserFirebaseRequestCopyWithImpl<_UserFirebaseRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFirebaseRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,userId,email);

@override
String toString() {
  return 'UserFirebaseRequest(userId: $userId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserFirebaseRequestCopyWith<$Res> implements $UserFirebaseRequestCopyWith<$Res> {
  factory _$UserFirebaseRequestCopyWith(_UserFirebaseRequest value, $Res Function(_UserFirebaseRequest) _then) = __$UserFirebaseRequestCopyWithImpl;
@override @useResult
$Res call({
 String userId, String email
});




}
/// @nodoc
class __$UserFirebaseRequestCopyWithImpl<$Res>
    implements _$UserFirebaseRequestCopyWith<$Res> {
  __$UserFirebaseRequestCopyWithImpl(this._self, this._then);

  final _UserFirebaseRequest _self;
  final $Res Function(_UserFirebaseRequest) _then;

/// Create a copy of UserFirebaseRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,}) {
  return _then(_UserFirebaseRequest(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
