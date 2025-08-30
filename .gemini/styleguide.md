# Flutter/Dart スタイルガイド

## はじめに

このスタイルガイドは、Flutter/Dartコードの開発規約を定めています。
公式の[Flutter リポジトリのスタイルガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/Style-guide-for-Flutter-repo.md)に準拠し、組織内の特定の要件と好みに対応しています。
日本語で回答してください。

## ベストプラクティス

- コードは[Flutter コントリビューションガイド](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md)で説明されているガイダンスと原則に従う必要があります。
- コードはテストされ、[効果的なテストの書き方ガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/testing/Writing-Effective-Tests.md)と[テストの実行と作成ガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/testing/Running-and-writing-tests.md)で説明されているガイダンスに従う必要があります。
- 最も関連性の高いガイドラインが、関連性の低いガイドラインよりも優先されます。Flutter コードの場合、[Flutter スタイルガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/Style-guide-for-Flutter-repo.md)を最優先で従い、[Effective Dart: Style](https://dart.dev/effective-dart/style)は前者と競合しない場合にのみ従う必要があります。


## 基本原則

- **可読性：** コードはすべてのチームメンバーにとって理解しやすいものにしてください
- **保守性：** コードは修正や拡張が容易であるべきです
- **一貫性：** すべてのプロジェクトで一貫したスタイルを守ることで、協働が向上し、エラーが削減されます
- **パフォーマンス：** 可読性を最優先としつつ、効率的なコードを心がけてください
- **Clean Architecture：** レイヤー分離を遵守し、依存関係は内側に向かうようにしてください
- **ドメイン駆動開発：** ビジネスロジックをドメイン層に集中させ、ドメインオブジェクトを活用してください
- **デザインパターン：** 適切なGoF（Gang of Four）デザインパターンを使用して、保守性と拡張性を向上させてください
- **トランザクション管理：** 複数のサービスにまたがる処理にはsaga orchestrationパターンを利用してください

## インデント

- **インデントレベルごとに2スペースを使用してください**（Dart標準）

## インポート

- **インポートをグループ化してください：**
    * Dart SDKインポート（`dart:`で始まるもの）
    * Flutterフレームワークインポート（`package:flutter/`で始まるもの）
    * その他のサードパーティパッケージインポート（`package:`で始まるもの）
    * プロジェクト内の相対インポート
- **絶対インポートを使用してください：** 明確性のため、常に`package:`インポートを使用
- **グループ内ではアルファベット順にソートしてください**

## 命名規則

- **変数・関数：** lowerCamelCaseを使用：`userName`、`calculateTotal()`
- **定数：** lowerCamelCaseを使用：`maxRetryCount`、`apiBaseUrl`
- **クラス・enum：** UpperCamelCaseを使用：`UserManager`、`PaymentStatus`
- **ファイル：** snake_caseを使用：`user_manager.dart`、`payment_service.dart`

## ドキュメンテーション

- すべての公開メンバーはドキュメントを持つ必要があります。
- **自分の質問に答える**: 疑問を持った場合は、答えを見つけ、最初に見た場所でそれを文書化します。
- **ドキュメントは有用であるべき**: *なぜ*と*どのように*を説明します。
- **用語を紹介する**: 読者がすべてを知っているとは仮定しません。定義へのリンクを提供します。
- **サンプルコードを提供する**: 実行可能な例には `{@tool dartpad}` を使用します。
  - インラインコードサンプルは `{@tool dartpad}` と `{@end-tool}` で囲み、以下の例の形式を使用してコードサンプルを挿入します:
    - `/// ** See code in examples/api/lib/widgets/sliver/sliver_list.0.dart **`
    - この形式を、開発者に有用なパンくずリストを提供するドキュメントの `/// See also:` セクションと混同しないでください。
- ウィジェットには**イラストやスクリーンショット**を提供します。
- プライベートメンバーであっても、公開品質のドキュメントには `///` を使用します。

## 型アノテーション

- **型アノテーションを使用してください：** コードの可読性向上と早期エラー検出のため
- **Effective Dart: Styleに従ってください：** 標準的なDart型システムとnull safetyを活用

## コメント

- **明確で簡潔なコメントを書いてください：** コードの「何を」ではなく「なぜ」を説明
- **適度にコメントしてください：** 良く書かれたコードは可能な限り自己説明的であるべき
- **完全な文章を使用してください：** 大文字で始まり、適切な句読点を使用

## ログ出力

- **標準的なログフレームワークを使用してください：** `logger`パッケージを使用
- **適切なレベルでログ出力してください：** debug、info、warning、error、fatal
- **コンテキストを提供してください：** デバッグに役立つ関連情報をログメッセージに含める

## エラーハンドリング

- **Resultクラスを使用してください：** エラーハンドリングには`Result<T, E>`パターンを採用
- **最下層での例外処理：** FirebaseAPIの実行など、最下層のデータソース層ではtry-catchの使用を許容
- **エラーの型安全性：** 具体的なエラー型を定義し、適切なエラー情報を提供してください

## デザインパターン

- **Factory Pattern：** オブジェクトの生成ロジックが複雑な場合に使用してください
- **Repository Pattern：** データアクセスの抽象化に使用してください
- **Observer Pattern：** 状態変更の通知にはStream/StreamControllerを活用してください
- **Strategy Pattern：** アルゴリズムの切り替えが必要な場合に使用してください
- **Command Pattern：** ユースケースの実装に使用してください

## トランザクション管理

- **Saga Orchestration：** 複数サービスにまたがる処理にはSagaパターンを使用してください
- **補償トランザクション：** 各ステップに対応するロールバック処理を定義してください
- **状態管理：** Sagaの実行状態を適切に管理してください

## ツール

- **コードフォーマッター：** `dart format` - 一貫したフォーマットを自動的に適用
- **リンター：** `dart analyze`と`analysis_options.yaml` - 潜在的な問題とスタイル違反を特定

## 記述例

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

## レビューエージェントガイドライン

要約を提供する際、レビューエージェントは以下の原則を遵守する必要があります:
- **客観的である**: 変更の中立的で記述的な要約に焦点を当てます。「良い」、「悪い」、「ポジティブ」、「ネガティブ」などの主観的な価値判断を避けます。目標はコードが何をするかを報告することであり、それを評価することではありません。
- **コードを真実の源として使用する**: すべての要約をコード差分に基づいて作成します。古くて不正確な可能性がある PR の説明を信頼したり言い換えたりしないでください。要約はコードの実際の変更を反映する必要があります。
- **簡潔にする**: 要点を簡潔にまとめた要約を生成します。最も重要な変更に焦点を当て、不要な詳細や冗長な説明を避けます。これにより、フィードバックが読みやすく理解しやすくなります。


## 参考資料

より詳細なガイダンスについては、以下の文書を参照してください:

- [Flutter リポジトリのスタイルガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/Style-guide-for-Flutter-repo.md)
- [Effective Dart: Style](https://dart.dev/effective-dart/style)
- [Tree Hygiene](https://github.com/flutter/flutter/blob/main/docs/contributing/Tree-hygiene.md)
- [Flutter コントリビューションガイド](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md)
- [効果的なテストの書き方ガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/testing/Writing-Effective-Tests.md)
- [テストの実行と作成ガイド](https://github.com/flutter/flutter/blob/main/docs/contributing/testing/Running-and-writing-tests.md)
- [エンジンテストガイド](https://github.com/flutter/flutter/blob/main/engine/src/flutter/docs/testing/Testing-the-engine.md)
