import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/month_end/domain/repositories/month_end_settings_repository.dart';
import 'package:popcal/features/month_end/infrastructure/repositories/month_end_settings_shared_preferences.dart';
import 'package:popcal/features/month_end/infrastructure/repositories/month_end_settings_shared_preferences_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'month_end_settings_providers.g.dart';

@Riverpod(keepAlive: true)
MonthEndSettingsRepository monthEndSettingsRepository(Ref ref) {
  final sharedPrefs = ref.watch(monthEndSettingsSharedPreferencesProvider);
  return MonthEndSettingsSharedPreferencesImpl(sharedPrefs);
}

@Riverpod(keepAlive: true)
MonthEndSettingsSharedPreferences monthEndSettingsSharedPreferences(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return MonthEndSettingsSharedPreferences(prefs);
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref _) {
  /// SharedPreferencesの初期化が非同期のためmain.dartでoverrideして初期化
  throw UnimplementedError('SharedPreferences not initialized');
}
