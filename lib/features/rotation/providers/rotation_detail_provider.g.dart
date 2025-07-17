// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rotation_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rotationDetailHash() => r'55712f4e53bee29bb168dbae78a29701a492e6b7';

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

abstract class _$RotationDetail
    extends BuildlessAutoDisposeAsyncNotifier<RotationGroup?> {
  late final String ownerUserId;
  late final String rotationGroupId;

  FutureOr<RotationGroup?> build(String ownerUserId, String rotationGroupId);
}

/// See also [RotationDetail].
@ProviderFor(RotationDetail)
const rotationDetailProvider = RotationDetailFamily();

/// See also [RotationDetail].
class RotationDetailFamily extends Family<AsyncValue<RotationGroup?>> {
  /// See also [RotationDetail].
  const RotationDetailFamily();

  /// See also [RotationDetail].
  RotationDetailProvider call(String ownerUserId, String rotationGroupId) {
    return RotationDetailProvider(ownerUserId, rotationGroupId);
  }

  @override
  RotationDetailProvider getProviderOverride(
    covariant RotationDetailProvider provider,
  ) {
    return call(provider.ownerUserId, provider.rotationGroupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rotationDetailProvider';
}

/// See also [RotationDetail].
class RotationDetailProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<RotationDetail, RotationGroup?> {
  /// See also [RotationDetail].
  RotationDetailProvider(String ownerUserId, String rotationGroupId)
    : this._internal(
        () =>
            RotationDetail()
              ..ownerUserId = ownerUserId
              ..rotationGroupId = rotationGroupId,
        from: rotationDetailProvider,
        name: r'rotationDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$rotationDetailHash,
        dependencies: RotationDetailFamily._dependencies,
        allTransitiveDependencies:
            RotationDetailFamily._allTransitiveDependencies,
        ownerUserId: ownerUserId,
        rotationGroupId: rotationGroupId,
      );

  RotationDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ownerUserId,
    required this.rotationGroupId,
  }) : super.internal();

  final String ownerUserId;
  final String rotationGroupId;

  @override
  FutureOr<RotationGroup?> runNotifierBuild(covariant RotationDetail notifier) {
    return notifier.build(ownerUserId, rotationGroupId);
  }

  @override
  Override overrideWith(RotationDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: RotationDetailProvider._internal(
        () =>
            create()
              ..ownerUserId = ownerUserId
              ..rotationGroupId = rotationGroupId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ownerUserId: ownerUserId,
        rotationGroupId: rotationGroupId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RotationDetail, RotationGroup?>
  createElement() {
    return _RotationDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RotationDetailProvider &&
        other.ownerUserId == ownerUserId &&
        other.rotationGroupId == rotationGroupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ownerUserId.hashCode);
    hash = _SystemHash.combine(hash, rotationGroupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RotationDetailRef on AutoDisposeAsyncNotifierProviderRef<RotationGroup?> {
  /// The parameter `ownerUserId` of this provider.
  String get ownerUserId;

  /// The parameter `rotationGroupId` of this provider.
  String get rotationGroupId;
}

class _RotationDetailProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<RotationDetail, RotationGroup?>
    with RotationDetailRef {
  _RotationDetailProviderElement(super.provider);

  @override
  String get ownerUserId => (origin as RotationDetailProvider).ownerUserId;
  @override
  String get rotationGroupId =>
      (origin as RotationDetailProvider).rotationGroupId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
