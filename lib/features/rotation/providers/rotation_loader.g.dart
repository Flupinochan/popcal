// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_loader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rotationDataResponseHash() =>
    r'08426e88118d8680c0df0359e905602220d8f853';

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
  RotationDataResponseProvider call(RotationId? rotationId) {
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
  RotationDataResponseProvider(RotationId? rotationId)
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

  final RotationId? rotationId;

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
  RotationId? get rotationId;
}

class _RotationDataResponseProviderElement
    extends AutoDisposeFutureProviderElement<Result<RotationDataResponse>>
    with RotationDataResponseRef {
  _RotationDataResponseProviderElement(super.provider);

  @override
  RotationId? get rotationId =>
      (origin as RotationDataResponseProvider).rotationId;
}

String _$rotationResponsesStreamHash() =>
    r'5fd5f1e614481e403498f972c95a37846a15bcd6';

/// See also [rotationResponsesStream].
@ProviderFor(rotationResponsesStream)
const rotationResponsesStreamProvider = RotationResponsesStreamFamily();

/// See also [rotationResponsesStream].
class RotationResponsesStreamFamily
    extends Family<AsyncValue<Result<List<RotationResponse>>>> {
  /// See also [rotationResponsesStream].
  const RotationResponsesStreamFamily();

  /// See also [rotationResponsesStream].
  RotationResponsesStreamProvider call(String userId) {
    return RotationResponsesStreamProvider(userId);
  }

  @override
  RotationResponsesStreamProvider getProviderOverride(
    covariant RotationResponsesStreamProvider provider,
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
  String? get name => r'rotationResponsesStreamProvider';
}

/// See also [rotationResponsesStream].
class RotationResponsesStreamProvider
    extends AutoDisposeStreamProvider<Result<List<RotationResponse>>> {
  /// See also [rotationResponsesStream].
  RotationResponsesStreamProvider(String userId)
    : this._internal(
        (ref) =>
            rotationResponsesStream(ref as RotationResponsesStreamRef, userId),
        from: rotationResponsesStreamProvider,
        name: r'rotationResponsesStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$rotationResponsesStreamHash,
        dependencies: RotationResponsesStreamFamily._dependencies,
        allTransitiveDependencies:
            RotationResponsesStreamFamily._allTransitiveDependencies,
        userId: userId,
      );

  RotationResponsesStreamProvider._internal(
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
    Stream<Result<List<RotationResponse>>> Function(
      RotationResponsesStreamRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RotationResponsesStreamProvider._internal(
        (ref) => create(ref as RotationResponsesStreamRef),
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
  AutoDisposeStreamProviderElement<Result<List<RotationResponse>>>
  createElement() {
    return _RotationResponsesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RotationResponsesStreamProvider && other.userId == userId;
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
mixin RotationResponsesStreamRef
    on AutoDisposeStreamProviderRef<Result<List<RotationResponse>>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _RotationResponsesStreamProviderElement
    extends AutoDisposeStreamProviderElement<Result<List<RotationResponse>>>
    with RotationResponsesStreamRef {
  _RotationResponsesStreamProviderElement(super.provider);

  @override
  String get userId => (origin as RotationResponsesStreamProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
