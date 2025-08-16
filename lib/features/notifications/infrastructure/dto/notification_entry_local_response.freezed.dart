// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

// extentionTypeの場合は、@でJsonConverterへのマッピング定義が必要
@NotificationIdConverter() NotificationId get notificationId; SourceId get sourceId; UserId get userId;@NotificationDateConverter() NotificationDateTime get notificationDateTime; NotificationTitle get title; NotificationContent get content; NotificationDescription get description;
/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationEntryLocalResponseCopyWith<NotificationEntryLocalResponse> get copyWith => _$NotificationEntryLocalResponseCopyWithImpl<NotificationEntryLocalResponse>(this as NotificationEntryLocalResponse, _$identity);

  /// Serializes this NotificationEntryLocalResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEntryLocalResponse&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.notificationDateTime, notificationDateTime) || other.notificationDateTime == notificationDateTime)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,sourceId,userId,notificationDateTime,title,content,description);

@override
String toString() {
  return 'NotificationEntryLocalResponse(notificationId: $notificationId, sourceId: $sourceId, userId: $userId, notificationDateTime: $notificationDateTime, title: $title, content: $content, description: $description)';
}


}

/// @nodoc
abstract mixin class $NotificationEntryLocalResponseCopyWith<$Res>  {
  factory $NotificationEntryLocalResponseCopyWith(NotificationEntryLocalResponse value, $Res Function(NotificationEntryLocalResponse) _then) = _$NotificationEntryLocalResponseCopyWithImpl;
@useResult
$Res call({
@NotificationIdConverter() NotificationId notificationId, SourceId sourceId, UserId userId,@NotificationDateConverter() NotificationDateTime notificationDateTime, NotificationTitle title, NotificationContent content, NotificationDescription description
});


$SourceIdCopyWith<$Res> get sourceId;$UserIdCopyWith<$Res> get userId;$NotificationTitleCopyWith<$Res> get title;$NotificationContentCopyWith<$Res> get content;$NotificationDescriptionCopyWith<$Res> get description;

}
/// @nodoc
class _$NotificationEntryLocalResponseCopyWithImpl<$Res>
    implements $NotificationEntryLocalResponseCopyWith<$Res> {
  _$NotificationEntryLocalResponseCopyWithImpl(this._self, this._then);

  final NotificationEntryLocalResponse _self;
  final $Res Function(NotificationEntryLocalResponse) _then;

/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? sourceId = null,Object? userId = null,Object? notificationDateTime = null,Object? title = null,Object? content = null,Object? description = null,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as NotificationId,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as SourceId,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,notificationDateTime: null == notificationDateTime ? _self.notificationDateTime : notificationDateTime // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as NotificationTitle,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NotificationContent,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as NotificationDescription,
  ));
}
/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceIdCopyWith<$Res> get sourceId {
  
  return $SourceIdCopyWith<$Res>(_self.sourceId, (value) {
    return _then(_self.copyWith(sourceId: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTitleCopyWith<$Res> get title {
  
  return $NotificationTitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationContentCopyWith<$Res> get content {
  
  return $NotificationContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationDescriptionCopyWith<$Res> get description {
  
  return $NotificationDescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationEntryLocalResponse].
extension NotificationEntryLocalResponsePatterns on NotificationEntryLocalResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationEntryLocalResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationEntryLocalResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationEntryLocalResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationEntryLocalResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationEntryLocalResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationEntryLocalResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@NotificationIdConverter()  NotificationId notificationId,  SourceId sourceId,  UserId userId, @NotificationDateConverter()  NotificationDateTime notificationDateTime,  NotificationTitle title,  NotificationContent content,  NotificationDescription description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationEntryLocalResponse() when $default != null:
return $default(_that.notificationId,_that.sourceId,_that.userId,_that.notificationDateTime,_that.title,_that.content,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@NotificationIdConverter()  NotificationId notificationId,  SourceId sourceId,  UserId userId, @NotificationDateConverter()  NotificationDateTime notificationDateTime,  NotificationTitle title,  NotificationContent content,  NotificationDescription description)  $default,) {final _that = this;
switch (_that) {
case _NotificationEntryLocalResponse():
return $default(_that.notificationId,_that.sourceId,_that.userId,_that.notificationDateTime,_that.title,_that.content,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@NotificationIdConverter()  NotificationId notificationId,  SourceId sourceId,  UserId userId, @NotificationDateConverter()  NotificationDateTime notificationDateTime,  NotificationTitle title,  NotificationContent content,  NotificationDescription description)?  $default,) {final _that = this;
switch (_that) {
case _NotificationEntryLocalResponse() when $default != null:
return $default(_that.notificationId,_that.sourceId,_that.userId,_that.notificationDateTime,_that.title,_that.content,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationEntryLocalResponse extends NotificationEntryLocalResponse {
  const _NotificationEntryLocalResponse({@NotificationIdConverter() required this.notificationId, required this.sourceId, required this.userId, @NotificationDateConverter() required this.notificationDateTime, required this.title, required this.content, required this.description}): super._();
  factory _NotificationEntryLocalResponse.fromJson(Map<String, dynamic> json) => _$NotificationEntryLocalResponseFromJson(json);

// extentionTypeの場合は、@でJsonConverterへのマッピング定義が必要
@override@NotificationIdConverter() final  NotificationId notificationId;
@override final  SourceId sourceId;
@override final  UserId userId;
@override@NotificationDateConverter() final  NotificationDateTime notificationDateTime;
@override final  NotificationTitle title;
@override final  NotificationContent content;
@override final  NotificationDescription description;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationEntryLocalResponse&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.notificationDateTime, notificationDateTime) || other.notificationDateTime == notificationDateTime)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,sourceId,userId,notificationDateTime,title,content,description);

@override
String toString() {
  return 'NotificationEntryLocalResponse(notificationId: $notificationId, sourceId: $sourceId, userId: $userId, notificationDateTime: $notificationDateTime, title: $title, content: $content, description: $description)';
}


}

/// @nodoc
abstract mixin class _$NotificationEntryLocalResponseCopyWith<$Res> implements $NotificationEntryLocalResponseCopyWith<$Res> {
  factory _$NotificationEntryLocalResponseCopyWith(_NotificationEntryLocalResponse value, $Res Function(_NotificationEntryLocalResponse) _then) = __$NotificationEntryLocalResponseCopyWithImpl;
@override @useResult
$Res call({
@NotificationIdConverter() NotificationId notificationId, SourceId sourceId, UserId userId,@NotificationDateConverter() NotificationDateTime notificationDateTime, NotificationTitle title, NotificationContent content, NotificationDescription description
});


@override $SourceIdCopyWith<$Res> get sourceId;@override $UserIdCopyWith<$Res> get userId;@override $NotificationTitleCopyWith<$Res> get title;@override $NotificationContentCopyWith<$Res> get content;@override $NotificationDescriptionCopyWith<$Res> get description;

}
/// @nodoc
class __$NotificationEntryLocalResponseCopyWithImpl<$Res>
    implements _$NotificationEntryLocalResponseCopyWith<$Res> {
  __$NotificationEntryLocalResponseCopyWithImpl(this._self, this._then);

  final _NotificationEntryLocalResponse _self;
  final $Res Function(_NotificationEntryLocalResponse) _then;

/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? sourceId = null,Object? userId = null,Object? notificationDateTime = null,Object? title = null,Object? content = null,Object? description = null,}) {
  return _then(_NotificationEntryLocalResponse(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as NotificationId,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as SourceId,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,notificationDateTime: null == notificationDateTime ? _self.notificationDateTime : notificationDateTime // ignore: cast_nullable_to_non_nullable
as NotificationDateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as NotificationTitle,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NotificationContent,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as NotificationDescription,
  ));
}

/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourceIdCopyWith<$Res> get sourceId {
  
  return $SourceIdCopyWith<$Res>(_self.sourceId, (value) {
    return _then(_self.copyWith(sourceId: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTitleCopyWith<$Res> get title {
  
  return $NotificationTitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationContentCopyWith<$Res> get content {
  
  return $NotificationContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of NotificationEntryLocalResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationDescriptionCopyWith<$Res> get description {
  
  return $NotificationDescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}

// dart format on
