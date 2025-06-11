import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/notification_data.dart';

/// プッシュ通知機能のリポジトリ
/// モバイルアプリのプッシュ通知を管理する抽象化レイヤー
abstract class NotificationRepository {
  // ========================================
  // プッシュ通知権限管理
  // ========================================

  /// 通知権限を確認
  /// アプリ起動時や通知設定前に確認
  /// @return 通知権限が有効かどうか
  Future<Result<bool>> hasNotificationPermission();

  /// 通知権限をリクエスト
  /// ユーザーに通知権限の許可を求める
  /// @return ユーザーが許可したかどうか
  Future<Result<bool>> requestNotificationPermission();

  // ========================================
  // 通知送信・管理
  // ========================================

  /// ローテーション通知を送信
  /// ミーティング時刻の通知タイミングで実行
  /// @param notificationData 通知に含める情報
  Future<Result<void>> sendRotationNotification(
    NotificationData notificationData,
  );

  /// 即座に通知を送信（テスト用）
  /// Add画面での通知テスト用
  /// @param title 通知タイトル
  /// @param body 通知本文
  /// @param data 追加データ（オプション）
  Future<Result<void>> sendImmediateNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  });

  // ========================================
  // 通知スケジューリング
  // ========================================

  /// ローテーション通知をスケジュール
  /// ローテーショングループ作成・更新時に実行
  /// 今後のローテーション日程に基づいて通知を予約
  /// @param rotationGroupId 対象のローテーショングループID
  /// @param notificationDataList 予約する通知データのリスト
  Future<Result<void>> scheduleRotationNotifications({
    required String rotationGroupId,
    required List<NotificationData> notificationDataList,
  });

  /// スケジュールされた通知をキャンセル
  /// ローテーショングループ削除・更新時に実行
  /// @param rotationGroupId 対象のローテーショングループID
  Future<Result<void>> cancelScheduledNotifications(String rotationGroupId);

  /// 全てのスケジュール済み通知を取得
  /// デバッグや管理画面で確認用
  /// @return 現在スケジュールされている通知のリスト
  Future<Result<List<Map<String, dynamic>>>> getAllScheduledNotifications();

  // ========================================
  // 通知履歴・統計
  // ========================================

  /// 通知送信履歴を記録
  /// 送信成功・失敗の履歴を蓄積
  /// @param notificationId 通知識別子
  /// @param status 送信結果（成功・失敗）
  /// @param error エラー情報（失敗時のみ）
  Future<Result<void>> recordNotificationHistory({
    required String notificationId,
    required String status,
    String? error,
  });

  /// 通知統計情報を取得
  /// 送信成功率、エラー分析用
  /// @param rotationGroupId 対象のローテーショングループID（オプション）
  /// @return 通知統計データ
  Future<Result<Map<String, dynamic>>> getNotificationStatistics([
    String? rotationGroupId,
  ]);

  // ========================================
  // 通知設定管理
  // ========================================

  /// 通知設定を更新
  /// ユーザー個別の通知設定（今後の拡張用）
  /// @param settings 通知設定情報
  Future<Result<void>> updateNotificationSettings(
    Map<String, dynamic> settings,
  );

  /// 通知設定を取得
  /// 現在の通知設定を確認
  /// @return 現在の通知設定
  Future<Result<Map<String, dynamic>>> getNotificationSettings();
}
