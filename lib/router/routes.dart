/// 画面ルーティング用パス定義
abstract final class Routes {
  static const home = '/';
  static const auth = '/auth';
  static const rotation = '/rotation';
  static const rotationUpdate = '/rotation/:id';
  static const calendar = '/calendar/:id';

  static String rotationUpdatePath(String id) => '/rotation/$id';
  static String calendarPath(String id) => '/calendar/$id';
}
