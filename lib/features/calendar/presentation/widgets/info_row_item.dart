import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

/// ローテーション情報のメンバー、曜日、時刻欄
class InfoRowItem extends StatelessWidget {
  const InfoRowItem({
    required this.infoText,
    required this.iconData,
    super.key,
    this.iconSize = 18,
    this.textStyle,
  });

  final String infoText;
  final IconData iconData;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    final effectiveTextStyle = textStyle ?? textTheme.titleSmall;

    return Row(
      spacing: 8,
      children: [
        Icon(iconData, color: glassTheme.surfaceColor, size: iconSize),
        Expanded(
          child: Text(
            infoText,
            style: effectiveTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
