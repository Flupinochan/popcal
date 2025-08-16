// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationContent {

 String get value;
/// Create a copy of NotificationContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationContentCopyWith<NotificationContent> get copyWith => _$NotificationContentCopyWithImpl<NotificationContent>(this as NotificationContent, _$identity);

  /// Serializes this NotificationContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationContent&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NotificationContent(value: $value)';
}


}

/// @nodoc
abstract mixin class $NotificationContentCopyWith<$Res>  {
  factory $NotificationContentCopyWith(NotificationContent value, $Res Function(NotificationContent) _then) = _$NotificationContentCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$NotificationContentCopyWithImpl<$Res>
    implements $NotificationContentCopyWith<$Res> {
  _$NotificationContentCopyWithImpl(this._self, this._then);

  final NotificationContent _self;
  final $Res Function(NotificationContent) _then;

/// Create a copy of NotificationContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationContent].
extension NotificationContentPatterns on NotificationContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationContent value)  $default,){
final _that = this;
switch (_that) {
case _NotificationContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationContent value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationContent() when $default != null:
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
case _NotificationContent() when $default != null:
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
case _NotificationContent():
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
case _NotificationContent() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationContent extends NotificationContent {
  const _NotificationContent({required this.value}): super._();
  factory _NotificationContent.fromJson(Map<String, dynamic> json) => _$NotificationContentFromJson(json);

@override final  String value;

/// Create a copy of NotificationContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationContentCopyWith<_NotificationContent> get copyWith => __$NotificationContentCopyWithImpl<_NotificationContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationContent&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NotificationContent(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NotificationContentCopyWith<$Res> implements $NotificationContentCopyWith<$Res> {
  factory _$NotificationContentCopyWith(_NotificationContent value, $Res Function(_NotificationContent) _then) = __$NotificationContentCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$NotificationContentCopyWithImpl<$Res>
    implements _$NotificationContentCopyWith<$Res> {
  __$NotificationContentCopyWithImpl(this._self, this._then);

  final _NotificationContent _self;
  final $Res Function(_NotificationContent) _then;

/// Create a copy of NotificationContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_NotificationContent(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
