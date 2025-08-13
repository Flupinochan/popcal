import 'package:popcal/features/notifications/domain/value_objects/day_calculation_data.dart';

class RotationCalculationData {
  const RotationCalculationData({
    required this.dayCalculationDatas,
    required this.newRotationIndex,
  });

  final List<DayCalculationData> dayCalculationDatas;
  final int newRotationIndex;
}
