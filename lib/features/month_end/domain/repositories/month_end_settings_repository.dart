import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/month_end/domain/entities/month_end_settings.dart';

abstract class MonthEndSettingsRepository {
  Future<Result<MonthEndSettings>> getSettings();
  Future<Result<void>> saveSettings(MonthEndSettings settings);
}
