// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_payload_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPayloadDto {

 int get notificationId; String get rotationGroupId; String get userId; String get rotationName; DateTime get notificationTime; String get memberName; DateTime get rotationStartDate;
/// Create a copy of NotificationPayloadDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPayloadDtoCopyWith<NotificationPayloadDto> get copyWith => _$NotificationPayloadDtoCopyWithImpl<NotificationPayloadDto>(this as NotificationPayloadDto, _$identity);

  /// Serializes this NotificationPayloadDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPayloadDto&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.rotationGroupId, rotationGroupId) || other.rotationGroupId == rotationGroupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.rotationStartDate, rotationStartDate) || other.rotationStartDate == rotationStartDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,rotationGroupId,userId,rotationName,notificationTime,memberName,rotationStartDate);

@override
String toString() {
  return 'NotificationPayloadDto(notificationId: $notificationId, rotationGroupId: $rotationGroupId, userId: $userId, rotationName: $rotationName, notificationTime: $notificationTime, memberName: $memberName, rotationStartDate: $rotationStartDate)';
}


}

/// @nodoc
abstract mixin class $NotificationPayloadDtoCopyWith<$Res>  {
  factory $NotificationPayloadDtoCopyWith(NotificationPayloadDto value, $Res Function(NotificationPayloadDto) _then) = _$NotificationPayloadDtoCopyWithImpl;
@useResult
$Res call({
 int notificationId, String rotationGroupId, String userId, String rotationName, DateTime notificationTime, String memberName, DateTime rotationStartDate
});




}
/// @nodoc
class _$NotificationPayloadDtoCopyWithImpl<$Res>
    implements $NotificationPayloadDtoCopyWith<$Res> {
  _$NotificationPayloadDtoCopyWithImpl(this._self, this._then);

  final NotificationPayloadDto _self;
  final $Res Function(NotificationPayloadDto) _then;

/// Create a copy of NotificationPayloadDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? rotationGroupId = null,Object? userId = null,Object? rotationName = null,Object? notificationTime = null,Object? memberName = null,Object? rotationStartDate = null,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,rotationGroupId: null == rotationGroupId ? _self.rotationGroupId : rotationGroupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,rotationStartDate: null == rotationStartDate ? _self.rotationStartDate : rotationStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NotificationPayloadDto extends NotificationPayloadDto {
  const _NotificationPayloadDto({required this.notificationId, required this.rotationGroupId, required this.userId, required this.rotationName, required this.notificationTime, required this.memberName, required this.rotationStartDate}): super._();
  factory _NotificationPayloadDto.fromJson(Map<String, dynamic> json) => _$NotificationPayloadDtoFromJson(json);

@override final  int notificationId;
@override final  String rotationGroupId;
@override final  String userId;
@override final  String rotationName;
@override final  DateTime notificationTime;
@override final  String memberName;
@override final  DateTime rotationStartDate;

/// Create a copy of NotificationPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPayloadDtoCopyWith<_NotificationPayloadDto> get copyWith => __$NotificationPayloadDtoCopyWithImpl<_NotificationPayloadDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPayloadDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPayloadDto&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.rotationGroupId, rotationGroupId) || other.rotationGroupId == rotationGroupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.rotationStartDate, rotationStartDate) || other.rotationStartDate == rotationStartDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,rotationGroupId,userId,rotationName,notificationTime,memberName,rotationStartDate);

@override
String toString() {
  return 'NotificationPayloadDto(notificationId: $notificationId, rotationGroupId: $rotationGroupId, userId: $userId, rotationName: $rotationName, notificationTime: $notificationTime, memberName: $memberName, rotationStartDate: $rotationStartDate)';
}


}

/// @nodoc
abstract mixin class _$NotificationPayloadDtoCopyWith<$Res> implements $NotificationPayloadDtoCopyWith<$Res> {
  factory _$NotificationPayloadDtoCopyWith(_NotificationPayloadDto value, $Res Function(_NotificationPayloadDto) _then) = __$NotificationPayloadDtoCopyWithImpl;
@override @useResult
$Res call({
 int notificationId, String rotationGroupId, String userId, String rotationName, DateTime notificationTime, String memberName, DateTime rotationStartDate
});




}
/// @nodoc
class __$NotificationPayloadDtoCopyWithImpl<$Res>
    implements _$NotificationPayloadDtoCopyWith<$Res> {
  __$NotificationPayloadDtoCopyWithImpl(this._self, this._then);

  final _NotificationPayloadDto _self;
  final $Res Function(_NotificationPayloadDto) _then;

/// Create a copy of NotificationPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? rotationGroupId = null,Object? userId = null,Object? rotationName = null,Object? notificationTime = null,Object? memberName = null,Object? rotationStartDate = null,}) {
  return _then(_NotificationPayloadDto(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,rotationGroupId: null == rotationGroupId ? _self.rotationGroupId : rotationGroupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,rotationStartDate: null == rotationStartDate ? _self.rotationStartDate : rotationStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
