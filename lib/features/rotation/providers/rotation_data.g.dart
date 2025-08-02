// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rotationDataHash() => r'20cffe635cb52e13c7722c62ba8d7b76459f417c';

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

/// See also [rotationData].
@ProviderFor(rotationData)
const rotationDataProvider = RotationDataFamily();

/// See also [rotationData].
class RotationDataFamily extends Family<AsyncValue<Result<RotationData>>> {
  /// See also [rotationData].
  const RotationDataFamily();

  /// See also [rotationData].
  RotationDataProvider call(String? rotationGroupId) {
    return RotationDataProvider(rotationGroupId);
  }

  @override
  RotationDataProvider getProviderOverride(
    covariant RotationDataProvider provider,
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
  String? get name => r'rotationDataProvider';
}

/// See also [rotationData].
class RotationDataProvider
    extends AutoDisposeFutureProvider<Result<RotationData>> {
  /// See also [rotationData].
  RotationDataProvider(String? rotationGroupId)
    : this._internal(
        (ref) => rotationData(ref as RotationDataRef, rotationGroupId),
        from: rotationDataProvider,
        name: r'rotationDataProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$rotationDataHash,
        dependencies: RotationDataFamily._dependencies,
        allTransitiveDependencies:
            RotationDataFamily._allTransitiveDependencies,
        rotationGroupId: rotationGroupId,
      );

  RotationDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rotationGroupId,
  }) : super.internal();

  final String? rotationGroupId;

  @override
  Override overrideWith(
    FutureOr<Result<RotationData>> Function(RotationDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RotationDataProvider._internal(
        (ref) => create(ref as RotationDataRef),
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
  AutoDisposeFutureProviderElement<Result<RotationData>> createElement() {
    return _RotationDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RotationDataProvider &&
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
mixin RotationDataRef on AutoDisposeFutureProviderRef<Result<RotationData>> {
  /// The parameter `rotationGroupId` of this provider.
  String? get rotationGroupId;
}

class _RotationDataProviderElement
    extends AutoDisposeFutureProviderElement<Result<RotationData>>
    with RotationDataRef {
  _RotationDataProviderElement(super.provider);

  @override
  String? get rotationGroupId =>
      (origin as RotationDataProvider).rotationGroupId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
