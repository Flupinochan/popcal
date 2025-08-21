import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

extension type GroupId._(String value) {
  factory GroupId.create(String input) {
    return GroupId._(input);
  }

  static GroupId createDeadlineId() {
    return GroupId._('popcal-deadline');
  }

  static Result<GroupId> createFromRotationId(RotationId input) {
    return Result.ok(GroupId._(input.value));
  }
}
