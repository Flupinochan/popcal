import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/exceptions/calendar_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

part 'skip_events.freezed.dart';

@freezed
sealed class SkipEvents with _$SkipEvents {
  const factory SkipEvents(List<SkipEvent> value) = _SkipEvents;

  const SkipEvents._();

  @useResult
  Result<SkipEvents> add(SkipEvent skipEvent) {
    if (value.any((e) => e.dateKey == skipEvent.dateKey)) {
      return const Result.error(
        CalendarException('すでにSkipEventが存在するため新規追加できません'),
      );
    }

    return Result.ok(SkipEvents([...value, skipEvent]));
  }

  // 対象DateKeyのSkipEventのskipToNextのskipCountを1減少させる
  // 0になる場合は削除
  SkipEvents decrementSkipToNext(DateKey targetDateKey) {
    final updateSkipEvents = <SkipEvent>[];

    for (final skipEvent in value) {
      if (skipEvent.dayType == DayType.skipToNext &&
          skipEvent.dateKey == targetDateKey) {
        // Decrementせずcontinue(追加)しないことで削除
        if (!skipEvent.skipCount.canDecrement()) {
          continue;
        }

        final result = skipEvent.skipCount.decrement();
        if (result.isError) {
          continue;
        }
        updateSkipEvents.add(
          skipEvent.copyWith(
            skipCount: result.value,
          ),
        );
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
  SkipEvents incrementSkipToNext({
    required DateKey targetDateKey,
    required RotationMemberNames rotationMemberNames,
  }) {
    final updateSkipEvents = <SkipEvent>[];
    var foundTarget = false;

    for (final skipEvent in value) {
      // すでに対象日付(DateKey)のSkipEventがある場合はSkipCountをIncrement
      if (skipEvent.dayType == DayType.skipToNext &&
          skipEvent.dateKey == targetDateKey) {
        final skipCountResult = skipEvent.skipCount.increment(
          rotationMemberNames,
        );
        if (skipCountResult.isError) {
          continue;
        }

        updateSkipEvents.add(
          skipEvent.copyWith(
            skipCount: skipCountResult.value,
          ),
        );
        foundTarget = true;
      } else {
        updateSkipEvents.add(skipEvent);
      }
    }

    // なかった場合は新規追加
    if (!foundTarget) {
      updateSkipEvents.add(
        SkipEvent(
          dateKey: targetDateKey,
          dayType: DayType.skipToNext,
          skipCount: SkipCount(),
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
