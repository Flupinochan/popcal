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
    if (result.isError) {
      return Result.error(result.error);
    }
    final dto = result.value;

    final entityResult = dto.toEntity();
    if (entityResult.isError) {
      return Result.error(entityResult.error);
    }

    return Result.ok(entityResult.value);
  }

  @override
  Future<Result<void>> removeSettings() async {
    final result = await _deadlineSharedPreferences.removeSettings();
    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }

  @override
  Future<Result<void>> saveSettings(Deadline settings) async {
    final dto = DeadlineSharedPreferencesResponse.fromEntity(settings);
    final result = await _deadlineSharedPreferences.saveSettings(dto);
    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }
}
