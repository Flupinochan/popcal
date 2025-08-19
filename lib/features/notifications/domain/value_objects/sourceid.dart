import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

extension type SourceId._(String value) {
  factory SourceId.create(String input) {
    return SourceId._(input);
  }

  static SourceId createDeadlineId() {
    return SourceId._('popcal-deadline');
  }

  static Result<SourceId> createFromRotationId(RotationId input) {
    return Results.success(SourceId._(input.value));
  }
}
