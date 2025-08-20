// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_handlers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calendarScheduleResponseHash() =>
    r'd2f92155191be7a5b7295decaef3811d4fc25cf1';

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

/// See also [calendarScheduleResponse].
@ProviderFor(calendarScheduleResponse)
const calendarScheduleResponseProvider = CalendarScheduleResponseFamily();

/// See also [calendarScheduleResponse].
class CalendarScheduleResponseFamily
    extends Family<AsyncValue<Result<CalendarScheduleResponse>>> {
  /// See also [calendarScheduleResponse].
  const CalendarScheduleResponseFamily();

  /// See also [calendarScheduleResponse].
  CalendarScheduleResponseProvider call(String rotationId) {
    return CalendarScheduleResponseProvider(rotationId);
  }

  @override
  CalendarScheduleResponseProvider getProviderOverride(
    covariant CalendarScheduleResponseProvider provider,
  ) {
    return call(provider.rotationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'calendarScheduleResponseProvider';
}

/// See also [calendarScheduleResponse].
class CalendarScheduleResponseProvider
    extends AutoDisposeFutureProvider<Result<CalendarScheduleResponse>> {
  /// See also [calendarScheduleResponse].
  CalendarScheduleResponseProvider(String rotationId)
    : this._internal(
        (ref) => calendarScheduleResponse(
          ref as CalendarScheduleResponseRef,
          rotationId,
        ),
        from: calendarScheduleResponseProvider,
        name: r'calendarScheduleResponseProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$calendarScheduleResponseHash,
        dependencies: CalendarScheduleResponseFamily._dependencies,
        allTransitiveDependencies:
            CalendarScheduleResponseFamily._allTransitiveDependencies,
        rotationId: rotationId,
      );

  CalendarScheduleResponseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rotationId,
  }) : super.internal();

  final String rotationId;

  @override
  Override overrideWith(
    FutureOr<Result<CalendarScheduleResponse>> Function(
      CalendarScheduleResponseRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalendarScheduleResponseProvider._internal(
        (ref) => create(ref as CalendarScheduleResponseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rotationId: rotationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<CalendarScheduleResponse>>
  createElement() {
    return _CalendarScheduleResponseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarScheduleResponseProvider &&
        other.rotationId == rotationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rotationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalendarScheduleResponseRef
    on AutoDisposeFutureProviderRef<Result<CalendarScheduleResponse>> {
  /// The parameter `rotationId` of this provider.
  String get rotationId;
}

class _CalendarScheduleResponseProviderElement
    extends AutoDisposeFutureProviderElement<Result<CalendarScheduleResponse>>
    with CalendarScheduleResponseRef {
  _CalendarScheduleResponseProviderElement(super.provider);

  @override
  String get rotationId =>
      (origin as CalendarScheduleResponseProvider).rotationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
