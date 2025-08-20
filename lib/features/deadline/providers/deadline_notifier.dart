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
    if (result.isError) {
      return Result.error(result.error);
    }
    final entity = result.value;

    return Result.ok(
      DeadlineRequest(
        isEnabled: entity.isEnabled,
        notificationTime: entity.notificationTime.timeOfDay,
      ),
    );
  }

  Future<void> execute(DeadlineRequest dto) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final entity = dto.toEntity();
      final toggleDeadlineUseCase = ref.read(toggleDeadlineUseCaseProvider);
      final result = await toggleDeadlineUseCase.execute(entity);
      if (result.isError) {
        return Result.error(result.error);
      }
      final finalEntity = result.value;
      return Result.ok(
        DeadlineRequest(
          isEnabled: finalEntity.isEnabled,
          notificationTime: finalEntity.notificationTime.timeOfDay,
        ),
      );
    });
  }
}
