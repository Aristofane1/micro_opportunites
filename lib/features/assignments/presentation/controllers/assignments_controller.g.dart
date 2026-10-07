// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assignment)
final assignmentProvider = AssignmentFamily._();

final class AssignmentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Assignment>,
          Assignment,
          FutureOr<Assignment>
        >
    with $FutureModifier<Assignment>, $FutureProvider<Assignment> {
  AssignmentProvider._({
    required AssignmentFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'assignmentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assignmentHash();

  @override
  String toString() {
    return r'assignmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Assignment> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Assignment> create(Ref ref) {
    final argument = this.argument as String;
    return assignment(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignmentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assignmentHash() => r'fd8a9a2f3480711ac6de89c438f52bb572cd1b8c';

final class AssignmentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Assignment>, String> {
  AssignmentFamily._()
    : super(
        retry: null,
        name: r'assignmentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AssignmentProvider call(String id) =>
      AssignmentProvider._(argument: id, from: this);

  @override
  String toString() => r'assignmentProvider';
}

/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.

@ProviderFor(AssignmentActions)
final assignmentActionsProvider = AssignmentActionsProvider._();

/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
final class AssignmentActionsProvider
    extends $AsyncNotifierProvider<AssignmentActions, void> {
  /// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
  AssignmentActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assignmentActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assignmentActionsHash();

  @$internal
  @override
  AssignmentActions create() => AssignmentActions();
}

String _$assignmentActionsHash() => r'904827ee10f2a75fea838a8865d1f5d54a9e2fe0';

/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.

abstract class _$AssignmentActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
