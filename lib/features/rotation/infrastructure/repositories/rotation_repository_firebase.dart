import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/core/utils/exceptions/rotation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/infrastructure/dto/create_rotation_firebase_request.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_firebase_mapper.dart';
import 'package:popcal/features/rotation/infrastructure/dto/rotation_firebase_response.dart';
import 'package:popcal/features/rotation/infrastructure/dto/update_rotation_firebase_request.dart';

class RotationRepositoryFirebase {
  RotationRepositoryFirebase(this._firebaseFirestore);
  final FirebaseFirestore _firebaseFirestore;

  // 4. ローテーショングループ作成
  Future<Result<RotationFirebaseResponse>> createRotation(
    CreateRotationFirebaseRequest dto,
  ) async {
    try {
      // 作成するdocumentへのrefを作成 ※collectionとdocは交互にしなければならない
      final docRef =
          _firebaseFirestore
              .collection('users')
              .doc(dto.userId)
              .collection('rotations')
              .doc();

      // rotationId生成
      final rotationId = docRef.id;

      final dtoWithRotationId = dto.copyWith(
        rotationId: rotationId,
      );
      final mapperResult = RotationFirebaseMapper.fromCreateDto(
        dtoWithRotationId,
      );
      if (mapperResult.isError) {
        return Result.error(
          RotationException('ローテーショングループの作成に失敗しました: $mapperResult'),
        );
      }

      // Firestoreに保存
      await docRef.set(mapperResult.value.toFirestore());

      final result = RotationFirebaseResponse(
        rotationId: rotationId,
        userId: dto.userId,
        rotationName: dto.rotationName,
        rotationMemberNames: dto.rotationMemberNames,
        rotationDays: dto.rotationDays,
        notificationTime: dto.notificationTime,
        currentRotationIndex: dto.currentRotationIndex,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        skipEvents: dto.skipEvents,
      );

      return Result.ok(result);
    } on Exception catch (error) {
      return Result.error(RotationException('ローテーショングループの作成に失敗しました: $error'));
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

      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(RotationException('ローテーショングループの削除に失敗しました: $error'));
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
            fromFirestore: RotationFirebaseMapper.fromFirestore,
            toFirestore:
                (RotationFirebaseMapper mapper, _) => mapper.toFirestore(),
          );

      final docSnap = await docRef.get();
      if (!docSnap.exists) {
        return const Result.error(
          RotationException('対象IDのローテーショングループは存在しません'),
        );
      }

      final mapper = docSnap.data();
      if (mapper == null) {
        return const Result.error(RotationException('ローテーショングループの取得に失敗しました'));
      }

      final dto = mapper.toDto();

      return Result.ok(dto);
    } on Exception catch (error) {
      return Result.error(RotationException('ローテーショングループの取得に失敗しました: $error'));
    }
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
            fromFirestore: RotationFirebaseMapper.fromFirestore,
            toFirestore:
                (RotationFirebaseMapper mapper, _) => mapper.toFirestore(),
          );

      final docSnap = await ref.get();
      final mappers = docSnap.docs.map((doc) => doc.data()).toList();
      final dtos = mappers.map((mapper) => mapper.toDto()).toList();

      return Result.ok(dtos);
    } on Exception catch (error) {
      return Result.error(RotationException('ローテーショングループの取得に失敗しました: $error'));
    }
  }

  // 5. ローテーショングループ更新
  Future<Result<RotationFirebaseResponse>> updateRotation(
    UpdateRotationFirebaseRequest dto,
  ) async {
    try {
      final docRef = _firebaseFirestore
          .collection('users')
          .doc(dto.userId)
          .collection('rotations')
          .doc(dto.rotationId);

      final mapperResult = RotationFirebaseMapper.fromUpdateDto(dto);
      if (mapperResult.isError) {
        return Result.error(
          RotationException('ローテーショングループの更新に失敗しました: $mapperResult'),
        );
      }

      await docRef.update(mapperResult.value.toFirestore());

      // RotationId必須のUpdate用を用意すべき
      // そもそもレスポンスはvoidでよいのでは
      final result = RotationFirebaseResponse(
        rotationId: dto.rotationId,
        userId: dto.userId,
        rotationName: dto.rotationName,
        rotationMemberNames: dto.rotationMemberNames,
        rotationDays: dto.rotationDays,
        notificationTime: dto.notificationTime,
        currentRotationIndex: dto.currentRotationIndex,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        skipEvents: dto.skipEvents,
      );

      return Result.ok(result);
    } on Exception catch (error) {
      return Result.error(RotationException('ローテーショングループの更新に失敗しました: $error'));
    }
  }

  // 1. 自動ローテーショングループ一覧取得
  Stream<Result<List<RotationFirebaseResponse>>> watchRotations(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('rotations')
        .withConverter(
          fromFirestore: RotationFirebaseMapper.fromFirestore,
          toFirestore:
              (RotationFirebaseMapper mapper, _) => mapper.toFirestore(),
        )
        .snapshots()
        .asyncMap((docSnap) async {
          try {
            final mappers = docSnap.docs.map((doc) => doc.data()).toList();
            final dtos = mappers.map((mapper) => mapper.toDto()).toList();
            return Result.ok(dtos);
          } on Exception catch (error) {
            return Result.error(
              RotationException('ローテーショングループの監視中にエラーが発生しました: $error'),
            );
          }
        });
  }
}
