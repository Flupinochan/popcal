/// 画面ルーティング用パス定義
abstract final class Routes {
  static const home = '/';
  static const auth = '/auth';
  static const search = '/$searchRelative'; // 絶対パス
  static const searchRelative = 'search'; // 相対パス
  static String homeWithId(int id) => '$home/$id'; // 動的パス
}
