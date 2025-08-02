// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calendarDataHash() => r'126c11815713b5d16794ae23c796df2e4f76d0c9';

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

/// See also [calendarData].
@ProviderFor(calendarData)
const calendarDataProvider = CalendarDataFamily();

/// See also [calendarData].
class CalendarDataFamily extends Family<AsyncValue<Result<CalendarData>>> {
  /// See also [calendarData].
  const CalendarDataFamily();

  /// See also [calendarData].
  CalendarDataProvider call(String rotationGroupId) {
    return CalendarDataProvider(rotationGroupId);
  }

  @override
  CalendarDataProvider getProviderOverride(
    covariant CalendarDataProvider provider,
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
  String? get name => r'calendarDataProvider';
}

/// See also [calendarData].
class CalendarDataProvider
    extends AutoDisposeFutureProvider<Result<CalendarData>> {
  /// See also [calendarData].
  CalendarDataProvider(String rotationGroupId)
    : this._internal(
        (ref) => calendarData(ref as CalendarDataRef, rotationGroupId),
        from: calendarDataProvider,
        name: r'calendarDataProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$calendarDataHash,
        dependencies: CalendarDataFamily._dependencies,
        allTransitiveDependencies:
            CalendarDataFamily._allTransitiveDependencies,
        rotationGroupId: rotationGroupId,
      );

  CalendarDataProvider._internal(
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
    FutureOr<Result<CalendarData>> Function(CalendarDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalendarDataProvider._internal(
        (ref) => create(ref as CalendarDataRef),
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
  AutoDisposeFutureProviderElement<Result<CalendarData>> createElement() {
    return _CalendarDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarDataProvider &&
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
mixin CalendarDataRef on AutoDisposeFutureProviderRef<Result<CalendarData>> {
  /// The parameter `rotationGroupId` of this provider.
  String get rotationGroupId;
}

class _CalendarDataProviderElement
    extends AutoDisposeFutureProviderElement<Result<CalendarData>>
    with CalendarDataRef {
  _CalendarDataProviderElement(super.provider);

  @override
  String get rotationGroupId =>
      (origin as CalendarDataProvider).rotationGroupId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
