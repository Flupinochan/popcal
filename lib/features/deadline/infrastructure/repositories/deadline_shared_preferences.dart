import 'package:flutter/material.dart';
import 'package:popcal/core/utils/failures/deadline_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/infrastructure/dto/deadline_shared_preferences_response.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/shared/utils/time_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeadlineSharedPreferences {
  DeadlineSharedPreferences(this._sharedPreferences, this._timeUtils);

  final SharedPreferences _sharedPreferences;
  final TimeUtils _timeUtils;
  final String _key = 'popcal_deadline';

  Future<Result<DeadlineSharedPreferencesResponse>> getSettings() async {
    try {
      // まだ設定が存在しなくnullの場合は以下の初期値を返す
      // 通知設定有効化: false
      // 通知時刻: 現在時刻
      final jsonString = _sharedPreferences.getString(_key);
      if (jsonString == null) {
        return Results.success(
          DeadlineSharedPreferencesResponse(
            isEnabled: false,
            notificationTime: NotificationTime(
              value: TimeOfDay.fromDateTime(_timeUtils.now()),
            ),
          ),
        );
      }

      final dtoResult =
          DeadlineSharedPreferencesResponseJsonX.fromJsonStringSafe(jsonString);
      if (dtoResult.isFailure) {
        return Results.failure(
          DeadlineFailure('月末営業日通知の設定取得に失敗しました: $dtoResult'),
        );
      }
      final dto = dtoResult.valueOrNull!;
      return Results.success(dto);
    } on Exception catch (error) {
      return Results.failure(
        DeadlineFailure('月末営業日通知の設定取得に失敗しました: $error'),
      );
    }
  }

  Future<Result<void>> saveSettings(
    DeadlineSharedPreferencesResponse dto,
  ) async {
    try {
      final jsonString = dto.toJson().toString();
      await _sharedPreferences.setString(_key, jsonString);
      return Results.success(null);
    } on Exception catch (error) {
      return Results.failure(
        DeadlineFailure('月末営業日通知の設定保存に失敗しました: $error'),
      );
    }
  }
}
