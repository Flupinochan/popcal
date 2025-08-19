import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';

part 'deadline_shared_preferences_response.freezed.dart';
part 'deadline_shared_preferences_response.g.dart';

/// request/response共通
@freezed
sealed class DeadlineSharedPreferencesResponse
    with _$DeadlineSharedPreferencesResponse {
  /// freezedはTimeOfDayに対応していないため、intのhourとminuteを組み合わせたNotificationTimeをそのまま利用
  const factory DeadlineSharedPreferencesResponse({
    required bool isEnabled,
    required int hour,
    required int minute,
  }) = _DeadlineSharedPreferencesResponse;

  factory DeadlineSharedPreferencesResponse.fromEntity(
    Deadline entity,
  ) => DeadlineSharedPreferencesResponse(
    isEnabled: entity.isEnabled,
    hour: entity.notificationTime.hour,
    minute: entity.notificationTime.minute,
  );

  // JSON => DTO
  factory DeadlineSharedPreferencesResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$DeadlineSharedPreferencesResponseFromJson(json);

  const DeadlineSharedPreferencesResponse._();

  Result<Deadline> toEntity() {
    final result = NotificationTime.createFromInt(hour: hour, minute: minute);
    if (result.isFailure) {
      return Results.failure(ValidationFailure(result.displayText));
    }

    return Results.success(
      Deadline(isEnabled: isEnabled, notificationTime: result.valueOrNull!),
    );
  }

  // JSON => DTO
  static Result<DeadlineSharedPreferencesResponse> fromJsonSafe(
    Map<String, dynamic> json,
  ) {
    try {
      final dto = DeadlineSharedPreferencesResponse.fromJson(json);
      return Results.success(dto);
    } on Exception catch (e) {
      return Results.failure(ValidationFailure('JSON parsing failed: $e'));
    }
  }
}

extension DeadlineSharedPreferencesResponseJsonX
    on DeadlineSharedPreferencesResponse {
  // DTO => String(JSON)
  String toJsonString() => jsonEncode(toJson());

  // String(JSON) => DTO
  static DeadlineSharedPreferencesResponse fromJsonString(String jsonString) {
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    return DeadlineSharedPreferencesResponse.fromJson(map);
  }

  // String(JSON) => DTO
  static Result<DeadlineSharedPreferencesResponse> fromJsonStringSafe(
    String jsonString,
  ) {
    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return DeadlineSharedPreferencesResponse.fromJsonSafe(map);
    } on Exception catch (e) {
      return Results.failure(
        ValidationFailure('JSON string parsing failed: $e'),
      );
    }
  }
}
