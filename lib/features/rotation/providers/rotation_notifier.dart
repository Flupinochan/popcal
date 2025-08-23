import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_utils.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_notifier.g.dart';

@riverpod
class RotationNotifier extends _$RotationNotifier {
  TimeUtils get _timeUtils => ref.read(timeUtilsProvider);

  @override
  FutureOr<Result<RotationResponse>?> build() async => null;

  // 関数でRotationResponseはreturnせずstateに値を格納する
  // .isLoadingでUIを動的に変更
  // ref.listenで非同期処理完了後にactionを実行
  Future<void> createRotation(
    CreateRotationRequest dto,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentTime = _timeUtils.now();

      final entityResult = dto.toEntity(currentTime: currentTime);
      if (entityResult.isError) {
        return Result.error(entityResult.error);
      }

      final useCaseResult = await ref
          .read(createRotationUseCaseProvider)
          .execute(entityResult.value);
      if (useCaseResult.isError) {
        return Result.error(useCaseResult.error);
      }

      return Result.ok(
        RotationResponse.fromEntity(useCaseResult.value),
      );
    });
  }

  Future<void> updateRotation(
    UpdateRotationRequest dto,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentTime = _timeUtils.now();

      final userIdResult = UserId.create(dto.userId);
      if (userIdResult.isError) {
        return Result.error(userIdResult.error);
      }

      final rotationIdResult = RotationId.create(dto.rotationId);
      if (rotationIdResult.isError) {
        return Result.error(rotationIdResult.error);
      }

      final rotationNameResult = RotationName.create(dto.rotationName);
      if (rotationNameResult.isError) {
        return Result.error(rotationNameResult.error);
      }

      final rotationMemberNamesResult = RotationMemberNames.create(
        dto.rotationMembers,
      );
      if (rotationMemberNamesResult.isError) {
        return Result.error(rotationMemberNamesResult.error);
      }

      final rotationDaysResult = RotationDays.create(dto.rotationDays);
      if (rotationDaysResult.isError) {
        return Result.error(rotationDaysResult.error);
      }

      final rotationUpdatedAtResult = RotationUpdatedAt.create(currentTime);
      if (rotationUpdatedAtResult.isError) {
        return Result.error(rotationUpdatedAtResult.error);
      }

      final notificationTimeResult = NotificationTime.fromTimeOfDay(
        dto.notificationTime,
      );

      final useCaseResult = await ref
          .read(updateRotationUseCaseProvider)
          .execute(
            userId: userIdResult.value,
            rotationId: rotationIdResult.value,
            updateRotationName: rotationNameResult.value,
            updateRotationMemberNames: rotationMemberNamesResult.value,
            updateRotationDays: rotationDaysResult.value,
            updateNotificationTime: notificationTimeResult,
            updateSkipEvents: dto.skipEvents,
            rotationUpdatedAt: rotationUpdatedAtResult.value,
          );
      if (useCaseResult.isError) {
        return Result.error(useCaseResult.error);
      }

      return Result.ok(
        RotationResponse.fromEntity(useCaseResult.value),
      );
    });
  }
}
