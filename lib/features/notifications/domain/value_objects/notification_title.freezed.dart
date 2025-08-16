// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_title.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTitle {

 String get value;
/// Create a copy of NotificationTitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTitleCopyWith<NotificationTitle> get copyWith => _$NotificationTitleCopyWithImpl<NotificationTitle>(this as NotificationTitle, _$identity);

  /// Serializes this NotificationTitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTitle&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NotificationTitle(value: $value)';
}


}

/// @nodoc
abstract mixin class $NotificationTitleCopyWith<$Res>  {
  factory $NotificationTitleCopyWith(NotificationTitle value, $Res Function(NotificationTitle) _then) = _$NotificationTitleCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$NotificationTitleCopyWithImpl<$Res>
    implements $NotificationTitleCopyWith<$Res> {
  _$NotificationTitleCopyWithImpl(this._self, this._then);

  final NotificationTitle _self;
  final $Res Function(NotificationTitle) _then;

/// Create a copy of NotificationTitle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTitle].
extension NotificationTitlePatterns on NotificationTitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTitle value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTitle value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTitle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTitle() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value)  $default,) {final _that = this;
switch (_that) {
case _NotificationTitle():
return $default(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTitle() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTitle extends NotificationTitle {
  const _NotificationTitle({required this.value}): super._();
  factory _NotificationTitle.fromJson(Map<String, dynamic> json) => _$NotificationTitleFromJson(json);

@override final  String value;

/// Create a copy of NotificationTitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTitleCopyWith<_NotificationTitle> get copyWith => __$NotificationTitleCopyWithImpl<_NotificationTitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTitle&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NotificationTitle(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NotificationTitleCopyWith<$Res> implements $NotificationTitleCopyWith<$Res> {
  factory _$NotificationTitleCopyWith(_NotificationTitle value, $Res Function(_NotificationTitle) _then) = __$NotificationTitleCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$NotificationTitleCopyWithImpl<$Res>
    implements _$NotificationTitleCopyWith<$Res> {
  __$NotificationTitleCopyWithImpl(this._self, this._then);

  final _NotificationTitle _self;
  final $Res Function(_NotificationTitle) _then;

/// Create a copy of NotificationTitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_NotificationTitle(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
