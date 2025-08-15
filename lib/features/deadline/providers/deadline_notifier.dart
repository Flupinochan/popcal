import 'package:popcal/core/utils/failures/deadline_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/presentation/dto/deadline_request.dart';
import 'package:popcal/features/deadline/providers/deadline_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deadline_notifier.g.dart';

@riverpod
class DeadlineNotifier extends _$DeadlineNotifier {
  @override
  FutureOr<Result<DeadlineRequest>> build() async {
    final deadlineRepository = ref.watch(deadlineRepositoryProvider);
    final result = await deadlineRepository.getSettings();
    if (result.isFailure) {
      return Results.failure(DeadlineFailure(result.displayText));
    }
    final entity = result.valueOrNull!;
    return Results.success(DeadlineRequest(isEnabled: entity.isEnabled));
  }

  Future<void> execute(DeadlineRequest dto) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final entity = dto.toEntity();
      final toggleDeadlineUseCase = ref.read(toggleDeadlineUseCaseProvider);
      final result = await toggleDeadlineUseCase.execute(entity);
      if (result.isFailure) {
        return Results.failure(DeadlineFailure(result.displayText));
      }
      final finalEntity = result.valueOrNull!;
      return Results.success(DeadlineRequest(isEnabled: finalEntity.isEnabled));
    });
  }
}
