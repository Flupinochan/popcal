import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';

class CalendarScreen extends HookConsumerWidget {
  final String rotationGroupId;

  const CalendarScreen({super.key, required this.rotationGroupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserState = ref.watch(currentUserProvider);
    final focusedDay = useState(DateTime.now().toLocal());
    final selectedDay = useState<DateTime?>(DateTime.now().toLocal());
    final notificationDetails = useState<List<NotificationDetail>>([]);

    final currentUser = currentUserState.when(
      data:
          (result) =>
              result.when(success: (user) => user, failure: (_) => null),
      loading: () => null,
      error: (_, __) => null,
    );

    // 通知詳細情報を取得
    useEffect(() {
      () async {
        final notificationRepository = ref.read(notificationRepositoryProvider);
        final result = await notificationRepository.getNotificationDetails();
        result.when(
          success: (details) {
            // 対象のローテーショングループの通知のみフィルタリング
            final filteredDetails =
                details.where((detail) {
                  return detail.title.isNotEmpty &&
                      detail.memberName.isNotEmpty;
                }).toList();
            notificationDetails.value = filteredDetails;
          },
          failure: (error) {
            print('通知詳細の取得に失敗: $error');
          },
        );
      }();
      return null;
    }, []);

    if (currentUser == null) {
      return _buildLoadingScreen();
    }

    final rotationDetailAsync = ref.watch(
      rotationDetailProvider(currentUser.uid, rotationGroupId),
    );

    return rotationDetailAsync.when(
      data: (rotationGroup) {
        if (rotationGroup == null) {
          return _buildErrorScreen(context, 'ローテーション情報が見つかりません');
        }

        // ローテーション作成日から1年分を計算
        useEffect(() {
          final notificationRepository = ref.read(
            notificationRepositoryProvider,
          );

          // ローテーション作成日から1年分の期間を設定
          final startDate = rotationGroup.rotationStartDate;
          final endDate = startDate.add(const Duration(days: 365));

          final result = notificationRepository.calculateCalendarDetails(
            rotationGroup: rotationGroup,
            startDate: startDate,
            endDate: endDate,
          );

          result.when(
            success: (details) {
              notificationDetails.value = details;
            },
            failure: (error) {
              print('カレンダー詳細の計算に失敗: $error');
            },
          );
          return null;
        }, [rotationGroup.rotationGroupId]);

        return _buildCalendarScreen(
          context,
          rotationGroup,
          focusedDay,
          selectedDay,
          notificationDetails.value,
        );
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stack) => _buildErrorScreen(context, 'エラーが発生しました: $error'),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(BuildContext context, String message) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarScreen(
    BuildContext context,
    RotationGroup rotationGroup,
    ValueNotifier<DateTime> focusedDay,
    ValueNotifier<DateTime?> selectedDay,
    List<NotificationDetail> notificationDetails,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          rotationGroup.rotationName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildCalendarContainer(
                        rotationGroup,
                        focusedDay,
                        selectedDay,
                        notificationDetails,
                      ),
                      const SizedBox(height: 16),
                      _buildSelectedDayInfo(
                        rotationGroup,
                        selectedDay.value,
                        notificationDetails,
                      ),
                      const SizedBox(height: 16),
                      _buildRotationInfo(rotationGroup),
                      const SizedBox(height: 20), // 下部余白を追加
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarContainer(
    RotationGroup rotationGroup,
    ValueNotifier<DateTime> focusedDay,
    ValueNotifier<DateTime?> selectedDay,
    List<NotificationDetail> notificationDetails,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 435,
      borderRadius: 16,
      blur: 20,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFffffff).withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.3)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: TableCalendar<String>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay.value,
            selectedDayPredicate: (day) => isSameDay(selectedDay.value, day),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            sixWeekMonthsEnforced: true, // 6週間表示を強制
            daysOfWeekHeight: 20,
            onDaySelected: (selected, focused) {
              selectedDay.value = selected;
              focusedDay.value = focused;
            },
            onPageChanged: (focused) {
              focusedDay.value = focused;
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              headerPadding: const EdgeInsets.symmetric(vertical: 8),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              weekendStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
            calendarStyle: CalendarStyle(
              cellMargin: const EdgeInsets.all(2),
              defaultTextStyle: const TextStyle(color: Colors.white),
              weekendTextStyle: const TextStyle(color: Colors.white),
              outsideDaysVisible: false,
              selectedDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              rowDecoration: const BoxDecoration(), // 行の装飾をリセット
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return _buildCalendarCell(
                  notificationDetails,
                  day,
                  false,
                  false,
                );
              },
              todayBuilder: (context, day, focusedDay) {
                return _buildCalendarCell(
                  notificationDetails,
                  day,
                  true,
                  false,
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return _buildCalendarCell(
                  notificationDetails,
                  day,
                  false,
                  true,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCell(
    List<NotificationDetail> notificationDetails,
    DateTime day,
    bool isToday,
    bool isSelected,
  ) {
    // 通知詳細から該当日の担当者を取得
    final notification = notificationDetails.firstWhere(
      (detail) => isSameDay(detail.date, day),
      orElse:
          () => NotificationDetail(
            notificationId: 0,
            date: day,
            memberName: '',
            title: '',
            body: '',
          ),
    );

    final memberName = notification.memberName;
    final isRotationDay = memberName.isNotEmpty;

    return Container(
      margin: const EdgeInsets.all(1),
      width: 45, // セル幅を少し拡大
      height: 45, // セル高を少し拡大
      decoration: BoxDecoration(
        color:
            isSelected
                ? Colors.white.withOpacity(0.3)
                : isToday
                ? Colors.white.withOpacity(0.2)
                : isRotationDay
                ? Colors.white.withOpacity(0.1)
                : null,
        shape: BoxShape.circle,
        border:
            isRotationDay
                ? Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11, // 日付のフォントサイズも少し小さく
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isRotationDay)
            Container(
              width: 40,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                memberName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 9, // メンバー名のフォントサイズを大きく
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectedDayInfo(
    RotationGroup rotationGroup,
    DateTime? selectedDay,
    List<NotificationDetail> notificationDetails,
  ) {
    if (selectedDay == null) {
      return const SizedBox.shrink();
    }

    // 通知詳細から該当日の情報を取得
    final notification = notificationDetails.firstWhere(
      (detail) => isSameDay(detail.date, selectedDay),
      orElse:
          () => NotificationDetail(
            notificationId: 0,
            date: selectedDay,
            memberName: '',
            title: '',
            body: '',
          ),
    );

    final memberName = notification.memberName;
    final isRotationDay = memberName.isNotEmpty;

    return GlassmorphicContainer(
      width: double.infinity,
      height: 100,
      borderRadius: 12,
      blur: 20,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFffffff).withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.3)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 日付アイコン
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${selectedDay.month}/${selectedDay.day}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 詳細情報
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        _getWeekdayName(selectedDay),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isRotationDay
                                  ? Colors.green.withOpacity(0.3)
                                  : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isRotationDay ? '担当日' : '対象外',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (isRotationDay)
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white.withOpacity(0.8),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          memberName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Icon(
                          Icons.person_off,
                          color: Colors.white.withOpacity(0.6),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ローテーション対象外',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRotationInfo(RotationGroup rotationGroup) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 170,
      borderRadius: 12,
      blur: 20,
      alignment: Alignment.topLeft,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFffffff).withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.3)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'ローテーション情報',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // メンバー情報
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.group,
                  color: Colors.white.withOpacity(0.8),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'メンバー: ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    rotationGroup.rotationMembers.join(', '),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 対象曜日
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white.withOpacity(0.8),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  '対象曜日: ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  rotationGroup.rotationDays
                      .map((w) => w.displayName)
                      .join(', '),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 通知時刻
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white.withOpacity(0.8),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  '通知時刻: ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${rotationGroup.notificationTime.hour.toString().padLeft(2, '0')}:${rotationGroup.notificationTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getWeekdayName(DateTime date) {
    final weekday = Weekday.fromDateTime(date);
    return weekday.displayName;
  }
}
