// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_entry_local_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationEntryLocalResponse {

 int get notificationId; String get rotationId; String get userId; String get rotationName; DateTime get notificationTime; String get memberName; DateTime get rotationStartDate; String get title; String get description; String get content;
/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationEntryLocalResponseCopyWith<NotificationEntryLocalResponse> get copyWith => _$NotificationEntryLocalResponseCopyWithImpl<NotificationEntryLocalResponse>(this as NotificationEntryLocalResponse, _$identity);

  /// Serializes this NotificationEntryLocalResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEntryLocalResponse&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.rotationStartDate, rotationStartDate) || other.rotationStartDate == rotationStartDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,rotationId,userId,rotationName,notificationTime,memberName,rotationStartDate,title,description,content);

@override
String toString() {
  return 'NotificationEntryLocalResponse(notificationId: $notificationId, rotationId: $rotationId, userId: $userId, rotationName: $rotationName, notificationTime: $notificationTime, memberName: $memberName, rotationStartDate: $rotationStartDate, title: $title, description: $description, content: $content)';
}


}

/// @nodoc
abstract mixin class $NotificationEntryLocalResponseCopyWith<$Res>  {
  factory $NotificationEntryLocalResponseCopyWith(NotificationEntryLocalResponse value, $Res Function(NotificationEntryLocalResponse) _then) = _$NotificationEntryLocalResponseCopyWithImpl;
@useResult
$Res call({
 int notificationId, String rotationId, String userId, String rotationName, DateTime notificationTime, String memberName, DateTime rotationStartDate, String title, String description, String content
});




}
/// @nodoc
class _$NotificationEntryLocalResponseCopyWithImpl<$Res>
    implements $NotificationEntryLocalResponseCopyWith<$Res> {
  _$NotificationEntryLocalResponseCopyWithImpl(this._self, this._then);

  final NotificationEntryLocalResponse _self;
  final $Res Function(NotificationEntryLocalResponse) _then;

/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? notificationTime = null,Object? memberName = null,Object? rotationStartDate = null,Object? title = null,Object? description = null,Object? content = null,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,rotationStartDate: null == rotationStartDate ? _self.rotationStartDate : rotationStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NotificationEntryLocalResponse extends NotificationEntryLocalResponse {
  const _NotificationEntryLocalResponse({required this.notificationId, required this.rotationId, required this.userId, required this.rotationName, required this.notificationTime, required this.memberName, required this.rotationStartDate, required this.title, required this.description, required this.content}): super._();
  factory _NotificationEntryLocalResponse.fromJson(Map<String, dynamic> json) => _$NotificationEntryLocalResponseFromJson(json);

@override final  int notificationId;
@override final  String rotationId;
@override final  String userId;
@override final  String rotationName;
@override final  DateTime notificationTime;
@override final  String memberName;
@override final  DateTime rotationStartDate;
@override final  String title;
@override final  String description;
@override final  String content;

/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationEntryLocalResponseCopyWith<_NotificationEntryLocalResponse> get copyWith => __$NotificationEntryLocalResponseCopyWithImpl<_NotificationEntryLocalResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationEntryLocalResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationEntryLocalResponse&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.rotationId, rotationId) || other.rotationId == rotationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rotationName, rotationName) || other.rotationName == rotationName)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.rotationStartDate, rotationStartDate) || other.rotationStartDate == rotationStartDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,rotationId,userId,rotationName,notificationTime,memberName,rotationStartDate,title,description,content);

@override
String toString() {
  return 'NotificationEntryLocalResponse(notificationId: $notificationId, rotationId: $rotationId, userId: $userId, rotationName: $rotationName, notificationTime: $notificationTime, memberName: $memberName, rotationStartDate: $rotationStartDate, title: $title, description: $description, content: $content)';
}


}

/// @nodoc
abstract mixin class _$NotificationEntryLocalResponseCopyWith<$Res> implements $NotificationEntryLocalResponseCopyWith<$Res> {
  factory _$NotificationEntryLocalResponseCopyWith(_NotificationEntryLocalResponse value, $Res Function(_NotificationEntryLocalResponse) _then) = __$NotificationEntryLocalResponseCopyWithImpl;
@override @useResult
$Res call({
 int notificationId, String rotationId, String userId, String rotationName, DateTime notificationTime, String memberName, DateTime rotationStartDate, String title, String description, String content
});




}
/// @nodoc
class __$NotificationEntryLocalResponseCopyWithImpl<$Res>
    implements _$NotificationEntryLocalResponseCopyWith<$Res> {
  __$NotificationEntryLocalResponseCopyWithImpl(this._self, this._then);

  final _NotificationEntryLocalResponse _self;
  final $Res Function(_NotificationEntryLocalResponse) _then;

/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? rotationId = null,Object? userId = null,Object? rotationName = null,Object? notificationTime = null,Object? memberName = null,Object? rotationStartDate = null,Object? title = null,Object? description = null,Object? content = null,}) {
  return _then(_NotificationEntryLocalResponse(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,rotationId: null == rotationId ? _self.rotationId : rotationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rotationName: null == rotationName ? _self.rotationName : rotationName // ignore: cast_nullable_to_non_nullable
as String,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as DateTime,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,rotationStartDate: null == rotationStartDate ? _self.rotationStartDate : rotationStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
