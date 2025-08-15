import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/calendar_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

part 'skip_events.freezed.dart';
part 'skip_events.g.dart';

@freezed
sealed class SkipEvents with _$SkipEvents {
  const factory SkipEvents(List<SkipEvent> value) = _SkipEvents;

  factory SkipEvents.fromJson(Map<String, dynamic> json) =>
      _$SkipEventsFromJson(json);

  const SkipEvents._();

  @useResult
  Result<SkipEvents> add(SkipEvent skipEvent) {
    if (value.any((e) => e.dateKey == skipEvent.dateKey)) {
      return Results.failure<SkipEvents>(
        const CalendarFailure('すでにSkipEventが存在するため新規追加できません'),
      );
    }
    return Results.success(SkipEvents([...value, skipEvent]));
  }

  // 対象DateKeyのSkipEventのskipToNextのskipCountを1減少させる
  // 0になる場合は削除
  SkipEvents decrementSkipToNext(DateKey targetDateKey) {
    final updateSkipEvents = <SkipEvent>[];

    for (final skipEvent in value) {
      if (skipEvent.dayType == DayType.skipToNext &&
          skipEvent.dateKey == targetDateKey) {
        final skipCount = skipEvent.skipCount.skipCount;
        if (skipCount > 1) {
          // skipCountが1より大きい場合はskipCountを-1する
          updateSkipEvents.add(
            skipEvent.copyWith(
              skipCount: SkipCount(skipCount: skipCount - 1),
            ),
          );
        }
        // skipCountが1以下の場合は追加しない = 削除
      } else {
        updateSkipEvents.add(skipEvent);
      }
    }

    return SkipEvents(updateSkipEvents);
  }

  // 対象DateKeyのSkipEventを検索するメソッド
  SkipEvent? getByDateKey(DateKey dateKey) {
    return value.firstWhereOrNull(
      (skipEvent) => skipEvent.dateKey == dateKey,
    );
  }

  // 対象DateKeyのSkipEventのSkipCountを1増加させる
  // 存在しない場合はskipToNextのSkipEventを追加
  SkipEvents incrementSkipToNext(DateKey targetDateKey) {
    final updateSkipEvents = <SkipEvent>[];
    var foundTarget = false;

    for (final skipEvent in value) {
      if (skipEvent.dayType == DayType.skipToNext &&
          skipEvent.dateKey == targetDateKey) {
        updateSkipEvents.add(
          skipEvent.copyWith(
            skipCount: SkipCount(skipCount: skipEvent.skipCount.skipCount + 1),
          ),
        );
        foundTarget = true;
      } else {
        updateSkipEvents.add(skipEvent);
      }
    }

    if (!foundTarget) {
      updateSkipEvents.add(
        SkipEvent(
          dateKey: targetDateKey,
          dayType: DayType.skipToNext,
          skipCount: const SkipCount(skipCount: 1),
        ),
      );
    }

    return SkipEvents(updateSkipEvents);
  }

  SkipEvents removeByDateKey(DateKey dateKey) {
    return SkipEvents(
      value.where((skipEvent) => skipEvent.dateKey != dateKey).toList(),
    );
  }

  static SkipEvents empty() => const SkipEvents([]);
}
