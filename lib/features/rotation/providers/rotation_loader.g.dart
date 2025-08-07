// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_loader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rotationDataResponseHash() =>
    r'7195e95dbcc165ebda4101beb8d058a07107bd45';

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

/// See also [rotationDataResponse].
@ProviderFor(rotationDataResponse)
const rotationDataResponseProvider = RotationDataResponseFamily();

/// See also [rotationDataResponse].
class RotationDataResponseFamily
    extends Family<AsyncValue<Result<RotationDataResponse>>> {
  /// See also [rotationDataResponse].
  const RotationDataResponseFamily();

  /// See also [rotationDataResponse].
  RotationDataResponseProvider call(String? rotationId) {
    return RotationDataResponseProvider(rotationId);
  }

  @override
  RotationDataResponseProvider getProviderOverride(
    covariant RotationDataResponseProvider provider,
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
  String? get name => r'rotationDataResponseProvider';
}

/// See also [rotationDataResponse].
class RotationDataResponseProvider
    extends AutoDisposeFutureProvider<Result<RotationDataResponse>> {
  /// See also [rotationDataResponse].
  RotationDataResponseProvider(String? rotationId)
    : this._internal(
        (ref) =>
            rotationDataResponse(ref as RotationDataResponseRef, rotationId),
        from: rotationDataResponseProvider,
        name: r'rotationDataResponseProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$rotationDataResponseHash,
        dependencies: RotationDataResponseFamily._dependencies,
        allTransitiveDependencies:
            RotationDataResponseFamily._allTransitiveDependencies,
        rotationId: rotationId,
      );

  RotationDataResponseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rotationId,
  }) : super.internal();

  final String? rotationId;

  @override
  Override overrideWith(
    FutureOr<Result<RotationDataResponse>> Function(
      RotationDataResponseRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RotationDataResponseProvider._internal(
        (ref) => create(ref as RotationDataResponseRef),
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
  AutoDisposeFutureProviderElement<Result<RotationDataResponse>>
  createElement() {
    return _RotationDataResponseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RotationDataResponseProvider &&
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
mixin RotationDataResponseRef
    on AutoDisposeFutureProviderRef<Result<RotationDataResponse>> {
  /// The parameter `rotationId` of this provider.
  String? get rotationId;
}

class _RotationDataResponseProviderElement
    extends AutoDisposeFutureProviderElement<Result<RotationDataResponse>>
    with RotationDataResponseRef {
  _RotationDataResponseProviderElement(super.provider);

  @override
  String? get rotationId => (origin as RotationDataResponseProvider).rotationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
