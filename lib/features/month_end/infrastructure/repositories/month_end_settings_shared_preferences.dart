import 'package:popcal/core/utils/failures/month_end_settings_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/month_end/infrastructure/dto/month_end_settings_shared_preferences_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonthEndSettingsSharedPreferences {
  MonthEndSettingsSharedPreferences(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;
  final String _key = 'month.end.settings.enabled';

  Future<Result<MonthEndSettingsSharedPreferencesResponse>>
  getSettings() async {
    try {
      // まだ設定が存在しなくnullの場合はfalse (初期値)
      final result = _sharedPreferences.getBool(_key) ?? false;
      return Results.success(
        MonthEndSettingsSharedPreferencesResponse(isEnabled: result),
      );
    } on Exception catch (error) {
      return Results.failure(
        MonthEndSettingsFailure('月末営業日通知の設定取得に失敗しました: $error'),
      );
    }
  }

  Future<Result<void>> saveSettings(
    MonthEndSettingsSharedPreferencesResponse settings,
  ) async {
    try {
      await _sharedPreferences.setBool(
        _key,
        settings.isEnabled,
      );
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(
        MonthEndSettingsFailure('月末営業日通知の設定保存に失敗しました: $error'),
      );
    }
  }
}
