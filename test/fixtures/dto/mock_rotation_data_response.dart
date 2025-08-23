import 'package:popcal/features/rotation/providers/rotation_handlers.dart';

import 'mock_rotation_response.dart';
import 'mock_user_response.dart';

class MockRotationDataResponse {
  static final RotationDataResponse rotationDataResponse = RotationDataResponse(
    MockUserResponse.userResponse,
    MockRotationResponse.rotationResponse1,
  );
}
