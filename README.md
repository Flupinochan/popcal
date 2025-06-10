# popcal

A new Flutter project.

## PlantUML図

`class_diagram.puml` をvscode拡張機能で出力

![Clean Architecture](out/class_diagram/class_diagram.svg)

## ディレクトリ構造

`Layer-First` ではなく、`Feature-First` アプローチ
上位ディレクトリは、DomainやPresentation単位で区切らず、AuthやHomeなど機能ごとにディレクトリを区切る

- data: 外部に依存する処理
    - domainのInterfaceの実装
    - リクエスト用ユーザ情報定義
    - Firebaseで認証
    - Localキャッシュで認証
    - API
    - DB
- domain: 外部に依存しない中核処理
    - Interface定義
    - ユーザ情報
    - 認証処理定義
- presentation: UI

## ファイル命名規則

entities配下のファイルはxxxのみでOK、中心概念
その他model、usecases配下のファイルはxxx_model、xxx_usecasesと命名

## Riverpod Generator

```bash
dart run custom_lint
dart run build_runner watch -d
```

## use case

複数のrepositoryの利用、複雑な処理がないため実装しない