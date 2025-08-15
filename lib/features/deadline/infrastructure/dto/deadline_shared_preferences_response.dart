import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';

part 'deadline_shared_preferences_response.freezed.dart';

/// request/response共通
@freezed
sealed class DeadlineSharedPreferencesResponse
    with _$DeadlineSharedPreferencesResponse {
  const factory DeadlineSharedPreferencesResponse({
    required bool isEnabled,
  }) = _DeadlineSharedPreferencesResponse;

  factory DeadlineSharedPreferencesResponse.fromEntity(
    Deadline entity,
  ) => DeadlineSharedPreferencesResponse(
    isEnabled: entity.isEnabled,
  );

  const DeadlineSharedPreferencesResponse._();

  Deadline toEntity() => Deadline(
    isEnabled: isEnabled,
  );
}
