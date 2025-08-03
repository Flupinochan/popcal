import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/data/dto/rotation_group_firebase_dto.dart';

class FirebaseRotationDatasource {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseRotationDatasource(this._firebaseFirestore);

  // 1. 自動ローテーショングループ一覧取得
  Stream<Result<List<RotationGroupFirebaseDto>>> watchRotationGroups(
    String userId,
  ) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('rotationGroups')
        .withConverter(
          fromFirestore: RotationGroupFirebaseDto.fromFirestore,
          toFirestore: (RotationGroupFirebaseDto dto, _) => dto.toFirestore(),
        )
        .snapshots()
        .map((docSnap) {
          try {
            final rotationGroups =
                docSnap.docs.map((doc) => doc.data()).toList();
            return Results.success(rotationGroups);
          } catch (error) {
            return Results.failure(
              NetworkFailure('ローテーショングループの監視中にエラーが発生しました: $error'),
            );
          }
        });
  }

  // 2. 手動ローテーショングループ一覧取得
  Future<Result<List<RotationGroupFirebaseDto>>> getRotationGroups(
    String userId,
  ) async {
    try {
      final ref = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rotationGroups')
          // withConverterで型安全に処理可能
          .withConverter(
            fromFirestore: RotationGroupFirebaseDto.fromFirestore,
            toFirestore: (RotationGroupFirebaseDto dto, _) => dto.toFirestore(),
          );
      final docSnap = await ref.get();
      // doc.data()に型変換したデータが格納
      final rotationGroups = docSnap.docs.map((doc) => doc.data()).toList();
      return Results.success(rotationGroups);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの取得に失敗しました: $error'));
    }
  }

  // 3. 特定のローテーショングループを取得
  Future<Result<RotationGroupFirebaseDto?>> getRotationGroup(
    String userId,
    String rotationGroupId,
  ) async {
    try {
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rotationGroups')
          .doc(rotationGroupId)
          .withConverter(
            fromFirestore: RotationGroupFirebaseDto.fromFirestore,
            toFirestore: (RotationGroupFirebaseDto dto, _) => dto.toFirestore(),
          );

      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return Results.success(null);
      }

      final rotationGroup = docSnap.data();
      return Results.success(rotationGroup);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの取得に失敗しました: $error'));
    }
  }

  // 4. ローテーショングループ作成
  Future<Result<RotationGroupFirebaseDto>> createRotationGroup(
    RotationGroupFirebaseDto dto,
  ) async {
    try {
      // 作成するdocumentへのrefを作成 ※collectionとdocは交互にしなければならない
      final docRef =
          _firebaseFirestore
              .collection('users')
              .doc(dto.userId)
              .collection('rotationGroups')
              .doc();

      // Firestoreに保存
      await docRef.set(dto.toFirestore());

      final result = RotationGroupFirebaseDto(
        rotationGroupId: docRef.id, // 生成されたdocument id
        userId: dto.userId,
        rotationName: dto.rotationName,
        rotationMembers: dto.rotationMembers,
        rotationDays: dto.rotationDays,
        notificationTime: dto.notificationTime,
        currentRotationIndex: dto.currentRotationIndex,
        rotationStartDate: dto.rotationStartDate,
        updatedAt: dto.updatedAt,
      );

      return Results.success(result);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの作成に失敗しました: $error'));
    }
  }

  // 5. ローテーショングループ更新
  Future<Result<RotationGroupFirebaseDto>> updateRotationGroup(
    RotationGroupFirebaseDto dto,
  ) async {
    try {
      if (dto.rotationGroupId == null) {
        return Results.failure(ValidationFailure('ローテーションIDが未設定です'));
      }

      final docRef = _firebaseFirestore
          .collection('users')
          .doc(dto.userId)
          .collection('rotationGroups')
          .doc(dto.rotationGroupId);

      // updatedAtを現在時刻に更新
      final updatedDto = dto.copyWith(updatedAt: Timestamp.now());

      await docRef.update(updatedDto.toFirestore());

      return Results.success(updatedDto);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの更新に失敗しました: $error'));
    }
  }

  // 6. ローテーショングループ削除
  Future<Result<void>> deleteRotationGroup(
    String userId,
    String rotationGroupId,
  ) async {
    try {
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rotationGroups')
          .doc(rotationGroupId);

      await docRef.delete();

      return Results.success(null);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの削除に失敗しました: $error'));
    }
  }
}
