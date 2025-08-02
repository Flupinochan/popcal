import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/presentation/dto/user_view_model_dto.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_data.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

part 'calendar_data_dto.freezed.dart';

@freezed
sealed class CalendarDataDto with _$CalendarDataDto {
  const CalendarDataDto._();

  const factory CalendarDataDto({
    required UserViewModelDto userViewModelDto,
    required RotationGroup rotationGroup,
    required List<NotificationDetail> notificationDetails,
  }) = _CalendarDataDto;

  // Entity => DTO
  factory CalendarDataDto.fromEntity(CalendarData entity) {
    return CalendarDataDto(
      userViewModelDto: UserViewModelDto.fromEntity(entity.appUser),
      rotationGroup: entity.rotationGroup,
      notificationDetails: entity.notificationDetails,
    );
  }

  // DTO => Entity
  Result<CalendarData> toEntity() {
    final result = userViewModelDto.toEntity();
    return result.when(
      success:
          (calendarData) => Results.success(
            CalendarData(
              appUser: result.valueOrNull!,
              rotationGroup: rotationGroup,
              notificationDetails: notificationDetails,
            ),
          ),
      failure: (error) => Results.failure(CalendarFailure(error.message)),
    );
  }
}
