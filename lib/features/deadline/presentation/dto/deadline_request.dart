import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/deadline/domain/entities/deadline.dart';

part 'deadline_request.freezed.dart';

/// request/response共通
@freezed
sealed class DeadlineRequest with _$DeadlineRequest {
  const factory DeadlineRequest({
    required bool isEnabled,
  }) = _DeadlineRequest;

  const DeadlineRequest._();

  Deadline toEntity() => Deadline(isEnabled: isEnabled);
}
