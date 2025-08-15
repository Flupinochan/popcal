import 'package:popcal/core/utils/failures/month_end_settings_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/deadline/domain/repositories/deadline_repository.dart';
import 'package:popcal/features/deadline/infrastructure/dto/deadline_shared_preferences_response.dart';
import 'package:popcal/features/deadline/infrastructure/repositories/deadline_shared_preferences.dart';

class DeadlineSharedPreferencesImpl extends DeadlineRepository {
  DeadlineSharedPreferencesImpl(
    this._deadlineSharedPreferences,
  );

  final DeadlineSharedPreferences _deadlineSharedPreferences;

  @override
  Future<Result<Deadline>> getSettings() async {
    final result = await _deadlineSharedPreferences.getSettings();
    if (result.isFailure) {
      return Results.failure(MonthEndSettingsFailure(result.displayText));
    }
    final dto = result.valueOrNull!;
    return Results.success(dto.toEntity());
  }

  @override
  Future<Result<void>> saveSettings(Deadline settings) async {
    final dto = DeadlineSharedPreferencesResponse.fromEntity(settings);
    final result = await _deadlineSharedPreferences.saveSettings(dto);
    if (result.isFailure) {
      return Results.failure(MonthEndSettingsFailure(result.displayText));
    }
    return Results.success(null);
  }
}
