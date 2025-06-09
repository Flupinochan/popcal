// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'b5e11f8929542123e90e50b8a39d1336c5203c77';

/// See also [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider =
    AutoDisposeAsyncNotifierProvider<CurrentUser, Result<AppUser?>>.internal(
      CurrentUser.new,
      name: r'currentUserProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentUser = AutoDisposeAsyncNotifier<Result<AppUser?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
