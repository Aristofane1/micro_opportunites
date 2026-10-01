// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignments_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assignmentsRepository)
final assignmentsRepositoryProvider = AssignmentsRepositoryProvider._();

final class AssignmentsRepositoryProvider
    extends
        $FunctionalProvider<
          AssignmentsRepository,
          AssignmentsRepository,
          AssignmentsRepository
        >
    with $Provider<AssignmentsRepository> {
  AssignmentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assignmentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assignmentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssignmentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssignmentsRepository create(Ref ref) {
    return assignmentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssignmentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssignmentsRepository>(value),
    );
  }
}

String _$assignmentsRepositoryHash() =>
    r'd0062b7db87d010be410b2d4e11f82dbb485a805';
