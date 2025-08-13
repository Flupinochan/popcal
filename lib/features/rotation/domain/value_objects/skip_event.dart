import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/skip_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';

part 'skip_event.freezed.dart';

@freezed
sealed class SkipEvent with _$SkipEvent {
  const factory SkipEvent({
    required DateKey date,
    required SkipType type,
    required SkipCount skipCount,
  }) = _SkipEvent;

  const SkipEvent._();
}
