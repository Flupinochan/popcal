// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deadline_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deadlineCalculationServiceHash() =>
    r'b0fcf66c40c2ddd22e0beba20a68591f7cd64bfe';

/// See also [deadlineCalculationService].
@ProviderFor(deadlineCalculationService)
final deadlineCalculationServiceProvider =
    AutoDisposeProvider<DeadlineCalculationService>.internal(
      deadlineCalculationService,
      name: r'deadlineCalculationServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$deadlineCalculationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeadlineCalculationServiceRef =
    AutoDisposeProviderRef<DeadlineCalculationService>;
String _$deadlineRepositoryHash() =>
    r'bf9e011831eeff2f6c8cc6d1886d57e26188ea15';

/// See also [deadlineRepository].
@ProviderFor(deadlineRepository)
final deadlineRepositoryProvider = Provider<DeadlineRepository>.internal(
  deadlineRepository,
  name: r'deadlineRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deadlineRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeadlineRepositoryRef = ProviderRef<DeadlineRepository>;
String _$deadlineSharedPreferencesHash() =>
    r'968c0d9819d3bc6c56b10e743cdde0ba6f91c9ec';

/// See also [deadlineSharedPreferences].
@ProviderFor(deadlineSharedPreferences)
final deadlineSharedPreferencesProvider =
    Provider<DeadlineSharedPreferences>.internal(
      deadlineSharedPreferences,
      name: r'deadlineSharedPreferencesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$deadlineSharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeadlineSharedPreferencesRef = ProviderRef<DeadlineSharedPreferences>;
String _$getDeadlineNotificationsHash() =>
    r'428c6233e2c7dda6c3f5ba20079aa15eee4ca439';

/// See also [getDeadlineNotifications].
@ProviderFor(getDeadlineNotifications)
final getDeadlineNotificationsProvider =
    AutoDisposeFutureProvider<Result<List<NotificationEntry>>>.internal(
      getDeadlineNotifications,
      name: r'getDeadlineNotificationsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getDeadlineNotificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDeadlineNotificationsRef =
    AutoDisposeFutureProviderRef<Result<List<NotificationEntry>>>;
String _$sharedPreferencesHash() => r'225e34d1d5293ff0304837a7ce3d6fdc21c7747c';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$toggleDeadlineUseCaseHash() =>
    r'eb35aaa8ff0839d8242403837db5f220e22f4e36';

/// See also [toggleDeadlineUseCase].
@ProviderFor(toggleDeadlineUseCase)
final toggleDeadlineUseCaseProvider =
    AutoDisposeProvider<ToggleDeadlineUseCase>.internal(
      toggleDeadlineUseCase,
      name: r'toggleDeadlineUseCaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$toggleDeadlineUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ToggleDeadlineUseCaseRef =
    AutoDisposeProviderRef<ToggleDeadlineUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
