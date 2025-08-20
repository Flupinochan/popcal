import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/deadline/presentation/dto/deadline_request.dart';
import 'package:popcal/features/deadline/providers/deadline_handlers.dart';
import 'package:popcal/features/deadline/providers/deadline_notifier.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_time.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/screens/custom_error_simple_screen.dart';
import 'package:popcal/shared/screens/custom_loading_simple_screen.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class DeadlineScreen extends HookConsumerWidget {
  const DeadlineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final deadlineState = ref.watch(deadlineNotifierProvider);
    // formKeyが同一の場合は再レンダリングされても初期値が更新されない
    // deadlineStateを条件にformKeyを再生成することで
    // 初期値がloading状態のnowからdata状態のnotificationTimeに更新される
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new, [
      deadlineState,
    ]);
    final timeUtils = ref.watch(timeUtilsProvider);
    final now = TimeOfDay.fromDateTime(timeUtils.now());
    final lastNotificationTime = useState(now);
    final lastIsEnabled = useState(false);

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const GlassAppBar(title: '月末営業日通知'),
      drawer: const DrawerScreen(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: FormBuilder(
            key: formKey,
            child: Column(
              spacing: 12,
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('月末営業日通知', style: textTheme.bodyLarge),
                          Text('毎月の最終平日を通知します', style: textTheme.bodySmall),
                        ],
                      ),
                      deadlineState.when(
                        data: (result) {
                          if (result.isError) {
                            return _buildScreen(
                              context: context,
                              ref: ref,
                              formKey: formKey,
                              lastIsEnabled: lastIsEnabled,
                              isLoading: true,
                              lastNotificationTime: lastNotificationTime,
                            );
                          }
                          final deadlineRequest = result.value;
                          lastIsEnabled.value = deadlineRequest.isEnabled;
                          lastNotificationTime.value =
                              deadlineRequest.notificationTime;
                          return _buildScreen(
                            context: context,
                            ref: ref,
                            formKey: formKey,
                            lastIsEnabled: lastIsEnabled,
                            isLoading: false,
                            lastNotificationTime: lastNotificationTime,
                          );
                        },
                        loading:
                            () => _buildScreen(
                              context: context,
                              ref: ref,
                              formKey: formKey,
                              lastIsEnabled: lastIsEnabled,
                              isLoading: true,
                              lastNotificationTime: lastNotificationTime,
                            ),
                        error:
                            (error, stackTrace) => _buildScreen(
                              context: context,
                              ref: ref,
                              formKey: formKey,
                              lastIsEnabled: lastIsEnabled,
                              isLoading: true,
                              lastNotificationTime: lastNotificationTime,
                            ),
                      ),
                    ],
                  ),
                ),
                ref
                    .watch(getDeadlineNotificationsProvider)
                    .when(
                      data: (result) {
                        if (result.isError) {
                          return const SizedBox.shrink();
                        }
                        final deadlineResponse = result.value;
                        if (deadlineResponse.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Expanded(
                          child: Column(
                            children: [
                              Text('通知予定日', style: textTheme.bodyLarge),
                              const SizedBox(height: 12),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: deadlineResponse.length,
                                  itemBuilder: (context, index) {
                                    return GlassWrapper(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        deadlineResponse[index].displayTime,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      error:
                          (error, stackTrace) => CustomErrorSimpleScreen(
                            message: error.toString(),
                          ),
                      loading: CustomLoadingSimpleScreen.new,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormBuilderState> formKey,
    required ValueNotifier<bool> lastIsEnabled,
    required bool isLoading,
    required ValueNotifier<TimeOfDay> lastNotificationTime,
  }) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          Opacity(
            opacity: (lastIsEnabled.value && !isLoading) ? 1 : 0.5,
            child: GlassFormTime(
              isEnabled: lastIsEnabled.value,
              initialValue: lastNotificationTime.value,
              onTimeChanged: (TimeOfDay selectedTime) {
                lastNotificationTime.value = selectedTime;
                _updateDeadlineSettings(
                  ref,
                  formKey,
                  isEnabled: lastIsEnabled.value,
                  selectedTime: selectedTime,
                );
              },
            ),
          ),
          Switch(
            // ●色
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return Colors.white;
              },
            ),
            // 背景色
            trackColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return glassTheme.backgroundStrong;
                }
                return glassTheme.background;
              },
            ),
            // border色
            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return glassTheme.borderColorStrong;
                }
                return glassTheme.borderColor;
              },
            ),
            value: lastIsEnabled.value,
            onChanged:
                isLoading
                    ? null
                    : (value) =>
                        _updateDeadlineSettings(ref, formKey, isEnabled: value),
          ),
        ],
      ),
    );
  }

  Future<void> _updateDeadlineSettings(
    WidgetRef ref,
    GlobalKey<FormBuilderState> formKey, {
    required bool isEnabled,
    TimeOfDay? selectedTime,
  }) async {
    if (formKey.currentState == null) return;
    if (selectedTime != null) {
      formKey.currentState!.fields['notificationTime']?.didChange(selectedTime);
    }

    if (formKey.currentState!.saveAndValidate()) {
      final formData = formKey.currentState!.value;
      final notificationTime =
          selectedTime ?? (formData['notificationTime'] as TimeOfDay);

      final dto = DeadlineRequest(
        isEnabled: isEnabled,
        notificationTime: notificationTime,
      );

      final deadlineNotifier = ref.watch(deadlineNotifierProvider.notifier);
      await deadlineNotifier.execute(dto);
      final _ = ref.refresh(getDeadlineNotificationsProvider);
    }
  }
}
