import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class SnackBarUtils {
  // 表示のみSnackBar ※ScaffoldのあるWidgetでのみ実行可能
  static void showGlassSnackBar({
    required BuildContext context,
    required String flexibleMessage,
    String? fixedMessage,
    Duration duration = const Duration(seconds: 2),
  }) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GlassWrapper(
          padding: EdgeInsets.all(10),
          child: _buildTwoPartMessage(
            flexibleMessage: flexibleMessage,
            fixedMessage: fixedMessage,
            style: textTheme.bodyLarge!,
          ),
        ),
        backgroundColor: glassTheme.backgroundColor,
        elevation: 0,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }

  // アクション付きSnackBar
  static void showGlassSnackBarWithAction({
    required BuildContext context,
    required String flexibleMessage,
    String? fixedMessage,
    required VoidCallback onAction,
    required String actionLabel,
    Duration duration = const Duration(seconds: 5),
  }) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GlassWrapper(
          padding: EdgeInsets.all(10),
          child: Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTwoPartMessage(
                flexibleMessage: flexibleMessage,
                fixedMessage: fixedMessage,
                style: textTheme.bodyLarge!,
              ),
              GlassButton(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                gradient: glassTheme.backgroundGradientStrong,
                text: actionLabel,
                textStyle: textTheme.labelLarge,
                onPressed: () {
                  onAction();
                  scaffoldMessenger.hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
        backgroundColor: glassTheme.backgroundColor,
        elevation: 0,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }

  // メッセージ部分は、可変長部分と固定長部分で指定可能
  // 可変長 + 固定長 のメッセージの場合は、可変長部分のみをellipsisで省略表記
  static Widget _buildTwoPartMessage({
    required String flexibleMessage, // 左側の可変長メッセージ
    String? fixedMessage, // 右側の固定幅メッセージ
    required TextStyle style,
  }) {
    return Flexible(
      child:
          fixedMessage == null
              ? Text(
                flexibleMessage,
                style: style,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      flexibleMessage,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(fixedMessage, style: style, maxLines: 1),
                ],
              ),
    );
  }
}
