import 'package:popcal/features/notifications/domain/services/result/day_calculation_data.dart';

/// _calculateRotationScheduleにおける共通の計算結果
class RotationCalculationData {
  const RotationCalculationData({
    required this.dayCalculationDatas,
    required this.newRotationIndex,
  });

  final List<DayCalculationData> dayCalculationDatas;
  final int newRotationIndex;
}
