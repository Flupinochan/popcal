import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
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
    NotificationEntry notificationEntry,
  ) async {
    final dto = NotificationEntryLocalResponse.fromEntity(
      notificationEntry,
    );

    final result = await _localNotificationsDatasource.createNotification(dto);
    return result.when(
      success: (_) => Results.success(null),
      failure: Results.failure,
    );
  }

  /// 4-3. 全通知を削除
  @override
  Future<Result<void>> deleteAllNotifications() async {
    final result = await _localNotificationsDatasource.deleteNotifications();
    return result.when(
      success: (_) => Results.success(null),
      failure: Results.failure,
    );
  }

  /// 4-1. 特定の通知を削除
  @override
  Future<Result<void>> deleteNotification(NotificationId notificationId) async {
    final result = await _localNotificationsDatasource.deleteNotification(
      notificationId.value,
    );
    return result.when(
      success: (_) => Results.success(null),
      failure: Results.failure,
    );
  }

  /// 4-2 特定のrotationIdの通知を削除
  @override
  Future<Result<void>> deleteNotificationsBySourceId(SourceId sourceId) async {
    final result = await _localNotificationsDatasource
        .deleteNotificationsBySourceId(sourceId.value);
    return result.when(
      success: (_) => Results.success(null),
      failure: Results.failure,
    );
  }

  /// 2. 通知予定のスケジュールを一覧取得
  @override
  Future<Result<List<NotificationId>>> getNotifications() async {
    final result = await _localNotificationsDatasource.getNotifications();
    return result.when(
      success:
          (notificationIds) => Results.success(
            notificationIds.map(NotificationId.createFromLocal).toList(),
          ),
      failure: Results.failure,
    );
  }

  @override
  Future<Result<List<NotificationEntry>>> getNotificationsBySourceId(
    SourceId sourceId,
  ) async {
    final result = await _localNotificationsDatasource
        .getNotificationsBySourceId(sourceId.value);
    if (result.isFailure) {
      return Results.failure(NotificationFailure(result.displayText));
    }
    final dtos = result.valueOrNull!;

    final entities = <NotificationEntry>[];
    for (final dto in dtos) {
      final entityResult = dto.toEntity();
      if (entityResult.isFailure) {
        return Results.failure<List<NotificationEntry>>(
          ValidationFailure(entityResult.displayText),
        );
      }
      entities.add(entityResult.valueOrNull!);
    }

    return Results.success(entities);
  }

  /// 0-1. 初期化 ※とりあえず必要
  @override
  Future<Result<void>> initializeNotification() async {
    final result = await _localNotificationsDatasource.initializeNotification();
    return result.when(
      success: (_) => Results.success(null),
      failure: Results.failure,
    );
  }

  /// 0-2. 通知タップからアプリを起動した場合の画面遷移
  @override
  Future<Result<SourceId?>> isLaunchedFromNotification() async {
    final result =
        await _localNotificationsDatasource.isLaunchedFromNotification();
    if (result.isFailure) {
      return Results.failure(result.failureOrNull!);
    }
    if (result.valueOrNull == null) {
      return Results.success(null);
    }
    return Results.success(SourceId.create(result.valueOrNull!));
  }
}
