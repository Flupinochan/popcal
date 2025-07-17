# PopCal

作成中...

## Architecture Overview

![Clean Architecture](out/class_diagram/class_diagram.svg)

### Clean Architectureに準拠
`data` => `domain` <= `presentation`
- `data`は、`domain`のみに依存、`presentation`に依存しない
- `presentation`は、`domain`のみに依存、`data`に依存しない
- `domain`は、どこにも依存しない中核

`View` => `ViewModel` => `Repository` => `Service`
- `View` と `ViewModel` は1対1で、`ViewModel` に表示するデータやメソッドを定義
- `ViewModel` では基本的にコンストラクタで `Repository` を受け取るが、RiverPodではInterface経由なため、直接利用も可
- `Repository` ではコンストラクタで `Service` を利用
- `Service` は他のオブジェクトに依存しない外部サービス

※[class_diagram.puml](class_diagram.puml) よりPlantUML図をvscode拡張機能でsvg出力

## Project Structure

- `Layer-First` ではなく、`Feature-First` アプローチ
- 上位ディレクトリは、domainやpresentation単位で区切らず、authやhomeなど機能ごとにディレクトリを区切る

## File Naming Conventions

- domainディレクトリ配下のファイルはxxxのみ
- data、domainディレクトリを含むその他の配下のファイルはxxx_dto、xxx_view_modelと命名

## Architecture Decisions

- use case
    - 複数のrepositoryの利用、複雑な処理がないため実装しない
- mapper
    - user_dtoがfirebaseに依存しているが、uidとemailのみでシンプルなため実装しない

## Error Handling

- fpdartライブラリ (Resultクラス) を利用
- エラーはスローせず、`Result<T>.success` または `Result<Failure>.failure` を returnする

## Memo

### Launch Emulator

```bash
cd C:\Users\metalmental\AppData\Local\Android\Sdk\emulator
.\emulator -list-avds
.\emulator -avd Pixel_7a -dns-server 8.8.8.8
```

### Riverpod Generator / Freezed

```bash
dart run custom_lint
dart run build_runner watch -d
```

- Repository
    - firebase instanceをref.read()するため、テスト時はモックして置き換える
    - 引数でref.read()してinjectionしておけば、Providerのコードのみ変更すればよい
- ViewModel/Screen
    - `Interface` のRepositoryをref.read()しているため、モックはしない。コード内で直接ref.read()して使用してよい
    - 逆にコード内でref.read()してよいのは、Interfaceで定義されている@riverpodのみ

- 関数ベースの@riverpod
    - 状態を持たない、DI用
- クラスベースの@riverpod
    - 状態(非同期状態など)を持つ、ViewModel用
    - 状態変更するメソッドを定義

### Formatter/Linter

strict modeを使用

```yaml
analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

### ライブラリ選定

とりあえずflutter favoriteお墨付きを利用
flutter gemsで検索

https://pub.dev/packages?q=is%3Aflutter-favorite

### Firebase CLI

firestoreのsecurity ruleは`firestore.rules`で管理
※firebase.jsonでfirestore.rulesを指定

```bash
# list projects
firebase projects:list

# show active project
firebase use

# activate project
firebase use --add popcal-e709a

# verify security rules
firebase deploy --only firestore:rules --dry-run

# deploy security rules
firebase deploy --only firestore:rules
```