import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/data/dto/rotation_group_firebase_dto.dart';

class FirebaseRotationDatasource {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseRotationDatasource(this._firebaseFirestore);

  Future<Result<RotationGroupFirebaseDto>> createRotationGroup(
    RotationGroupFirebaseDto dto,
  ) async {
    try {
      // 作成するdocumentへのrefを作成 ※collectionとdocは交互にしなければならない
      final docRef =
          _firebaseFirestore
              .collection('users')
              .doc(dto.ownerUserId)
              .collection('rotationGroups')
              .doc();

      // Firestoreに保存
      await docRef.set(dto.toFirestore());

      final result = RotationGroupFirebaseDto(
        rotationGroupId: docRef.id, // 生成されたdocument id
        ownerUserId: dto.ownerUserId,
        rotationName: dto.rotationName,
        rotationMembers: dto.rotationMembers,
        notificationTime: dto.notificationTime,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
      );

      return Results.success(result);
    } catch (error) {
      return Results.failure(NetworkFailure('ローテーショングループの作成に失敗しました: $error'));
    }
  }

  Future<Result<List<RotationGroupFirebaseDto>>> getRotationGroups(
    String ownerUserId,
  ) async {
    try {
      final ref = _firebaseFirestore
          .collection('users')
          .doc(ownerUserId)
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
}
