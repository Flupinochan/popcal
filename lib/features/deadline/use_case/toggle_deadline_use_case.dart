import 'package:popcal/core/utils/failures/deadline_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';
import 'package:popcal/features/deadline/domain/repositories/deadline_repository.dart';

class ToggleDeadlineUseCase {
  ToggleDeadlineUseCase(this._deadlineRepository);
  final DeadlineRepository _deadlineRepository;

  Future<Result<Deadline>> execute(Deadline deadline) async {
    // 1. 設定on/offの保存
    final result = await _deadlineRepository.saveSettings(deadline);
    if (result.isFailure) {
      return Results.failure(DeadlineFailure(result.displayText));
    }

    // 2-1. on 通知登録
    if (deadline.isEnabled) {
      return Results.success(deadline);
    }

    // 2-2. off 通知削除
    return Results.success(deadline);
  }
}
