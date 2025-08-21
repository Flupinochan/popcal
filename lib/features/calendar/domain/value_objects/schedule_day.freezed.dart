// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleDay {

 NotificationDateTime get notificationDateTime; RotationMemberName get memberName; DayType get scheduleType; MemberColor get memberColor; bool get canSkipNext; bool get canSkipPrevious; bool get canDisableHoliday; bool get canEnableHoliday; bool get isValidRotationDay;
/// Create a copy of ScheduleDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleDayCopyWith<ScheduleDay> get copyWith => _$ScheduleDayCopyWithImpl<ScheduleDay>(this as ScheduleDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleDay&&(identical(other.notificationDateTime, notificationDateTime) || other.notificationDateTime == notificationDateTime)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.scheduleType, scheduleType) || other.scheduleType == scheduleType)&&(identical(other.memberColor, memberColor) || other.memberColor == memberColor)&&(identical(other.canSkipNext, canSkipNext) || other.canSkipNext == canSkipNext)&&(identical(other.canSkipPrevious, canSkipPrevious) || other.canSkipPrevious == canSkipPrevious)&&(identical(other.canDisableHoliday, canDisableHoliday) || other.canDisableHoliday == canDisableHoliday)&&(identical(other.canEnableHoliday, canEnableHoliday) || other.canEnableHoliday == canEnableHoliday)&&(identical(other.isValidRotationDay, isValidRotationDay) || other.isValidRotationDay == isValidRotationDay));
}


@override
int get hashCode => Object.hash(runtimeType,notificationDateTime,memberName,scheduleType,memberColor,canSkipNext,canSkipPrevious,canDisableHoliday,canEnableHoliday,isValidRotationDay);

@override
String toString() {
  return 'ScheduleDay(notificationDateTime: $notificationDateTime, memberName: $memberName, scheduleType: $scheduleType, memberColor: $memberColor, canSkipNext: $canSkipNext, canSkipPrevious: $canSkipPrevious, canDisableHoliday: $canDisableHoliday, canEnableHoliday: $canEnableHoliday, isValidRotationDay: $isValidRotationDay)';
}


}

