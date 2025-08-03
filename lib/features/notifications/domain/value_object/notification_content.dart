import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_content.freezed.dart';

@freezed
sealed class NotificationContent with _$NotificationContent {
  const NotificationContent._();

  const factory NotificationContent({
    required String rotationName,
    required String memberName,
    required DateTime rotationStartDate,
  }) = _NotificationContent;

  String generateTitle() => rotationName;
  String generateMessage() => '今日は$memberNameの番です';

  String get title => generateTitle();
  String get message => generateMessage();
}
