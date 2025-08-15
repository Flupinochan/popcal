import 'package:popcal/core/utils/failures/month_end_settings_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/infrastructure/dto/deadline_shared_preferences_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeadlineSharedPreferences {
  DeadlineSharedPreferences(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;
  final String _key = 'deadline.enabled';

  Future<Result<DeadlineSharedPreferencesResponse>> getSettings() async {
    try {
      // まだ設定が存在しなくnullの場合はfalse (初期値)
      final result = _sharedPreferences.getBool(_key) ?? false;
      return Results.success(
        DeadlineSharedPreferencesResponse(isEnabled: result),
      );
    } on Exception catch (error) {
      return Results.failure(
        MonthEndSettingsFailure('月末営業日通知の設定取得に失敗しました: $error'),
      );
    }
  }

  Future<Result<void>> saveSettings(
    DeadlineSharedPreferencesResponse dto,
  ) async {
    try {
      await _sharedPreferences.setBool(
        _key,
        dto.isEnabled,
      );
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(
        MonthEndSettingsFailure('月末営業日通知の設定保存に失敗しました: $error'),
      );
    }
  }
}
