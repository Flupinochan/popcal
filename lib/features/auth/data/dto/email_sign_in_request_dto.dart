class EmailSignInRequestDto {
  final String email;
  final String password;

  const EmailSignInRequestDto({required this.email, required this.password});

  // Json => Model へ変換
  factory EmailSignInRequestDto.fromJson(Map<String, dynamic> json) {
    return EmailSignInRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  // Model => Json へ変換
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
