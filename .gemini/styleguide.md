# Flutter/Dart スタイルガイド

# はじめに
このスタイルガイドは、Flutter/Dartコードの開発規約を定めています。
Effective Dart: Styleに準拠し、組織内の特定の要件と好みに対応しています。
日本語で回答してください。

# 基本原則
* **可読性：** コードはすべてのチームメンバーにとって理解しやすいものにしてください
* **保守性：** コードは修正や拡張が容易であるべきです
* **一貫性：** すべてのプロジェクトで一貫したスタイルを守ることで、協働が向上し、エラーが削減されます
* **パフォーマンス：** 可読性を最優先としつつ、効率的なコードを心がけてください
* **Clean Architecture：** レイヤー分離を遵守し、依存関係は内側に向かうようにしてください
* **ドメイン駆動開発：** ビジネスロジックをドメイン層に集中させ、ドメインオブジェクトを活用してください
* **デザインパターン：** 適切なGoF（Gang of Four）デザインパターンを使用して、保守性と拡張性を向上させてください
* **トランザクション管理：** 複数のサービスにまたがる処理にはsaga orchestrationパターンを利用してください

# インデント
* **インデントレベルごとに2スペースを使用してください**（Dart標準）

# インポート
* **インポートをグループ化してください：**
    * Dart SDKインポート（`dart:`で始まるもの）
    * Flutterフレームワークインポート（`package:flutter/`で始まるもの）
    * その他のサードパーティパッケージインポート（`package:`で始まるもの）
    * プロジェクト内の相対インポート
* **絶対インポートを使用してください：** 明確性のため、常に`package:`インポートを使用
* **グループ内ではアルファベット順にソートしてください**

# 命名規則

* **変数・関数：** lowerCamelCaseを使用：`userName`、`calculateTotal()`
* **定数：** lowerCamelCaseを使用：`maxRetryCount`、`apiBaseUrl`
* **クラス・enum：** UpperCamelCaseを使用：`UserManager`、`PaymentStatus`
* **ファイル：** snake_caseを使用：`user_manager.dart`、`payment_service.dart`

# ドキュメンテーション
* **すべてのドキュメンテーションコメントにトリプルスラッシュ（`///`）を使用してください**
* **最初の行：** オブジェクトの目的を簡潔に記述
* **複雑な関数・クラス：** パラメータ、戻り値、例外の詳細な説明を含めてください

# 型アノテーション
* **型アノテーションを使用してください：** コードの可読性向上と早期エラー検出のため
* **Effective Dart: Styleに従ってください：** 標準的なDart型システムとnull safetyを活用

# コメント
* **明確で簡潔なコメントを書いてください：** コードの「何を」ではなく「なぜ」を説明
* **適度にコメントしてください：** 良く書かれたコードは可能な限り自己説明的であるべき
* **完全な文章を使用してください：** 大文字で始まり、適切な句読点を使用

# ログ出力
* **標準的なログフレームワークを使用してください：** `logger`パッケージを使用
* **適切なレベルでログ出力してください：** debug、info、warning、error、fatal
* **コンテキストを提供してください：** デバッグに役立つ関連情報をログメッセージに含める

# エラーハンドリング
* **Resultクラスを使用してください：** エラーハンドリングには`Result<T, E>`パターンを採用
* **最下層での例外処理：** FirebaseAPIの実行など、最下層のデータソース層ではtry-catchの使用を許容
* **エラーの型安全性：** 具体的なエラー型を定義し、適切なエラー情報を提供してください

# デザインパターン
* **Factory Pattern：** オブジェクトの生成ロジックが複雑な場合に使用してください
* **Repository Pattern：** データアクセスの抽象化に使用してください
* **Observer Pattern：** 状態変更の通知にはStream/StreamControllerを活用してください
* **Strategy Pattern：** アルゴリズムの切り替えが必要な場合に使用してください
* **Command Pattern：** ユースケースの実装に使用してください

# トランザクション管理
* **Saga Orchestration：** 複数サービスにまたがる処理にはSagaパターンを使用してください
* **補償トランザクション：** 各ステップに対応するロールバック処理を定義してください
* **状態管理：** Sagaの実行状態を適切に管理してください

# ツール
* **コードフォーマッター：** `dart format` - 一貫したフォーマットを自動的に適用
* **リンター：** `dart analyze`と`analysis_options.yaml` - 潜在的な問題とスタイル違反を特定

# 記述例

```dart
/// Firebaseを使用してメールアドレスとパスワードでサインインを行います。

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../core/result.dart';
import '../domain/entities/user_firebase_response.dart';
import '../domain/errors/auth_exception.dart';
import '../mappers/user_firebase_response_mapper.dart';

final _logger = Logger();

/// メールアドレスとパスワードを使用してFirebase認証を行います。
///
/// [email] はユーザーのメールアドレスです。
/// [password] はユーザーのパスワードです。
///
/// 認証成功時は [UserFirebaseResponse] を含む Result を返します。
/// 認証失敗時は [AuthException] を含む Result を返します。
Future<Result<UserFirebaseResponse>> signInWithEmailAndPassword(
  String email,
  String password,
) async {
  try {
    // Firebase認証でサインイン実行
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 認証結果のユーザー情報を確認
    if (credential.user == null) {
      return const Result.error(AuthException('メールアドレス認証認証に失敗しました'));
    }

    // FirebaseUserをDTOにマッピング
    final dtoResult = UserFirebaseResponseMapper.fromFirebaseUser(
      credential.user!,
    );
    if (dtoResult.isError) {
      return Result.error(dtoResult.error);
    }

    return Result.ok(dtoResult.value);
  } on FirebaseAuthException catch (error) {
    // Firebase固有の認証エラーをハンドリング
    return Result.error(AuthException(_mapFirebaseError(error)));
  } on Exception catch (error) {
    // その他の予期しない例外をハンドリング
    return Result.error(AuthException('メールアドレス認証で、予期しないエラーが発生しました: $error'));
  }
}
```
