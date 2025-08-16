// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deadline_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeadlineResponse {

 String get displayTime;
/// Create a copy of DeadlineResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeadlineResponseCopyWith<DeadlineResponse> get copyWith => _$DeadlineResponseCopyWithImpl<DeadlineResponse>(this as DeadlineResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeadlineResponse&&(identical(other.displayTime, displayTime) || other.displayTime == displayTime));
}


@override
int get hashCode => Object.hash(runtimeType,displayTime);

@override
String toString() {
  return 'DeadlineResponse(displayTime: $displayTime)';
}


}

/// @nodoc
abstract mixin class $DeadlineResponseCopyWith<$Res>  {
  factory $DeadlineResponseCopyWith(DeadlineResponse value, $Res Function(DeadlineResponse) _then) = _$DeadlineResponseCopyWithImpl;
@useResult
$Res call({
 String displayTime
});




}
/// @nodoc
class _$DeadlineResponseCopyWithImpl<$Res>
    implements $DeadlineResponseCopyWith<$Res> {
  _$DeadlineResponseCopyWithImpl(this._self, this._then);

  final DeadlineResponse _self;
  final $Res Function(DeadlineResponse) _then;

/// Create a copy of DeadlineResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayTime = null,}) {
  return _then(_self.copyWith(
displayTime: null == displayTime ? _self.displayTime : displayTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeadlineResponse].
extension DeadlineResponsePatterns on DeadlineResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeadlineResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeadlineResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeadlineResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeadlineResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeadlineResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeadlineResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeadlineResponse() when $default != null:
return $default(_that.displayTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayTime)  $default,) {final _that = this;
switch (_that) {
case _DeadlineResponse():
return $default(_that.displayTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayTime)?  $default,) {final _that = this;
switch (_that) {
case _DeadlineResponse() when $default != null:
return $default(_that.displayTime);case _:
  return null;

}
}

}

/// @nodoc


class _DeadlineResponse extends DeadlineResponse {
   _DeadlineResponse({required this.displayTime}): super._();
  

@override final  String displayTime;

/// Create a copy of DeadlineResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeadlineResponseCopyWith<_DeadlineResponse> get copyWith => __$DeadlineResponseCopyWithImpl<_DeadlineResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeadlineResponse&&(identical(other.displayTime, displayTime) || other.displayTime == displayTime));
}


@override
int get hashCode => Object.hash(runtimeType,displayTime);

@override
String toString() {
  return 'DeadlineResponse(displayTime: $displayTime)';
}


}

/// @nodoc
abstract mixin class _$DeadlineResponseCopyWith<$Res> implements $DeadlineResponseCopyWith<$Res> {
  factory _$DeadlineResponseCopyWith(_DeadlineResponse value, $Res Function(_DeadlineResponse) _then) = __$DeadlineResponseCopyWithImpl;
@override @useResult
$Res call({
 String displayTime
});




}
/// @nodoc
class __$DeadlineResponseCopyWithImpl<$Res>
    implements _$DeadlineResponseCopyWith<$Res> {
  __$DeadlineResponseCopyWithImpl(this._self, this._then);

  final _DeadlineResponse _self;
  final $Res Function(_DeadlineResponse) _then;

/// Create a copy of DeadlineResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayTime = null,}) {
  return _then(_DeadlineResponse(
displayTime: null == displayTime ? _self.displayTime : displayTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
