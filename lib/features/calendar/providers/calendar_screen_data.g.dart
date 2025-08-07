// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_screen_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCalendarDataUseCaseHash() =>
    r'511cb6ad0d64c80fdf7f7831216392a2a58fc950';

/// See also [getCalendarDataUseCase].
@ProviderFor(getCalendarDataUseCase)
final getCalendarDataUseCaseProvider =
    AutoDisposeProvider<GetCalendarDataUseCase>.internal(
      getCalendarDataUseCase,
      name: r'getCalendarDataUseCaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getCalendarDataUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCalendarDataUseCaseRef =
    AutoDisposeProviderRef<GetCalendarDataUseCase>;
String _$calendarScreenDataHash() =>
    r'aeb5670718d11d977f202c3d621bcf20d9046646';

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

/// See also [calendarScreenData].
@ProviderFor(calendarScreenData)
const calendarScreenDataProvider = CalendarScreenDataFamily();

/// See also [calendarScreenData].
class CalendarScreenDataFamily
    extends Family<AsyncValue<Result<CalendarDataResponse>>> {
  /// See also [calendarScreenData].
  const CalendarScreenDataFamily();

  /// See also [calendarScreenData].
  CalendarScreenDataProvider call(String rotationGroupId) {
    return CalendarScreenDataProvider(rotationGroupId);
  }

  @override
  CalendarScreenDataProvider getProviderOverride(
    covariant CalendarScreenDataProvider provider,
  ) {
    return call(provider.rotationGroupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'calendarScreenDataProvider';
}

/// See also [calendarScreenData].
class CalendarScreenDataProvider
    extends AutoDisposeFutureProvider<Result<CalendarDataResponse>> {
  /// See also [calendarScreenData].
  CalendarScreenDataProvider(String rotationGroupId)
    : this._internal(
        (ref) =>
            calendarScreenData(ref as CalendarScreenDataRef, rotationGroupId),
        from: calendarScreenDataProvider,
        name: r'calendarScreenDataProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$calendarScreenDataHash,
        dependencies: CalendarScreenDataFamily._dependencies,
        allTransitiveDependencies:
            CalendarScreenDataFamily._allTransitiveDependencies,
        rotationGroupId: rotationGroupId,
      );

  CalendarScreenDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rotationGroupId,
  }) : super.internal();

  final String rotationGroupId;

  @override
  Override overrideWith(
    FutureOr<Result<CalendarDataResponse>> Function(
      CalendarScreenDataRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalendarScreenDataProvider._internal(
        (ref) => create(ref as CalendarScreenDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rotationGroupId: rotationGroupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<CalendarDataResponse>>
  createElement() {
    return _CalendarScreenDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarScreenDataProvider &&
        other.rotationGroupId == rotationGroupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rotationGroupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalendarScreenDataRef
    on AutoDisposeFutureProviderRef<Result<CalendarDataResponse>> {
  /// The parameter `rotationGroupId` of this provider.
  String get rotationGroupId;
}

class _CalendarScreenDataProviderElement
    extends AutoDisposeFutureProviderElement<Result<CalendarDataResponse>>
    with CalendarScreenDataRef {
  _CalendarScreenDataProviderElement(super.provider);

  @override
  String get rotationGroupId =>
      (origin as CalendarScreenDataProvider).rotationGroupId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
