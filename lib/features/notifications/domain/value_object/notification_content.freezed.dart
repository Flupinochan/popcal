// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

 String get rotationName; String get memberName; DateTime get rotationStartDate;
/// Create a copy of NotificationContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationContentCopyWith<NotificationContent> get copyWith => _$NotificationContentCopyWithImpl<NotificationContent>(this as NotificationContent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationContent&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.rotationStartDate, rotationStartDate) || other.rotationStartDate == rotationStartDate));
}


@override
int get hashCode => Object.hash(runtimeType,rotationName,memberName,rotationStartDate);

@override
String toString() {
  return 'NotificationContent(rotationName: $rotationName, memberName: $memberName, rotationStartDate: $rotationStartDate)';
}


}

/// @nodoc
abstract mixin class $NotificationContentCopyWith<$Res>  {
  factory $NotificationContentCopyWith(NotificationContent value, $Res Function(NotificationContent) _then) = _$NotificationContentCopyWithImpl;
@useResult
$Res call({
 String rotationName, String memberName, DateTime rotationStartDate
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
@pragma('vm:prefer-inline') @override $Res call({Object? rotationName = null,Object? memberName = null,Object? rotationStartDate = null,}) {
  return _then(_self.copyWith(
rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,rotationStartDate: null == rotationStartDate ? _self.rotationStartDate : rotationStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _NotificationContent extends NotificationContent {
  const _NotificationContent({required this.rotationName, required this.memberName, required this.rotationStartDate}): super._();
  

@override final  String rotationName;
@override final  String memberName;
@override final  DateTime rotationStartDate;

/// Create a copy of NotificationContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationContentCopyWith<_NotificationContent> get copyWith => __$NotificationContentCopyWithImpl<_NotificationContent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationContent&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.rotationStartDate, rotationStartDate) || other.rotationStartDate == rotationStartDate));
}


@override
int get hashCode => Object.hash(runtimeType,rotationName,memberName,rotationStartDate);

@override
String toString() {
  return 'NotificationContent(rotationName: $rotationName, memberName: $memberName, rotationStartDate: $rotationStartDate)';
}


}

/// @nodoc
abstract mixin class _$NotificationContentCopyWith<$Res> implements $NotificationContentCopyWith<$Res> {
  factory _$NotificationContentCopyWith(_NotificationContent value, $Res Function(_NotificationContent) _then) = __$NotificationContentCopyWithImpl;
@override @useResult
$Res call({
 String rotationName, String memberName, DateTime rotationStartDate
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
@override @pragma('vm:prefer-inline') $Res call({Object? rotationName = null,Object? memberName = null,Object? rotationStartDate = null,}) {
  return _then(_NotificationContent(
rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,rotationStartDate: null == rotationStartDate ? _self.rotationStartDate : rotationStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
