import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';

class MockNotificationGateway extends Mock implements NotificationGateway {
  @override
  Future<Result<void>> initializeNotification() async {
    return const Result.ok(null);
  }
}
