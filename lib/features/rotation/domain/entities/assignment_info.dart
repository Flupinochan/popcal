/// 通知用の割り当て情報
class AssignmentInfo {
  /// 役割名
  final String roleName;

  /// 担当者名
  final String memberName;

  const AssignmentInfo({required this.roleName, required this.memberName});

  /// Map表現への変換
  Map<String, dynamic> toMap() {
    return {'roleName': roleName, 'memberName': memberName};
  }

  /// Map表現からの復元
  factory AssignmentInfo.fromMap(Map<String, dynamic> map) {
    return AssignmentInfo(
      roleName: map['roleName'],
      memberName: map['memberName'],
    );
  }
}