/// @nodoc
abstract mixin class $ScheduleDayCopyWith<$Res>  {
  factory $ScheduleDayCopyWith(ScheduleDay value, $Res Function(ScheduleDay) _then) = _$ScheduleDayCopyWithImpl;
@useResult
$Res call({
 NotificationDateTime notificationDateTime, RotationMemberName memberName, DayType scheduleType, MemberColor memberColor, bool canSkipNext, bool canSkipPrevious, bool canDisableHoliday, bool canEnableHoliday, bool isValidRotationDay
});




}
/// @nodoc
class _$ScheduleDayCopyWithImpl<$Res>
    implements $ScheduleDayCopyWith<$Res> {
  _$ScheduleDayCopyWithImpl(this._self, this._then);

  final ScheduleDay _self;
  final $Res Function(ScheduleDay) _then;

/// Create a copy of ScheduleDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationDateTime = null,Object? memberName = null,Object? scheduleType = null,Object? memberColor = null,Object? canSkipNext = null,Object? canSkipPrevious = null,Object? canDisableHoliday = null,Object? canEnableHoliday = null,Object? isValidRotationDay = null,}) {
  return _then(_self.copyWith(
notificationDateTime: null == notificationDateTime ? _self.notificationDateTime : notificationDateTime // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as RotationMemberName,scheduleType: null == scheduleType ? _self.scheduleType : scheduleType // ignore: cast_nullable_to_non_nullable
as DayType,memberColor: null == memberColor ? _self.memberColor : memberColor // ignore: cast_nullable_to_non_nullable
as MemberColor,canSkipNext: null == canSkipNext ? _self.canSkipNext : canSkipNext // ignore: cast_nullable_to_non_nullable
as bool,canSkipPrevious: null == canSkipPrevious ? _self.canSkipPrevious : canSkipPrevious // ignore: cast_nullable_to_non_nullable
as bool,canDisableHoliday: null == canDisableHoliday ? _self.canDisableHoliday : canDisableHoliday // ignore: cast_nullable_to_non_nullable
as bool,canEnableHoliday: null == canEnableHoliday ? _self.canEnableHoliday : canEnableHoliday // ignore: cast_nullable_to_non_nullable
as bool,isValidRotationDay: null == isValidRotationDay ? _self.isValidRotationDay : isValidRotationDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleDay].
extension ScheduleDayPatterns on ScheduleDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleDay value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleDay value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationDateTime notificationDateTime,  RotationMemberName memberName,  DayType scheduleType,  MemberColor memberColor,  bool canSkipNext,  bool canSkipPrevious,  bool canDisableHoliday,  bool canEnableHoliday,  bool isValidRotationDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleDay() when $default != null:
return $default(_that.notificationDateTime,_that.memberName,_that.scheduleType,_that.memberColor,_that.canSkipNext,_that.canSkipPrevious,_that.canDisableHoliday,_that.canEnableHoliday,_that.isValidRotationDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationDateTime notificationDateTime,  RotationMemberName memberName,  DayType scheduleType,  MemberColor memberColor,  bool canSkipNext,  bool canSkipPrevious,  bool canDisableHoliday,  bool canEnableHoliday,  bool isValidRotationDay)  $default,) {final _that = this;
switch (_that) {
case _ScheduleDay():
return $default(_that.notificationDateTime,_that.memberName,_that.scheduleType,_that.memberColor,_that.canSkipNext,_that.canSkipPrevious,_that.canDisableHoliday,_that.canEnableHoliday,_that.isValidRotationDay);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationDateTime notificationDateTime,  RotationMemberName memberName,  DayType scheduleType,  MemberColor memberColor,  bool canSkipNext,  bool canSkipPrevious,  bool canDisableHoliday,  bool canEnableHoliday,  bool isValidRotationDay)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleDay() when $default != null:
return $default(_that.notificationDateTime,_that.memberName,_that.scheduleType,_that.memberColor,_that.canSkipNext,_that.canSkipPrevious,_that.canDisableHoliday,_that.canEnableHoliday,_that.isValidRotationDay);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleDay extends ScheduleDay {
  const _ScheduleDay({required this.notificationDateTime, required this.memberName, required this.scheduleType, required this.memberColor, required this.canSkipNext, required this.canSkipPrevious, required this.canDisableHoliday, required this.canEnableHoliday, required this.isValidRotationDay}): super._();
  

@override final  NotificationDateTime notificationDateTime;
@override final  RotationMemberName memberName;
@override final  DayType scheduleType;
@override final  MemberColor memberColor;
@override final  bool canSkipNext;
@override final  bool canSkipPrevious;
@override final  bool canDisableHoliday;
@override final  bool canEnableHoliday;
@override final  bool isValidRotationDay;

/// Create a copy of ScheduleDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleDayCopyWith<_ScheduleDay> get copyWith => __$ScheduleDayCopyWithImpl<_ScheduleDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleDay&&(identical(other.notificationDateTime, notificationDateTime) || other.notificationDateTime == notificationDateTime)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.scheduleType, scheduleType) || other.scheduleType == scheduleType)&&(identical(other.memberColor, memberColor) || other.memberColor == memberColor)&&(identical(other.canSkipNext, canSkipNext) || other.canSkipNext == canSkipNext)&&(identical(other.canSkipPrevious, canSkipPrevious) || other.canSkipPrevious == canSkipPrevious)&&(identical(other.canDisableHoliday, canDisableHoliday) || other.canDisableHoliday == canDisableHoliday)&&(identical(other.canEnableHoliday, canEnableHoliday) || other.canEnableHoliday == canEnableHoliday)&&(identical(other.isValidRotationDay, isValidRotationDay) || other.isValidRotationDay == isValidRotationDay));
}


@override
int get hashCode => Object.hash(runtimeType,notificationDateTime,memberName,scheduleType,memberColor,canSkipNext,canSkipPrevious,canDisableHoliday,canEnableHoliday,isValidRotationDay);

@override
String toString() {
  return 'ScheduleDay(notificationDateTime: $notificationDateTime, memberName: $memberName, scheduleType: $scheduleType, memberColor: $memberColor, canSkipNext: $canSkipNext, canSkipPrevious: $canSkipPrevious, canDisableHoliday: $canDisableHoliday, canEnableHoliday: $canEnableHoliday, isValidRotationDay: $isValidRotationDay)';
}


}

/// @nodoc
abstract mixin class _$ScheduleDayCopyWith<$Res> implements $ScheduleDayCopyWith<$Res> {
  factory _$ScheduleDayCopyWith(_ScheduleDay value, $Res Function(_ScheduleDay) _then) = __$ScheduleDayCopyWithImpl;
@override @useResult
$Res call({
 NotificationDateTime notificationDateTime, RotationMemberName memberName, DayType scheduleType, MemberColor memberColor, bool canSkipNext, bool canSkipPrevious, bool canDisableHoliday, bool canEnableHoliday, bool isValidRotationDay
});




}
/// @nodoc
class __$ScheduleDayCopyWithImpl<$Res>
    implements _$ScheduleDayCopyWith<$Res> {
  __$ScheduleDayCopyWithImpl(this._self, this._then);

  final _ScheduleDay _self;
  final $Res Function(_ScheduleDay) _then;

/// Create a copy of ScheduleDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationDateTime = null,Object? memberName = null,Object? scheduleType = null,Object? memberColor = null,Object? canSkipNext = null,Object? canSkipPrevious = null,Object? canDisableHoliday = null,Object? canEnableHoliday = null,Object? isValidRotationDay = null,}) {
  return _then(_ScheduleDay(
notificationDateTime: null == notificationDateTime ? _self.notificationDateTime : notificationDateTime // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as RotationMemberName,scheduleType: null == scheduleType ? _self.scheduleType : scheduleType // ignore: cast_nullable_to_non_nullable
as DayType,memberColor: null == memberColor ? _self.memberColor : memberColor // ignore: cast_nullable_to_non_nullable
as MemberColor,canSkipNext: null == canSkipNext ? _self.canSkipNext : canSkipNext // ignore: cast_nullable_to_non_nullable
as bool,canSkipPrevious: null == canSkipPrevious ? _self.canSkipPrevious : canSkipPrevious // ignore: cast_nullable_to_non_nullable
as bool,canDisableHoliday: null == canDisableHoliday ? _self.canDisableHoliday : canDisableHoliday // ignore: cast_nullable_to_non_nullable
as bool,canEnableHoliday: null == canEnableHoliday ? _self.canEnableHoliday : canEnableHoliday // ignore: cast_nullable_to_non_nullable
as bool,isValidRotationDay: null == isValidRotationDay ? _self.isValidRotationDay : isValidRotationDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
