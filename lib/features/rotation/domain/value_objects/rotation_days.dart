import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

part 'rotation_days.freezed.dart';
part 'rotation_days.g.dart';

@freezed
sealed class RotationDays with _$RotationDays {
  const factory RotationDays(
    List<Weekday> value,
  ) = _RotationDays;

  factory RotationDays.fromJson(Map<String, dynamic> json) =>
      _$RotationDaysFromJson(json);

  const RotationDays._();

  bool get isEmpty => value.isEmpty;

  RotationDays add(Weekday weekday) {
    if (contains(weekday)) {
      return this;
    }

    return RotationDays([...value, weekday]);
  }

  bool contains(Weekday weekday) => value.contains(weekday);

  RotationDays remove(Weekday weekday) {
    if (!contains(weekday)) {
      return this;
    }

    return RotationDays(value.where((day) => day != weekday).toList());
  }

  List<int> toIntList() => value.map((weekday) => weekday.value).toList();

  @override
  String toString() => value.map((day) => day.displayName).join(', ');

  static Result<RotationDays> create(List<int>? input) {
    if (input == null || input.isEmpty) {
      return Results.failure(const ValidationFailure('ローテーション曜日を1つ以上追加してください'));
    }

    final weekdays =
        input
            .where((value) => value >= 1 && value <= 7)
            .map(Weekday.fromInt)
            .toList();

    if (weekdays.isEmpty) {
      return Results.failure(const ValidationFailure('有効な曜日データがありません'));
    }

    return Results.success(RotationDays(weekdays));
  }

  // ignore: avoid-dynamic
  static Result<RotationDays> createFromDynamic(List<dynamic>? input) {
    if (input == null || input.isEmpty) {
      return Results.failure(const ValidationFailure('ローテーション曜日を1つ以上追加してください'));
    }

    final weekdays =
        input
            .where((item) => item != null)
            .map((item) => int.tryParse(item.toString()))
            .where((value) => value != null && value >= 1 && value <= 7)
            .map((value) => Weekday.fromInt(value!))
            .toList();

    if (weekdays.isEmpty) {
      return Results.failure(const ValidationFailure('有効な曜日データがありません'));
    }

    return Results.success(RotationDays(weekdays));
  }

  static RotationDays empty() => const RotationDays([]);
}
