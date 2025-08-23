import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';

import '../entities/mock_rotation.dart';

class MockRotationResponse {
  static final RotationResponse rotationResponse1 = RotationResponse.fromEntity(
    MockRotation.rotation1,
  );

  static final RotationResponse rotationResponse2 = RotationResponse.fromEntity(
    MockRotation.rotation2,
  );
}
