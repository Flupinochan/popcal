import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';

part 'skip_event.freezed.dart';
part 'skip_event.g.dart';

@freezed
sealed class SkipEvent with _$SkipEvent {
  const factory SkipEvent({
    required DateKey dateKey,
    required DayType dayType,
    required SkipCount skipCount,
  }) = _SkipEvent;

  factory SkipEvent.fromJson(Map<String, dynamic> json) =>
      _$SkipEventFromJson(json);

  const SkipEvent._();
}
