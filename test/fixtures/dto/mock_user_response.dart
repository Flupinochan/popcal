import 'package:popcal/features/auth/presentation/dto/user_response.dart';

import '../entities/mock_app_user.dart';

class MockUserResponse {
  static final userResponse = UserResponse.fromEntity(MockAppUser.appUser);
}
