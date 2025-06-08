// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthHash() => r'912368c3df3f72e4295bf7a8cda93b9c5749d923';

/// See also [firebaseAuth].
@ProviderFor(firebaseAuth)
final firebaseAuthProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  firebaseAuth,
  name: r'firebaseAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firebaseAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseAuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$firebaseAuthDataSourceHash() =>
    r'889b9be1ec148b8ad5a262dd58a5dc159095cf53';

/// See also [firebaseAuthDataSource].
@ProviderFor(firebaseAuthDataSource)
final firebaseAuthDataSourceProvider =
    AutoDisposeProvider<FirebaseAuthDataSource>.internal(
      firebaseAuthDataSource,
      name: r'firebaseAuthDataSourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$firebaseAuthDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseAuthDataSourceRef =
    AutoDisposeProviderRef<FirebaseAuthDataSource>;
String _$authRepositoryHash() => r'0106c7ee292ac5f8522c2f734da117edeb06a404';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'21588219b6116bc68eb8c3facdf887075c745c4c';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider =
    AutoDisposeStreamProvider<Result<AppUser?>>.internal(
      authStateChanges,
      name: r'authStateChangesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$authStateChangesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<Result<AppUser?>>;
String _$emailSignInValidatorHash() =>
    r'905909050a797c9a00b5bd3451a481d9c31ea7eb';

/// See also [emailSignInValidator].
@ProviderFor(emailSignInValidator)
final emailSignInValidatorProvider =
    AutoDisposeProvider<EmailSignInValidator>.internal(
      emailSignInValidator,
      name: r'emailSignInValidatorProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$emailSignInValidatorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmailSignInValidatorRef = AutoDisposeProviderRef<EmailSignInValidator>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
