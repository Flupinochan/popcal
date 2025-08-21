import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_id.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/notifications/infrastructure/dto/notification_entry_local_response.dart';
import 'package:popcal/features/notifications/infrastructure/gateways/notification_gateway_local.dart';

class NotificationGatewayImpl implements NotificationGateway {
  NotificationGatewayImpl(this._localNotificationsDatasource);
  final NotificationGatewayLocal _localNotificationsDatasource;

  /// 1 通知スケジュールを作成
  @override
  Future<Result<void>> createNotification(
    NotificationSetting notificationEntry,
  ) async {
    final dto = NotificationEntryLocalResponse.fromEntity(
      notificationEntry,
    );

    final result = await _localNotificationsDatasource.createNotification(dto);
    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }

  /// 4-3. 全通知を削除
  @override
  Future<Result<void>> deleteAllNotifications() async {
    final result = await _localNotificationsDatasource.deleteNotifications();

    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }

  /// 4-1. 特定の通知を削除
  @override
  Future<Result<void>> deleteNotification(NotificationId notificationId) async {
    final result = await _localNotificationsDatasource.deleteNotification(
      notificationId.value,
    );

    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }

  /// 4-2 特定のrotationIdの通知を削除
  @override
  Future<Result<void>> deleteNotificationsBySourceId(GroupId sourceId) async {
    final result = await _localNotificationsDatasource
        .deleteNotificationsBySourceId(sourceId.value);

    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }

  /// 2. 通知予定のスケジュールを一覧取得
  @override
  Future<Result<List<NotificationId>>> getNotifications() async {
    final result = await _localNotificationsDatasource.getNotifications();

    if (result.isError) {
      return Result.error(result.error);
    }

    final notificationIds =
        result.value.map(NotificationId.createFromLocal).toList();

    return Result.ok(notificationIds);
  }

  @override
  Future<Result<List<NotificationSetting>>> getNotificationsBySourceId(
    GroupId sourceId,
  ) async {
    final result = await _localNotificationsDatasource
        .getNotificationsBySourceId(sourceId.value);
    if (result.isError) {
      return Result.error(result.error);
    }

    final dtos = result.value;

    final entities = <NotificationSetting>[];
    for (final dto in dtos) {
      final entityResult = dto.toEntity();
      if (entityResult.isError) {
        return Result.error(entityResult.error);
      }

      entities.add(entityResult.value);
    }

    return Result.ok(entities);
  }

  /// 0-1. 初期化 ※とりあえず必要
  @override
  Future<Result<void>> initializeNotification() async {
    final result = await _localNotificationsDatasource.initializeNotification();
    if (result.isError) {
      return Result.error(result.error);
    }

    return const Result.ok(null);
  }

  /// 0-2. 通知タップからアプリを起動した場合の画面遷移
  @override
  Future<Result<GroupId?>> isLaunchedFromNotification() async {
    final result =
        await _localNotificationsDatasource.isLaunchedFromNotification();
    if (result.isError) {
      return Result.error(result.error);
    }

    if (result.value == null) {
      return const Result.ok(null);
    }

    return Result.ok(GroupId.create(result.value!));
  }
}
