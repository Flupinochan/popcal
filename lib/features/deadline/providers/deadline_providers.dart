import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/deadline/domain/repositories/deadline_repository.dart';
import 'package:popcal/features/deadline/infrastructure/repositories/deadline_shared_preferences.dart';
import 'package:popcal/features/deadline/infrastructure/repositories/deadline_shared_preferences_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'deadline_providers.g.dart';

@Riverpod(keepAlive: true)
DeadlineRepository deadlineRepository(Ref ref) {
  return DeadlineSharedPreferencesImpl(
    ref.watch(deadlineSharedPreferencesProvider),
  );
}

@Riverpod(keepAlive: true)
DeadlineSharedPreferences deadlineSharedPreferences(Ref ref) {
  return DeadlineSharedPreferences(ref.watch(sharedPreferencesProvider));
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref _) {
  /// SharedPreferencesの初期化が非同期のためmain.dartでoverrideして初期化
  throw UnimplementedError('SharedPreferences not initialized');
}
