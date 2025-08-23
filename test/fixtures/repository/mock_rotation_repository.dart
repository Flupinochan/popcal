import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

import '../entities/mock_rotation.dart';

class MockRotationRepository extends Mock implements RotationRepository {
  @override
  Future<Result<Rotation>> createRotation(Rotation rotation) async {
    return Result.ok(MockRotation.rotation1);
  }

  @override
  Future<Result<void>> deleteRotation(
    UserId userId,
    RotationId rotationId,
  ) async {
    return const Result.ok(null);
  }
}
