import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_firebase_response.dart';

class RotationRepositoryFirebase {
  final FirebaseFirestore _firebaseFirestore;

  RotationRepositoryFirebase(this._firebaseFirestore);

  // 1. 自動ローテーショングループ一覧取得
  Stream<Result<List<RotationFirebaseResponse>>> watchRotations(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('rotations')
        .withConverter(
          fromFirestore: RotationFirebaseResponse.fromFirestore,
          toFirestore: (RotationFirebaseResponse dto, _) => dto.toFirestore(),
        )
        .snapshots()
        .asyncMap((docSnap) async {
          try {
            final rotations = docSnap.docs.map((doc) => doc.data()).toList();
            return Results.success(rotations);
          } catch (error) {
            return Results.failure(
              RotationFailure('ローテーショングループの監視中にエラーが発生しました: $error'),
            );
          }
        });
  }

  // 2. 手動ローテーショングループ一覧取得
  Future<Result<List<RotationFirebaseResponse>>> getRotations(
    String userId,
  ) async {
    try {
      final ref = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rotations')
          // withConverterで型安全に処理可能
          .withConverter(
            fromFirestore: RotationFirebaseResponse.fromFirestore,
            toFirestore: (RotationFirebaseResponse dto, _) => dto.toFirestore(),
          );
      final docSnap = await ref.get();
      // doc.data()に型変換したデータが格納
      final rotations = docSnap.docs.map((doc) => doc.data()).toList();
      return Results.success(rotations);
    } catch (error) {
      return Results.failure(RotationFailure('ローテーショングループの取得に失敗しました: $error'));
    }
  }

  // 3. 特定のローテーショングループを取得
  Future<Result<RotationFirebaseResponse?>> getRotation(
    String userId,
    String rotationId,
  ) async {
    try {
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rotations')
          .doc(rotationId)
          .withConverter(
            fromFirestore: RotationFirebaseResponse.fromFirestore,
            toFirestore: (RotationFirebaseResponse dto, _) => dto.toFirestore(),
          );

      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return Results.success(null);
      }

      final rotations = docSnap.data();
      return Results.success(rotations);
    } catch (error) {
      return Results.failure(RotationFailure('ローテーショングループの取得に失敗しました: $error'));
    }
  }

  // 4. ローテーショングループ作成
  Future<Result<RotationFirebaseResponse>> createRotation(
    RotationFirebaseResponse dto,
  ) async {
    try {
      // 作成するdocumentへのrefを作成 ※collectionとdocは交互にしなければならない
      final docRef =
          _firebaseFirestore
              .collection('users')
              .doc(dto.userId.value)
              .collection('rotations')
              .doc();

      // Firestoreに保存
      await docRef.set(dto.toFirestore());

      final result = RotationFirebaseResponse(
        rotationId: RotationId(docRef.id), // 生成されたdocument id
        userId: dto.userId,
        rotationName: dto.rotationName,
        rotationMemberNames: dto.rotationMemberNames,
        rotationDays: dto.rotationDays,
        notificationTime: dto.notificationTime,
        currentRotationIndex: dto.currentRotationIndex,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
      );

      return Results.success(result);
    } catch (error) {
      return Results.failure(RotationFailure('ローテーショングループの作成に失敗しました: $error'));
    }
  }

  // 5. ローテーショングループ更新
  Future<Result<RotationFirebaseResponse>> updateRotation(
    RotationFirebaseResponse dto,
  ) async {
    try {
      if (dto.rotationId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未設定です'));
      }

      final docRef = _firebaseFirestore
          .collection('users')
          .doc(dto.userId.value)
          .collection('rotations')
          .doc(dto.rotationId!.value);

      // updatedAtを現在時刻に更新
      final updatedDto = dto.copyWith(updatedAt: Timestamp.now());

      await docRef.update(updatedDto.toFirestore());

      return Results.success(updatedDto);
    } catch (error) {
      return Results.failure(RotationFailure('ローテーショングループの更新に失敗しました: $error'));
    }
  }

  // 6. ローテーショングループ削除
  Future<Result<void>> deleteRotation(String userId, String rotationId) async {
    try {
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rotations')
          .doc(rotationId);

      await docRef.delete();

      return Results.success(null);
    } catch (error) {
      return Results.failure(RotationFailure('ローテーショングループの削除に失敗しました: $error'));
    }
  }
}
