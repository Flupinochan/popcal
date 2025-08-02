// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseFirestoreHash() => r'963402713bf9b7cc1fb259d619d9b0184d4dcec1';

/// See also [firebaseFirestore].
@ProviderFor(firebaseFirestore)
final firebaseFirestoreProvider =
    AutoDisposeProvider<FirebaseFirestore>.internal(
      firebaseFirestore,
      name: r'firebaseFirestoreProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$firebaseFirestoreHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseFirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$firebaseRotationDatasourceHash() =>
    r'bd4e07a084e87a0f66d4776ec322f130ea331bc7';

/// See also [firebaseRotationDatasource].
@ProviderFor(firebaseRotationDatasource)
final firebaseRotationDatasourceProvider =
    AutoDisposeProvider<FirebaseRotationDatasource>.internal(
      firebaseRotationDatasource,
      name: r'firebaseRotationDatasourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$firebaseRotationDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseRotationDatasourceRef =
    AutoDisposeProviderRef<FirebaseRotationDatasource>;
String _$rotationRepositoryHash() =>
    r'b8c7a6e1748745a3c542c6cb0016fbe473c9e0da';

/// See also [rotationRepository].
@ProviderFor(rotationRepository)
final rotationRepositoryProvider =
    AutoDisposeProvider<RotationRepository>.internal(
      rotationRepository,
      name: r'rotationRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$rotationRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RotationRepositoryRef = AutoDisposeProviderRef<RotationRepository>;
String _$rotationGroupsStreamHash() =>
    r'6f2f39a2feb68e60bf7f45e9f12208a145890e54';

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

/// See also [rotationGroupsStream].
@ProviderFor(rotationGroupsStream)
const rotationGroupsStreamProvider = RotationGroupsStreamFamily();

/// See also [rotationGroupsStream].
class RotationGroupsStreamFamily
    extends Family<AsyncValue<Result<List<RotationGroup>>>> {
  /// See also [rotationGroupsStream].
  const RotationGroupsStreamFamily();

  /// See also [rotationGroupsStream].
  RotationGroupsStreamProvider call(String ownerUserId) {
    return RotationGroupsStreamProvider(ownerUserId);
  }

  @override
  RotationGroupsStreamProvider getProviderOverride(
    covariant RotationGroupsStreamProvider provider,
  ) {
    return call(provider.ownerUserId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rotationGroupsStreamProvider';
}

/// See also [rotationGroupsStream].
class RotationGroupsStreamProvider
    extends AutoDisposeStreamProvider<Result<List<RotationGroup>>> {
  /// See also [rotationGroupsStream].
  RotationGroupsStreamProvider(String ownerUserId)
    : this._internal(
        (ref) =>
            rotationGroupsStream(ref as RotationGroupsStreamRef, ownerUserId),
        from: rotationGroupsStreamProvider,
        name: r'rotationGroupsStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$rotationGroupsStreamHash,
        dependencies: RotationGroupsStreamFamily._dependencies,
        allTransitiveDependencies:
            RotationGroupsStreamFamily._allTransitiveDependencies,
        ownerUserId: ownerUserId,
      );

  RotationGroupsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ownerUserId,
  }) : super.internal();

  final String ownerUserId;

  @override
  Override overrideWith(
    Stream<Result<List<RotationGroup>>> Function(
      RotationGroupsStreamRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RotationGroupsStreamProvider._internal(
        (ref) => create(ref as RotationGroupsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ownerUserId: ownerUserId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Result<List<RotationGroup>>>
  createElement() {
    return _RotationGroupsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RotationGroupsStreamProvider &&
        other.ownerUserId == ownerUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ownerUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RotationGroupsStreamRef
    on AutoDisposeStreamProviderRef<Result<List<RotationGroup>>> {
  /// The parameter `ownerUserId` of this provider.
  String get ownerUserId;
}

class _RotationGroupsStreamProviderElement
    extends AutoDisposeStreamProviderElement<Result<List<RotationGroup>>>
    with RotationGroupsStreamRef {
  _RotationGroupsStreamProviderElement(super.provider);

  @override
  String get ownerUserId =>
      (origin as RotationGroupsStreamProvider).ownerUserId;
}

String _$createRotationGroupUseCaseHash() =>
    r'ab499033916bc0fab3f3b596e953058686f88b92';

/// See also [createRotationGroupUseCase].
@ProviderFor(createRotationGroupUseCase)
final createRotationGroupUseCaseProvider =
    AutoDisposeProvider<CreateRotationGroupUseCase>.internal(
      createRotationGroupUseCase,
      name: r'createRotationGroupUseCaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$createRotationGroupUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateRotationGroupUseCaseRef =
    AutoDisposeProviderRef<CreateRotationGroupUseCase>;
String _$updateRotationGroupUseCaseHash() =>
    r'd12d65fb75d1c8ee7405d3061a90d6180cf0ea79';

/// See also [updateRotationGroupUseCase].
@ProviderFor(updateRotationGroupUseCase)
final updateRotationGroupUseCaseProvider =
    AutoDisposeProvider<UpdateRotationGroupUseCase>.internal(
      updateRotationGroupUseCase,
      name: r'updateRotationGroupUseCaseProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$updateRotationGroupUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpdateRotationGroupUseCaseRef =
    AutoDisposeProviderRef<UpdateRotationGroupUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
