// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSchedule {

// 30日分の通知設定計算結果
 List<NotificationSetting> get notificationEntries;// 通知計算の後にローテーション情報を更新するために必要
 RotationIndex get newCurrentRotationIndex;
/// Create a copy of NotificationSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationScheduleCopyWith<NotificationSchedule> get copyWith => _$NotificationScheduleCopyWithImpl<NotificationSchedule>(this as NotificationSchedule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSchedule&&const DeepCollectionEquality().equals(other.notificationEntries, notificationEntries)&&(identical(other.newCurrentRotationIndex, newCurrentRotationIndex) || other.newCurrentRotationIndex == newCurrentRotationIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notificationEntries),newCurrentRotationIndex);

@override
String toString() {
  return 'NotificationSchedule(notificationEntries: $notificationEntries, newCurrentRotationIndex: $newCurrentRotationIndex)';
}


}

/// @nodoc
abstract mixin class $NotificationScheduleCopyWith<$Res>  {
  factory $NotificationScheduleCopyWith(NotificationSchedule value, $Res Function(NotificationSchedule) _then) = _$NotificationScheduleCopyWithImpl;
@useResult
$Res call({
 List<NotificationSetting> notificationEntries, RotationIndex newCurrentRotationIndex
});




}
/// @nodoc
class _$NotificationScheduleCopyWithImpl<$Res>
    implements $NotificationScheduleCopyWith<$Res> {
  _$NotificationScheduleCopyWithImpl(this._self, this._then);

  final NotificationSchedule _self;
  final $Res Function(NotificationSchedule) _then;

/// Create a copy of NotificationSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationEntries = null,Object? newCurrentRotationIndex = null,}) {
  return _then(_self.copyWith(
notificationEntries: null == notificationEntries ? _self.notificationEntries : notificationEntries // ignore: cast_nullable_to_non_nullable
as List<NotificationSetting>,newCurrentRotationIndex: null == newCurrentRotationIndex ? _self.newCurrentRotationIndex : newCurrentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSchedule].
extension NotificationSchedulePatterns on NotificationSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSchedule value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationSetting> notificationEntries,  RotationIndex newCurrentRotationIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSchedule() when $default != null:
return $default(_that.notificationEntries,_that.newCurrentRotationIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationSetting> notificationEntries,  RotationIndex newCurrentRotationIndex)  $default,) {final _that = this;
switch (_that) {
case _NotificationSchedule():
return $default(_that.notificationEntries,_that.newCurrentRotationIndex);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationSetting> notificationEntries,  RotationIndex newCurrentRotationIndex)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSchedule() when $default != null:
return $default(_that.notificationEntries,_that.newCurrentRotationIndex);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationSchedule extends NotificationSchedule {
  const _NotificationSchedule({required final  List<NotificationSetting> notificationEntries, required this.newCurrentRotationIndex}): _notificationEntries = notificationEntries,super._();
  

// 30日分の通知設定計算結果
 final  List<NotificationSetting> _notificationEntries;
// 30日分の通知設定計算結果
@override List<NotificationSetting> get notificationEntries {
  if (_notificationEntries is EqualUnmodifiableListView) return _notificationEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationEntries);
}

// 通知計算の後にローテーション情報を更新するために必要
@override final  RotationIndex newCurrentRotationIndex;

/// Create a copy of NotificationSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationScheduleCopyWith<_NotificationSchedule> get copyWith => __$NotificationScheduleCopyWithImpl<_NotificationSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSchedule&&const DeepCollectionEquality().equals(other._notificationEntries, _notificationEntries)&&(identical(other.newCurrentRotationIndex, newCurrentRotationIndex) || other.newCurrentRotationIndex == newCurrentRotationIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notificationEntries),newCurrentRotationIndex);

@override
String toString() {
  return 'NotificationSchedule(notificationEntries: $notificationEntries, newCurrentRotationIndex: $newCurrentRotationIndex)';
}


}

/// @nodoc
abstract mixin class _$NotificationScheduleCopyWith<$Res> implements $NotificationScheduleCopyWith<$Res> {
  factory _$NotificationScheduleCopyWith(_NotificationSchedule value, $Res Function(_NotificationSchedule) _then) = __$NotificationScheduleCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationSetting> notificationEntries, RotationIndex newCurrentRotationIndex
});




}
/// @nodoc
class __$NotificationScheduleCopyWithImpl<$Res>
    implements _$NotificationScheduleCopyWith<$Res> {
  __$NotificationScheduleCopyWithImpl(this._self, this._then);

  final _NotificationSchedule _self;
  final $Res Function(_NotificationSchedule) _then;

/// Create a copy of NotificationSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationEntries = null,Object? newCurrentRotationIndex = null,}) {
  return _then(_NotificationSchedule(
notificationEntries: null == notificationEntries ? _self._notificationEntries : notificationEntries // ignore: cast_nullable_to_non_nullable
as List<NotificationSetting>,newCurrentRotationIndex: null == newCurrentRotationIndex ? _self.newCurrentRotationIndex : newCurrentRotationIndex // ignore: cast_nullable_to_non_nullable
as RotationIndex,
  ));
}


}

// dart format on
