import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/presentation/dto/deadline_request.dart';
import 'package:popcal/features/deadline/providers/deadline_notifier.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_time.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class DeadlineScreen extends HookConsumerWidget {
  DeadlineScreen({super.key});

  final List<DateTime> monthList = [
    DateTime(2025),
    DateTime(2025, 2),
    DateTime(2025, 3),
    DateTime(2025, 4),
    DateTime(2025, 5),
    DateTime(2025, 6),
    DateTime(2025, 7),
    DateTime(2025, 8),
    DateTime(2025, 9),
    DateTime(2025, 10),
    DateTime(2025, 11),
    DateTime(2025, 12),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final deadlineState = ref.watch(deadlineNotifierProvider);

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
                  height: 100,
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
                          if (result.isFailure) {
                            return _buildScreen(context, ref, false, true);
                          }
                          final deadlineRequest = result.valueOrNull!;
                          final isEnabled = deadlineRequest.isEnabled;
                          return _buildScreen(
                            context,
                            ref,
                            isEnabled,
                            false,
                          );
                        },
                        loading: () => _buildScreen(context, ref, false, true),
                        error:
                            (error, stackTrace) =>
                                _buildScreen(context, ref, false, true),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: monthList.length,
                    itemBuilder: (context, index) {
                      return GlassWrapper(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          monthList[index].toString(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen(
    BuildContext context,
    WidgetRef ref,
    bool isEnabled,
    bool isLoading,
  ) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final timeUtils = ref.watch(timeUtilsProvider);
    final now = timeUtils.now();

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          Opacity(
            opacity: (isEnabled && !isLoading) ? 1 : 0.5,
            child: GlassFormTime(
              now: now,
              isEnabled: isEnabled,
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
            value: isEnabled,
            onChanged:
                isLoading
                    ? null
                    : (value) => _onSwitchChanged(
                      ref,
                      value,
                    ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSwitchChanged(WidgetRef ref, bool? value) async {
    if (value != null) {
      final dto = DeadlineRequest(isEnabled: value);
      final deadlineNotifier = ref.watch(deadlineNotifierProvider.notifier);
      await deadlineNotifier.execute(dto);
    }
  }
}
