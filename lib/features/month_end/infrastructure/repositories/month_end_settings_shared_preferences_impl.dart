import 'package:popcal/core/utils/failures/month_end_settings_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/month_end/domain/entities/month_end_settings.dart';
import 'package:popcal/features/month_end/domain/repositories/month_end_settings_repository.dart';
import 'package:popcal/features/month_end/infrastructure/dto/month_end_settings_shared_preferences_response.dart';
import 'package:popcal/features/month_end/infrastructure/repositories/month_end_settings_shared_preferences.dart';

class MonthEndSettingsSharedPreferencesImpl extends MonthEndSettingsRepository {
  MonthEndSettingsSharedPreferencesImpl(
    this._monthEndSettingsSharedPreferences,
  );

  final MonthEndSettingsSharedPreferences _monthEndSettingsSharedPreferences;

  @override
  Future<Result<MonthEndSettings>> getSettings() async {
    final result = await _monthEndSettingsSharedPreferences.getSettings();
    if (result.isFailure) {
      return Results.failure(MonthEndSettingsFailure(result.displayText));
    }
    final dto = result.valueOrNull!;
    return Results.success(dto.toEntity());
  }

  @override
  Future<Result<void>> saveSettings(MonthEndSettings settings) async {
    final dto = MonthEndSettingsSharedPreferencesResponse.fromEntity(settings);
    final result = await _monthEndSettingsSharedPreferences.saveSettings(dto);
    if (result.isFailure) {
      return Results.failure(MonthEndSettingsFailure(result.displayText));
    }
    return Results.success(null);
  }
}
