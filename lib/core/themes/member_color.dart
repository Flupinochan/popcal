import 'package:flutter/material.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

// カレンダーで表示するメンバーの色
const List<Color> memberColors = [
  Color(0xFF5DADE2),
  Color(0xFF48C9B0),
  Color(0xFF58D68D),
  Color(0xFFF7DC6F),
  Color(0xFFAB7DEC),
  Color(0xFFEC7063),
  Color(0xFF7FB3D3),
  Color(0xFF76D7C4),
  Color(0xFFF8C471),
  Color(0xFFBFC9CA),
];

// Member配列のindexで色を決定
Color getMemberColor(String memberName, RotationGroup rotationGroup) {
  final index = rotationGroup.rotationMembers.indexOf(memberName);
  return index >= 0 ? memberColors[index % memberColors.length] : Colors.white;
}
