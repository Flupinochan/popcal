// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_end_settings_shared_preferences_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthEndSettingsSharedPreferencesResponse {

 bool get isEnabled;
/// Create a copy of MonthEndSettingsSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthEndSettingsSharedPreferencesResponseCopyWith<MonthEndSettingsSharedPreferencesResponse> get copyWith => _$MonthEndSettingsSharedPreferencesResponseCopyWithImpl<MonthEndSettingsSharedPreferencesResponse>(this as MonthEndSettingsSharedPreferencesResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthEndSettingsSharedPreferencesResponse&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled);

@override
String toString() {
  return 'MonthEndSettingsSharedPreferencesResponse(isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class $MonthEndSettingsSharedPreferencesResponseCopyWith<$Res>  {
  factory $MonthEndSettingsSharedPreferencesResponseCopyWith(MonthEndSettingsSharedPreferencesResponse value, $Res Function(MonthEndSettingsSharedPreferencesResponse) _then) = _$MonthEndSettingsSharedPreferencesResponseCopyWithImpl;
@useResult
$Res call({
 bool isEnabled
});




}
/// @nodoc
class _$MonthEndSettingsSharedPreferencesResponseCopyWithImpl<$Res>
    implements $MonthEndSettingsSharedPreferencesResponseCopyWith<$Res> {
  _$MonthEndSettingsSharedPreferencesResponseCopyWithImpl(this._self, this._then);

  final MonthEndSettingsSharedPreferencesResponse _self;
  final $Res Function(MonthEndSettingsSharedPreferencesResponse) _then;

/// Create a copy of MonthEndSettingsSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,}) {
  return _then(_self.copyWith(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthEndSettingsSharedPreferencesResponse].
extension MonthEndSettingsSharedPreferencesResponsePatterns on MonthEndSettingsSharedPreferencesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthEndSettingsSharedPreferencesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthEndSettingsSharedPreferencesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthEndSettingsSharedPreferencesResponse value)  $default,){
final _that = this;
switch (_that) {
case _MonthEndSettingsSharedPreferencesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthEndSettingsSharedPreferencesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MonthEndSettingsSharedPreferencesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthEndSettingsSharedPreferencesResponse() when $default != null:
return $default(_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _MonthEndSettingsSharedPreferencesResponse():
return $default(_that.isEnabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _MonthEndSettingsSharedPreferencesResponse() when $default != null:
return $default(_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _MonthEndSettingsSharedPreferencesResponse extends MonthEndSettingsSharedPreferencesResponse {
  const _MonthEndSettingsSharedPreferencesResponse({required this.isEnabled}): super._();
  

@override final  bool isEnabled;

/// Create a copy of MonthEndSettingsSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthEndSettingsSharedPreferencesResponseCopyWith<_MonthEndSettingsSharedPreferencesResponse> get copyWith => __$MonthEndSettingsSharedPreferencesResponseCopyWithImpl<_MonthEndSettingsSharedPreferencesResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthEndSettingsSharedPreferencesResponse&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled);

@override
String toString() {
  return 'MonthEndSettingsSharedPreferencesResponse(isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$MonthEndSettingsSharedPreferencesResponseCopyWith<$Res> implements $MonthEndSettingsSharedPreferencesResponseCopyWith<$Res> {
  factory _$MonthEndSettingsSharedPreferencesResponseCopyWith(_MonthEndSettingsSharedPreferencesResponse value, $Res Function(_MonthEndSettingsSharedPreferencesResponse) _then) = __$MonthEndSettingsSharedPreferencesResponseCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled
});




}
/// @nodoc
class __$MonthEndSettingsSharedPreferencesResponseCopyWithImpl<$Res>
    implements _$MonthEndSettingsSharedPreferencesResponseCopyWith<$Res> {
  __$MonthEndSettingsSharedPreferencesResponseCopyWithImpl(this._self, this._then);

  final _MonthEndSettingsSharedPreferencesResponse _self;
  final $Res Function(_MonthEndSettingsSharedPreferencesResponse) _then;

/// Create a copy of MonthEndSettingsSharedPreferencesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,}) {
  return _then(_MonthEndSettingsSharedPreferencesResponse(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
