import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

/// 画面ルーティング用パス定義
abstract final class Routes {
  static const home = '/';
  static const auth = '/auth';
  static const rotation = '/rotation';
  static const rotationUpdate = '/rotation/:id';
  static const calendar = '/calendar/:id';
  static const error = '/error';

  static String rotationUpdatePath(RotationId rotationId) =>
      '/rotation/${rotationId.value}';
  static String calendarPath(RotationId rotationId) =>
      '/calendar/${rotationId.value}';
}
