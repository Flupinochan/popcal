// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_rotation_handlers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteRotationHash() => r'466d98f567df4f2557964bb6e263fb6530f32d87';

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

/// state管理不要な削除メソッド
///
/// Copied from [deleteRotation].
@ProviderFor(deleteRotation)
const deleteRotationProvider = DeleteRotationFamily();

/// state管理不要な削除メソッド
///
/// Copied from [deleteRotation].
class DeleteRotationFamily extends Family<AsyncValue<Result<void>>> {
  /// state管理不要な削除メソッド
  ///
  /// Copied from [deleteRotation].
  const DeleteRotationFamily();

  /// state管理不要な削除メソッド
  ///
  /// Copied from [deleteRotation].
  DeleteRotationProvider call(String userId, String rotationId) {
    return DeleteRotationProvider(userId, rotationId);
  }

  @override
  DeleteRotationProvider getProviderOverride(
    covariant DeleteRotationProvider provider,
  ) {
    return call(provider.userId, provider.rotationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteRotationProvider';
}

/// state管理不要な削除メソッド
///
/// Copied from [deleteRotation].
class DeleteRotationProvider extends AutoDisposeFutureProvider<Result<void>> {
  /// state管理不要な削除メソッド
  ///
  /// Copied from [deleteRotation].
  DeleteRotationProvider(String userId, String rotationId)
    : this._internal(
        (ref) => deleteRotation(ref as DeleteRotationRef, userId, rotationId),
        from: deleteRotationProvider,
        name: r'deleteRotationProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$deleteRotationHash,
        dependencies: DeleteRotationFamily._dependencies,
        allTransitiveDependencies:
            DeleteRotationFamily._allTransitiveDependencies,
        userId: userId,
        rotationId: rotationId,
      );

  DeleteRotationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.rotationId,
  }) : super.internal();

  final String userId;
  final String rotationId;

  @override
  Override overrideWith(
    FutureOr<Result<void>> Function(DeleteRotationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteRotationProvider._internal(
        (ref) => create(ref as DeleteRotationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        rotationId: rotationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<void>> createElement() {
    return _DeleteRotationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteRotationProvider &&
        other.userId == userId &&
        other.rotationId == rotationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, rotationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteRotationRef on AutoDisposeFutureProviderRef<Result<void>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `rotationId` of this provider.
  String get rotationId;
}

class _DeleteRotationProviderElement
    extends AutoDisposeFutureProviderElement<Result<void>>
    with DeleteRotationRef {
  _DeleteRotationProviderElement(super.provider);

  @override
  String get userId => (origin as DeleteRotationProvider).userId;
  @override
  String get rotationId => (origin as DeleteRotationProvider).rotationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
