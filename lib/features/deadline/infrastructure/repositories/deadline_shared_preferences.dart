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
      final jsonString = _sharedPreferences.getString(_key);
      if (jsonString == null) {
        return Result.ok(_createDefaultSettings());
      }

      final dtoResult =
          DeadlineSharedPreferencesResponseJsonX.fromJsonStringSafe(jsonString);
      if (dtoResult.isError) {
        return await _handleSettingsError();
      }

      return Result.ok(dtoResult.value);
    } on Exception catch (_) {
      return _handleSettingsError();
    }
  }

  Future<Result<void>> removeSettings() async {
    try {
      await _sharedPreferences.remove(_key);

      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(
        DeadlineException('月末営業日通知の設定削除に失敗しました: $error'),
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

  /// ビジネスロジックのため、初期値取得用のメソッドを定義したいところ?
  /// まだ設定が存在しなくnullの場合は以下の初期値を返す
  /// 通知設定有効化: false
  /// 通知時刻: 現在時刻
  DeadlineSharedPreferencesResponse _createDefaultSettings() {
    final now = _timeUtils.now();

    return DeadlineSharedPreferencesResponse(
      isEnabled: false,
      hour: now.hour,
      minute: now.minute,
    );
  }

  /// 値取得失敗時は既存の値を削除して初期化
  Future<Result<DeadlineSharedPreferencesResponse>>
  _handleSettingsError() async {
    final removeResult = await removeSettings();
    if (removeResult.isError) {
      return Result.error(
        DeadlineException('月末営業日通知の設定取得に失敗しました: ${removeResult.error}'),
      );
    }

    return Result.ok(_createDefaultSettings());
  }
}
