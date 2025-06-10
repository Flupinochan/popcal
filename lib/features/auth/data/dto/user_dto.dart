import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:popcal/features/auth/domain/entities/user.dart';

class UserDto {
  final String uid;
  final String? email;

  const UserDto({required this.uid, this.email});

  // Firebaseの認証情報 => user dto/entity に変換
  factory UserDto.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserDto(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  // Json => Dto へ変換
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(uid: json['uid'], email: json['email']);
  }

  // Dto => Json へ変換
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }

  // Dto => Entity へ変換
  AppUser toEntity() {
    return AppUser(uid: uid, email: email ?? '');
  }
}
