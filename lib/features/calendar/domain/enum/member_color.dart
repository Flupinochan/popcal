import 'package:flutter/material.dart';

enum MemberColor {
  // default色
  notApplicable(Colors.white),
  member1(Color(0xFF5DADE2)),
  member2(Color(0xFF48C9B0)),
  member3(Color(0xFFEC7063)),
  member4(Color(0xFFF7DC6F)),
  member5(Color(0xFFAB7DEC)),
  member6(Color(0xFF58D68D)),
  member7(Color(0xFF7FB3D3)),
  member8(Color(0xFF76D7C4)),
  member9(Color(0xFFF8C471)),
  member10(Color(0xFFBFC9CA));

  const MemberColor(this.color);

  static List<Color> get allColors => values.map((e) => e.color).toList();

  // notApplicable以外の色
  static List<MemberColor> get memberColors =>
      values.where((color) => color != notApplicable).toList();

  final Color color;

  static Color colorFromIndex(int? index) {
    return fromIndex(index).color;
  }

  // notApplicable以外の色から取得
  static MemberColor fromIndex(int? index) {
    if (index == null || index < 0 || index >= memberColors.length) {
      return notApplicable;
    }
    return memberColors[index];
  }
}
