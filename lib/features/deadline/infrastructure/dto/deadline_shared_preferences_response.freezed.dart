// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deadline_shared_preferences_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeadlineSharedPreferencesResponse {

 bool get isEnabled; int get hour; int get minute;
/// Create a copy of DeadlineSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeadlineSharedPreferencesResponseCopyWith<DeadlineSharedPreferencesResponse> get copyWith => _$DeadlineSharedPreferencesResponseCopyWithImpl<DeadlineSharedPreferencesResponse>(this as DeadlineSharedPreferencesResponse, _$identity);

  /// Serializes this DeadlineSharedPreferencesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeadlineSharedPreferencesResponse&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isEnabled,hour,minute);

@override
String toString() {
  return 'DeadlineSharedPreferencesResponse(isEnabled: $isEnabled, hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $DeadlineSharedPreferencesResponseCopyWith<$Res>  {
  factory $DeadlineSharedPreferencesResponseCopyWith(DeadlineSharedPreferencesResponse value, $Res Function(DeadlineSharedPreferencesResponse) _then) = _$DeadlineSharedPreferencesResponseCopyWithImpl;
@useResult
$Res call({
 bool isEnabled, int hour, int minute
});




}
/// @nodoc
class _$DeadlineSharedPreferencesResponseCopyWithImpl<$Res>
    implements $DeadlineSharedPreferencesResponseCopyWith<$Res> {
  _$DeadlineSharedPreferencesResponseCopyWithImpl(this._self, this._then);

  final DeadlineSharedPreferencesResponse _self;
  final $Res Function(DeadlineSharedPreferencesResponse) _then;

/// Create a copy of DeadlineSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,Object? hour = null,Object? minute = null,}) {
  return _then(_self.copyWith(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeadlineSharedPreferencesResponse].
extension DeadlineSharedPreferencesResponsePatterns on DeadlineSharedPreferencesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeadlineSharedPreferencesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeadlineSharedPreferencesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeadlineSharedPreferencesResponse value)  $default,){
final _that = this;
switch (_that) {
case _DeadlineSharedPreferencesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeadlineSharedPreferencesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DeadlineSharedPreferencesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isEnabled,  int hour,  int minute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeadlineSharedPreferencesResponse() when $default != null:
return $default(_that.isEnabled,_that.hour,_that.minute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isEnabled,  int hour,  int minute)  $default,) {final _that = this;
switch (_that) {
case _DeadlineSharedPreferencesResponse():
return $default(_that.isEnabled,_that.hour,_that.minute);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isEnabled,  int hour,  int minute)?  $default,) {final _that = this;
switch (_that) {
case _DeadlineSharedPreferencesResponse() when $default != null:
return $default(_that.isEnabled,_that.hour,_that.minute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeadlineSharedPreferencesResponse extends DeadlineSharedPreferencesResponse {
  const _DeadlineSharedPreferencesResponse({required this.isEnabled, required this.hour, required this.minute}): super._();
  factory _DeadlineSharedPreferencesResponse.fromJson(Map<String, dynamic> json) => _$DeadlineSharedPreferencesResponseFromJson(json);

@override final  bool isEnabled;
@override final  int hour;
@override final  int minute;

/// Create a copy of DeadlineSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeadlineSharedPreferencesResponseCopyWith<_DeadlineSharedPreferencesResponse> get copyWith => __$DeadlineSharedPreferencesResponseCopyWithImpl<_DeadlineSharedPreferencesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeadlineSharedPreferencesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeadlineSharedPreferencesResponse&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isEnabled,hour,minute);

@override
String toString() {
  return 'DeadlineSharedPreferencesResponse(isEnabled: $isEnabled, hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$DeadlineSharedPreferencesResponseCopyWith<$Res> implements $DeadlineSharedPreferencesResponseCopyWith<$Res> {
  factory _$DeadlineSharedPreferencesResponseCopyWith(_DeadlineSharedPreferencesResponse value, $Res Function(_DeadlineSharedPreferencesResponse) _then) = __$DeadlineSharedPreferencesResponseCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled, int hour, int minute
});




}
/// @nodoc
class __$DeadlineSharedPreferencesResponseCopyWithImpl<$Res>
    implements _$DeadlineSharedPreferencesResponseCopyWith<$Res> {
  __$DeadlineSharedPreferencesResponseCopyWithImpl(this._self, this._then);

  final _DeadlineSharedPreferencesResponse _self;
  final $Res Function(_DeadlineSharedPreferencesResponse) _then;

/// Create a copy of DeadlineSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,Object? hour = null,Object? minute = null,}) {
  return _then(_DeadlineSharedPreferencesResponse(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
