// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends
        $FunctionalProvider<
          AsyncValue<CurrentUser>,
          CurrentUser,
          FutureOr<CurrentUser>
        >
    with $FutureModifier<CurrentUser>, $FutureProvider<CurrentUser> {
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<CurrentUser> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CurrentUser> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'840e60ea052e6c1d27a210700099a353b2b645b8';
