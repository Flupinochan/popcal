import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';

class MockRotationDays {
  static const RotationDays rotationDays = RotationDays([
    Weekday.tuesday,
    Weekday.thursday,
  ]);
}
