// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$packageInfoHash() => r'e85c18fc1df698cf58e72da2ff3d20b5e68db434';

/// See also [packageInfo].
@ProviderFor(packageInfo)
final packageInfoProvider = AutoDisposeFutureProvider<PackageInfo>.internal(
  packageInfo,
  name: r'packageInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$packageInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PackageInfoRef = AutoDisposeFutureProviderRef<PackageInfo>;
String _$loggerHash() => r'ac8b78048e5ee9879c300e3d26c2956cc7ead3f0';

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

/// See also [logger].
@ProviderFor(logger)
const loggerProvider = LoggerFamily();

/// See also [logger].
class LoggerFamily extends Family<Logger> {
  /// See also [logger].
  const LoggerFamily();

  /// See also [logger].
  LoggerProvider call(String loggerName) {
    return LoggerProvider(loggerName);
  }

  @override
  LoggerProvider getProviderOverride(covariant LoggerProvider provider) {
    return call(provider.loggerName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loggerProvider';
}

/// See also [logger].
class LoggerProvider extends AutoDisposeProvider<Logger> {
  /// See also [logger].
  LoggerProvider(String loggerName)
    : this._internal(
        (ref) => logger(ref as LoggerRef, loggerName),
        from: loggerProvider,
        name: r'loggerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product') ? null : _$loggerHash,
        dependencies: LoggerFamily._dependencies,
        allTransitiveDependencies: LoggerFamily._allTransitiveDependencies,
        loggerName: loggerName,
      );

  LoggerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.loggerName,
  }) : super.internal();

  final String loggerName;

  @override
  Override overrideWith(Logger Function(LoggerRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: LoggerProvider._internal(
        (ref) => create(ref as LoggerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        loggerName: loggerName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Logger> createElement() {
    return _LoggerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoggerProvider && other.loggerName == loggerName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, loggerName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoggerRef on AutoDisposeProviderRef<Logger> {
  /// The parameter `loggerName` of this provider.
  String get loggerName;
}

class _LoggerProviderElement extends AutoDisposeProviderElement<Logger>
    with LoggerRef {
  _LoggerProviderElement(super.provider);

  @override
  String get loggerName => (origin as LoggerProvider).loggerName;
}

String _$nowHash() => r'd0548a55e44770fcec7c89ea89cf65cc56e8b96e';

/// See also [now].
@ProviderFor(now)
final nowProvider = AutoDisposeProvider<DateTime>.internal(
  now,
  name: r'nowProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nowHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NowRef = AutoDisposeProviderRef<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
