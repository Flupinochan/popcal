// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSetting {

 NotificationId get notificationId;// GroupIdはポップアップ通知をタップした際のカレンダー画面遷移で必要
 GroupId get groupId; NotificationDateTime get notificationDateTime; NotificationTitle get title; NotificationContent get content; NotificationDescription get description;
/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingCopyWith<NotificationSetting> get copyWith => _$NotificationSettingCopyWithImpl<NotificationSetting>(this as NotificationSetting, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSetting&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.notificationDateTime, notificationDateTime) || other.notificationDateTime == notificationDateTime)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId,groupId,notificationDateTime,title,content,description);

@override
String toString() {
  return 'NotificationSetting(notificationId: $notificationId, groupId: $groupId, notificationDateTime: $notificationDateTime, title: $title, content: $content, description: $description)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingCopyWith<$Res>  {
  factory $NotificationSettingCopyWith(NotificationSetting value, $Res Function(NotificationSetting) _then) = _$NotificationSettingCopyWithImpl;
@useResult
$Res call({
 NotificationId notificationId, GroupId groupId, NotificationDateTime notificationDateTime, NotificationTitle title, NotificationContent content, NotificationDescription description
});




}
/// @nodoc
class _$NotificationSettingCopyWithImpl<$Res>
    implements $NotificationSettingCopyWith<$Res> {
  _$NotificationSettingCopyWithImpl(this._self, this._then);

  final NotificationSetting _self;
  final $Res Function(NotificationSetting) _then;

/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? groupId = null,Object? notificationDateTime = null,Object? title = null,Object? content = null,Object? description = null,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as NotificationId,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as GroupId,notificationDateTime: null == notificationDateTime ? _self.notificationDateTime : notificationDateTime // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as NotificationTitle,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NotificationContent,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as NotificationDescription,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSetting].
extension NotificationSettingPatterns on NotificationSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSetting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSetting value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSetting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSetting value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSetting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationId notificationId,  GroupId groupId,  NotificationDateTime notificationDateTime,  NotificationTitle title,  NotificationContent content,  NotificationDescription description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSetting() when $default != null:
return $default(_that.notificationId,_that.groupId,_that.notificationDateTime,_that.title,_that.content,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationId notificationId,  GroupId groupId,  NotificationDateTime notificationDateTime,  NotificationTitle title,  NotificationContent content,  NotificationDescription description)  $default,) {final _that = this;
switch (_that) {
case _NotificationSetting():
return $default(_that.notificationId,_that.groupId,_that.notificationDateTime,_that.title,_that.content,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationId notificationId,  GroupId groupId,  NotificationDateTime notificationDateTime,  NotificationTitle title,  NotificationContent content,  NotificationDescription description)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSetting() when $default != null:
return $default(_that.notificationId,_that.groupId,_that.notificationDateTime,_that.title,_that.content,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationSetting extends NotificationSetting {
  const _NotificationSetting({required this.notificationId, required this.groupId, required this.notificationDateTime, required this.title, required this.content, required this.description}): super._();
  

@override final  NotificationId notificationId;
// GroupIdはポップアップ通知をタップした際のカレンダー画面遷移で必要
@override final  GroupId groupId;
@override final  NotificationDateTime notificationDateTime;
@override final  NotificationTitle title;
@override final  NotificationContent content;
@override final  NotificationDescription description;

/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingCopyWith<_NotificationSetting> get copyWith => __$NotificationSettingCopyWithImpl<_NotificationSetting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSetting&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.notificationDateTime, notificationDateTime) || other.notificationDateTime == notificationDateTime)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId,groupId,notificationDateTime,title,content,description);

@override
String toString() {
  return 'NotificationSetting(notificationId: $notificationId, groupId: $groupId, notificationDateTime: $notificationDateTime, title: $title, content: $content, description: $description)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingCopyWith<$Res> implements $NotificationSettingCopyWith<$Res> {
  factory _$NotificationSettingCopyWith(_NotificationSetting value, $Res Function(_NotificationSetting) _then) = __$NotificationSettingCopyWithImpl;
@override @useResult
$Res call({
 NotificationId notificationId, GroupId groupId, NotificationDateTime notificationDateTime, NotificationTitle title, NotificationContent content, NotificationDescription description
});




}
/// @nodoc
class __$NotificationSettingCopyWithImpl<$Res>
    implements _$NotificationSettingCopyWith<$Res> {
  __$NotificationSettingCopyWithImpl(this._self, this._then);

  final _NotificationSetting _self;
  final $Res Function(_NotificationSetting) _then;

/// Create a copy of NotificationSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? groupId = null,Object? notificationDateTime = null,Object? title = null,Object? content = null,Object? description = null,}) {
  return _then(_NotificationSetting(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as NotificationId,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as GroupId,notificationDateTime: null == notificationDateTime ? _self.notificationDateTime : notificationDateTime // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as NotificationTitle,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NotificationContent,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as NotificationDescription,
  ));
}


}

// dart format on
