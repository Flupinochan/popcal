// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_notifications_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncNotificationsUseCaseHash() =>
    r'fb6cd0ffec5dc5eb0ff2e9186b9ac6a22efe5795';

/// home画面表示時に以下の処理を実行し、firestoreの通知設定一覧とlocal notificationの通知設定を合わせる
/// 1. firestoreから通知設定の一覧を取得
/// 2. 通知予定のlocal notificationの一覧を取得
/// 3. 過去の時刻で通知予定にない通知をfirestoreから削除
/// 4. 未来の時刻で通知予定にない通知をlocal notificationに作成
///
/// Copied from [SyncNotificationsUseCase].
@ProviderFor(SyncNotificationsUseCase)
final syncNotificationsUseCaseProvider =
    AutoDisposeAsyncNotifierProvider<SyncNotificationsUseCase, void>.internal(
      SyncNotificationsUseCase.new,
      name: r'syncNotificationsUseCaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$syncNotificationsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SyncNotificationsUseCase = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
