import 'package:flutter/material.dart';

extension type const MemberColor(Color value) {
  /// ローテーション対象外の場合のデフォルト色
  static const MemberColor notApplicable = MemberColor(Colors.white);

  /// カレンダーで表示するメンバーの色
  static const MemberColor member1 = MemberColor(Color(0xFF5DADE2));
  static const MemberColor member2 = MemberColor(Color(0xFF48C9B0));
  static const MemberColor member3 = MemberColor(Color(0xFFEC7063));
  static const MemberColor member4 = MemberColor(Color(0xFFF7DC6F));
  static const MemberColor member5 = MemberColor(Color(0xFFAB7DEC));
  static const MemberColor member6 = MemberColor(Color(0xFF58D68D));
  static const MemberColor member7 = MemberColor(Color(0xFF7FB3D3));
  static const MemberColor member8 = MemberColor(Color(0xFF76D7C4));
  static const MemberColor member9 = MemberColor(Color(0xFFF8C471));
  static const MemberColor member10 = MemberColor(Color(0xFFBFC9CA));

  static const List<MemberColor> allColors = [
    member1,
    member2,
    member3,
    member4,
    member5,
    member6,
    member7,
    member8,
    member9,
    member10,
  ];

  /// インデックスから色を取得
  static MemberColor fromIndex(int? index) {
    if (index == null || index < 0 || index >= allColors.length) {
      return notApplicable;
    }
    return allColors[index];
  }
}
