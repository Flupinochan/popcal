import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/month_end/domain/entities/month_end_settings.dart';

part 'month_end_settings_shared_preferences_response.freezed.dart';

/// request/response共通
@freezed
sealed class MonthEndSettingsSharedPreferencesResponse
    with _$MonthEndSettingsSharedPreferencesResponse {
  const factory MonthEndSettingsSharedPreferencesResponse({
    required bool isEnabled,
  }) = _MonthEndSettingsSharedPreferencesResponse;

  factory MonthEndSettingsSharedPreferencesResponse.fromEntity(
    MonthEndSettings entity,
  ) => MonthEndSettingsSharedPreferencesResponse(
    isEnabled: entity.isEnabled,
  );

  const MonthEndSettingsSharedPreferencesResponse._();

  MonthEndSettings toEntity() => MonthEndSettings(
    isEnabled: isEnabled,
  );
}
