import 'package:popcal/core/utils/exceptions/deadline_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_utils.dart';
import 'package:popcal/features/deadline/infrastructure/dto/deadline_shared_preferences_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeadlineSharedPreferences {
  DeadlineSharedPreferences(this._sharedPreferences, this._timeUtils);

  final SharedPreferences _sharedPreferences;
  final TimeUtils _timeUtils;
  final String _key = 'popcalDeadline';

  Future<Result<DeadlineSharedPreferencesResponse>> getSettings() async {
    try {
      // まだ設定が存在しなくnullの場合は以下の初期値を返す
      // 通知設定有効化: false
      // 通知時刻: 現在時刻
      final jsonString = _sharedPreferences.getString(_key);
      final now = _timeUtils.now();
      if (jsonString == null) {
        return Result.ok(
          DeadlineSharedPreferencesResponse(
            isEnabled: false,
            hour: now.hour,
            minute: now.minute,
          ),
        );
      }

      final dtoResult =
          DeadlineSharedPreferencesResponseJsonX.fromJsonStringSafe(jsonString);
      if (dtoResult.isError) {
        return Result.error(
          DeadlineException('月末営業日通知の設定取得に失敗しました: $dtoResult'),
        );
      }
      final dto = dtoResult.value;
      return Result.ok(dto);
    } on Exception catch (error) {
      return Result.error(
        DeadlineException('月末営業日通知の設定取得に失敗しました: $error'),
      );
    }
  }

  Future<Result<void>> saveSettings(
    DeadlineSharedPreferencesResponse dto,
  ) async {
    try {
      final jsonString = dto.toJsonString();
      await _sharedPreferences.setString(_key, jsonString);
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(
        DeadlineException('月末営業日通知の設定保存に失敗しました: $error'),
      );
    }
  }
}
