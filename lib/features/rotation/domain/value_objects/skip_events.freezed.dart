// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkipEvents {

 List<SkipEvent> get value;
/// Create a copy of SkipEvents
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipEventsCopyWith<SkipEvents> get copyWith => _$SkipEventsCopyWithImpl<SkipEvents>(this as SkipEvents, _$identity);

  /// Serializes this SkipEvents to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipEvents&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SkipEvents(value: $value)';
}


}

/// @nodoc
abstract mixin class $SkipEventsCopyWith<$Res>  {
  factory $SkipEventsCopyWith(SkipEvents value, $Res Function(SkipEvents) _then) = _$SkipEventsCopyWithImpl;
@useResult
$Res call({
 List<SkipEvent> value
});




}
/// @nodoc
class _$SkipEventsCopyWithImpl<$Res>
    implements $SkipEventsCopyWith<$Res> {
  _$SkipEventsCopyWithImpl(this._self, this._then);

  final SkipEvents _self;
  final $Res Function(SkipEvents) _then;

/// Create a copy of SkipEvents
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as List<SkipEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [SkipEvents].
extension SkipEventsPatterns on SkipEvents {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipEvents value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipEvents() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipEvents value)  $default,){
final _that = this;
switch (_that) {
case _SkipEvents():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipEvents value)?  $default,){
final _that = this;
switch (_that) {
case _SkipEvents() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SkipEvent> value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipEvents() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SkipEvent> value)  $default,) {final _that = this;
switch (_that) {
case _SkipEvents():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SkipEvent> value)?  $default,) {final _that = this;
switch (_that) {
case _SkipEvents() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkipEvents extends SkipEvents {
  const _SkipEvents(final  List<SkipEvent> value): _value = value,super._();
  factory _SkipEvents.fromJson(Map<String, dynamic> json) => _$SkipEventsFromJson(json);

 final  List<SkipEvent> _value;
@override List<SkipEvent> get value {
  if (_value is EqualUnmodifiableListView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_value);
}


/// Create a copy of SkipEvents
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipEventsCopyWith<_SkipEvents> get copyWith => __$SkipEventsCopyWithImpl<_SkipEvents>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkipEventsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipEvents&&const DeepCollectionEquality().equals(other._value, _value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_value));

@override
String toString() {
  return 'SkipEvents(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SkipEventsCopyWith<$Res> implements $SkipEventsCopyWith<$Res> {
  factory _$SkipEventsCopyWith(_SkipEvents value, $Res Function(_SkipEvents) _then) = __$SkipEventsCopyWithImpl;
@override @useResult
$Res call({
 List<SkipEvent> value
});




}
/// @nodoc
class __$SkipEventsCopyWithImpl<$Res>
    implements _$SkipEventsCopyWith<$Res> {
  __$SkipEventsCopyWithImpl(this._self, this._then);

  final _SkipEvents _self;
  final $Res Function(_SkipEvents) _then;

/// Create a copy of SkipEvents
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SkipEvents(
null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as List<SkipEvent>,
  ));
}


}

// dart format on
