import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';

abstract class DeadlineRepository {
  Future<Result<Deadline>> getSettings();
  Future<Result<void>> removeSettings();
  Future<Result<void>> saveSettings(Deadline settings);
}
