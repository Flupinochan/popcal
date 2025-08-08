import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';

part 'rotation_datetime.freezed.dart';

/// [RotationCreatedAt] or [RotationUpdatedAt] のUnion型
@freezed
sealed class RotationDateTime with _$RotationDateTime {
  const RotationDateTime._();

  const factory RotationDateTime.createdAt(RotationCreatedAt value) =
      _CreatedAt;
  const factory RotationDateTime.updatedAt(RotationUpdatedAt value) =
      _UpdatedAt;

  DateTime get dateTime {
    return switch (this) {
      _CreatedAt(value: final createdAt) => createdAt.value,
      _UpdatedAt(value: final updatedAt) => updatedAt.value,
    };
  }

  RotationDateTime add(Duration duration) {
    return switch (this) {
      _CreatedAt(value: final createdAt) => RotationDateTime.createdAt(
        createdAt.add(duration),
      ),
      _UpdatedAt(value: final updatedAt) => RotationDateTime.updatedAt(
        updatedAt.add(duration),
      ),
    };
  }

  bool isBefore(RotationDateTime other) => dateTime.isBefore(other.dateTime);
}
