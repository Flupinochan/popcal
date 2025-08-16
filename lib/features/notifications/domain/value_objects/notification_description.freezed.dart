// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationDescription {

 String get value;
/// Create a copy of NotificationDescription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDescriptionCopyWith<NotificationDescription> get copyWith => _$NotificationDescriptionCopyWithImpl<NotificationDescription>(this as NotificationDescription, _$identity);

  /// Serializes this NotificationDescription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDescription&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NotificationDescription(value: $value)';
}


}

/// @nodoc
abstract mixin class $NotificationDescriptionCopyWith<$Res>  {
  factory $NotificationDescriptionCopyWith(NotificationDescription value, $Res Function(NotificationDescription) _then) = _$NotificationDescriptionCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$NotificationDescriptionCopyWithImpl<$Res>
    implements $NotificationDescriptionCopyWith<$Res> {
  _$NotificationDescriptionCopyWithImpl(this._self, this._then);

  final NotificationDescription _self;
  final $Res Function(NotificationDescription) _then;

/// Create a copy of NotificationDescription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDescription].
extension NotificationDescriptionPatterns on NotificationDescription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDescription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDescription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDescription value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDescription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDescription value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDescription() when $default != null:
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
case _NotificationDescription() when $default != null:
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
case _NotificationDescription():
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
case _NotificationDescription() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDescription implements NotificationDescription {
  const _NotificationDescription({required this.value});
  factory _NotificationDescription.fromJson(Map<String, dynamic> json) => _$NotificationDescriptionFromJson(json);

@override final  String value;

/// Create a copy of NotificationDescription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDescriptionCopyWith<_NotificationDescription> get copyWith => __$NotificationDescriptionCopyWithImpl<_NotificationDescription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDescriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDescription&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'NotificationDescription(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NotificationDescriptionCopyWith<$Res> implements $NotificationDescriptionCopyWith<$Res> {
  factory _$NotificationDescriptionCopyWith(_NotificationDescription value, $Res Function(_NotificationDescription) _then) = __$NotificationDescriptionCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$NotificationDescriptionCopyWithImpl<$Res>
    implements _$NotificationDescriptionCopyWith<$Res> {
  __$NotificationDescriptionCopyWithImpl(this._self, this._then);

  final _NotificationDescription _self;
  final $Res Function(_NotificationDescription) _then;

/// Create a copy of NotificationDescription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_NotificationDescription(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
