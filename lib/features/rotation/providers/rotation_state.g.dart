// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rotationGroupListStreamHash() =>
    r'bf9757cce9f272c7112d097e1280022300a1aed6';

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

/// See also [rotationGroupListStream].
@ProviderFor(rotationGroupListStream)
const rotationGroupListStreamProvider = RotationGroupListStreamFamily();

/// See also [rotationGroupListStream].
class RotationGroupListStreamFamily
    extends Family<AsyncValue<Result<List<RotationGroupResponse>>>> {
  /// See also [rotationGroupListStream].
  const RotationGroupListStreamFamily();

  /// See also [rotationGroupListStream].
  RotationGroupListStreamProvider call(String userId) {
    return RotationGroupListStreamProvider(userId);
  }

  @override
  RotationGroupListStreamProvider getProviderOverride(
    covariant RotationGroupListStreamProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rotationGroupListStreamProvider';
}

/// See also [rotationGroupListStream].
class RotationGroupListStreamProvider
    extends AutoDisposeStreamProvider<Result<List<RotationGroupResponse>>> {
  /// See also [rotationGroupListStream].
  RotationGroupListStreamProvider(String userId)
    : this._internal(
        (ref) =>
            rotationGroupListStream(ref as RotationGroupListStreamRef, userId),
        from: rotationGroupListStreamProvider,
        name: r'rotationGroupListStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$rotationGroupListStreamHash,
        dependencies: RotationGroupListStreamFamily._dependencies,
        allTransitiveDependencies:
            RotationGroupListStreamFamily._allTransitiveDependencies,
        userId: userId,
      );

  RotationGroupListStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<Result<List<RotationGroupResponse>>> Function(
      RotationGroupListStreamRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RotationGroupListStreamProvider._internal(
        (ref) => create(ref as RotationGroupListStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Result<List<RotationGroupResponse>>>
  createElement() {
    return _RotationGroupListStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RotationGroupListStreamProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RotationGroupListStreamRef
    on AutoDisposeStreamProviderRef<Result<List<RotationGroupResponse>>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _RotationGroupListStreamProviderElement
    extends
        AutoDisposeStreamProviderElement<Result<List<RotationGroupResponse>>>
    with RotationGroupListStreamRef {
  _RotationGroupListStreamProviderElement(super.provider);

  @override
  String get userId => (origin as RotationGroupListStreamProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
