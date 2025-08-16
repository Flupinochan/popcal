import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/presentation/widgets/calendar_container.dart';
import 'package:popcal/features/calendar/presentation/widgets/rotation_info_card.dart';
import 'package:popcal/features/calendar/presentation/widgets/selected_day_info.dart';
import 'package:popcal/features/calendar/providers/calendar_loader.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/screens/custom_error_screen.dart';
import 'package:popcal/shared/screens/custom_loading_screen.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';

class CalendarScreen extends HookConsumerWidget {
  const CalendarScreen({required this.rotationId, super.key});
  final RotationId rotationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final timeUtils = ref.watch(timeUtilsProvider);
    final now = timeUtils.now();
    final calendarDataAsync = ref.watch(
      calendarScheduleResponseProvider(rotationId),
    );
    final focusedDay = useState(now);
    final selectedDay = useState(now);

    // 画面表示用データを取得して表示
    return calendarDataAsync.when(
      data:
          (result) => result.when(
            success:
                (dto) => Scaffold(
                  backgroundColor: glassTheme.backgroundColor,
                  extendBodyBehindAppBar: true,
                  appBar: GlassAppBar(
                    title: dto.rotationResponse.rotationName.value,
                    leadingIcon: Icons.arrow_back_ios_new,
                    onLeadingPressed: () => const HomeRoute().go(context),
                  ),
                  body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: glassTheme.primaryGradient,
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                spacing: 16,
                                children: [
                                  CalendarContainer(
                                    calendarScheduleResponse: dto,
                                    focusedDay: focusedDay,
                                    selectedDay: selectedDay,
                                    now: now,
                                  ),
                                  SelectedDayInfo(
                                    calendarScheduleResponse: dto,
                                    selectedDay: selectedDay.value,
                                  ),
                                  RotationInfoCard(
                                    rotationResponse: dto.rotationResponse,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            failure: (error) => CustomErrorScreen(message: error.message),
          ),
      loading: () => const CustomLoadingScreen(),
      error: (error, stack) => const CustomErrorScreen(),
    );
  }
}
