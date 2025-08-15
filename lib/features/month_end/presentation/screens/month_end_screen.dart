import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_time.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';

class MonthEndScreen extends HookConsumerWidget {
  const MonthEndScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final isSwitched = useState(false);
    final timeUtils = ref.watch(timeUtilsProvider);
    final now = timeUtils.now();

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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('月末営業日通知', style: textTheme.bodyLarge),
                        Text('毎月の最終平日を通知します', style: textTheme.bodySmall),
                      ],
                    ),
                    Opacity(
                      opacity: isSwitched.value ? 1 : 0.5,
                      child: GlassFormTime(
                        now: now,
                        isEnabled: isSwitched.value,
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
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return glassTheme.borderColorStrong;
                              }
                              return glassTheme.borderColor;
                            },
                          ),
                      value: isSwitched.value,
                      onChanged: (value) => isSwitched.value = value,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
