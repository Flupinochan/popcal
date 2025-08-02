// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localNotificationsDatasourceHash() =>
    r'a1f9391392b2617af690abe3552fbdde98669abc';

/// See also [localNotificationsDatasource].
@ProviderFor(localNotificationsDatasource)
final localNotificationsDatasourceProvider =
    AutoDisposeProvider<LocalNotificationsDatasource>.internal(
      localNotificationsDatasource,
      name: r'localNotificationsDatasourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$localNotificationsDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalNotificationsDatasourceRef =
    AutoDisposeProviderRef<LocalNotificationsDatasource>;
String _$notificationRepositoryHash() =>
    r'a5790a75231f1b519952411d5f1640cbbe59a4bd';

/// See also [notificationRepository].
@ProviderFor(notificationRepository)
final notificationRepositoryProvider =
    AutoDisposeProvider<NotificationRepository>.internal(
      notificationRepository,
      name: r'notificationRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$notificationRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationRepositoryRef =
    AutoDisposeProviderRef<NotificationRepository>;
String _$syncNotificationsUseCaseHash() =>
    r'523533e94e97ab9a8729d4b6fb9e450ad31aa2d6';

/// See also [syncNotificationsUseCase].
@ProviderFor(syncNotificationsUseCase)
final syncNotificationsUseCaseProvider =
    AutoDisposeProvider<SyncNotificationsUseCase>.internal(
      syncNotificationsUseCase,
      name: r'syncNotificationsUseCaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$syncNotificationsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncNotificationsUseCaseRef =
    AutoDisposeProviderRef<SyncNotificationsUseCase>;
String _$calendarNotificationDetailsHash() =>
    r'76c4fc1ac79a84c13640078baf2bc020ddf4e3b2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [calendarNotificationDetails].
@ProviderFor(calendarNotificationDetails)
const calendarNotificationDetailsProvider = CalendarNotificationDetailsFamily();

/// See also [calendarNotificationDetails].
class CalendarNotificationDetailsFamily
    extends Family<AsyncValue<List<NotificationCalendar>>> {
  /// See also [calendarNotificationDetails].
  const CalendarNotificationDetailsFamily();

  /// See also [calendarNotificationDetails].
  CalendarNotificationDetailsProvider call(RotationGroup rotationGroup) {
    return CalendarNotificationDetailsProvider(rotationGroup);
  }

  @override
  CalendarNotificationDetailsProvider getProviderOverride(
    covariant CalendarNotificationDetailsProvider provider,
  ) {
    return call(provider.rotationGroup);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'calendarNotificationDetailsProvider';
}

/// See also [calendarNotificationDetails].
class CalendarNotificationDetailsProvider
    extends AutoDisposeFutureProvider<List<NotificationCalendar>> {
  /// See also [calendarNotificationDetails].
  CalendarNotificationDetailsProvider(RotationGroup rotationGroup)
    : this._internal(
        (ref) => calendarNotificationDetails(
          ref as CalendarNotificationDetailsRef,
          rotationGroup,
        ),
        from: calendarNotificationDetailsProvider,
        name: r'calendarNotificationDetailsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$calendarNotificationDetailsHash,
        dependencies: CalendarNotificationDetailsFamily._dependencies,
        allTransitiveDependencies:
            CalendarNotificationDetailsFamily._allTransitiveDependencies,
        rotationGroup: rotationGroup,
      );

  CalendarNotificationDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rotationGroup,
  }) : super.internal();

  final RotationGroup rotationGroup;

  @override
  Override overrideWith(
    FutureOr<List<NotificationCalendar>> Function(
      CalendarNotificationDetailsRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalendarNotificationDetailsProvider._internal(
        (ref) => create(ref as CalendarNotificationDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rotationGroup: rotationGroup,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<NotificationCalendar>> createElement() {
    return _CalendarNotificationDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarNotificationDetailsProvider &&
        other.rotationGroup == rotationGroup;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rotationGroup.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalendarNotificationDetailsRef
    on AutoDisposeFutureProviderRef<List<NotificationCalendar>> {
  /// The parameter `rotationGroup` of this provider.
  RotationGroup get rotationGroup;
}

class _CalendarNotificationDetailsProviderElement
    extends AutoDisposeFutureProviderElement<List<NotificationCalendar>>
    with CalendarNotificationDetailsRef {
  _CalendarNotificationDetailsProviderElement(super.provider);

  @override
  RotationGroup get rotationGroup =>
      (origin as CalendarNotificationDetailsProvider).rotationGroup;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
