// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myApplications)
final myApplicationsProvider = MyApplicationsProvider._();

final class MyApplicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Application>>,
          List<Application>,
          FutureOr<List<Application>>
        >
    with
        $FutureModifier<List<Application>>,
        $FutureProvider<List<Application>> {
  MyApplicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myApplicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myApplicationsHash();

  @$internal
  @override
  $FutureProviderElement<List<Application>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Application>> create(Ref ref) {
    return myApplications(ref);
  }
}

String _$myApplicationsHash() => r'8132ca1d220d6d667bb1e067ae372c6ef5a63e09';

@ProviderFor(applicationDetail)
final applicationDetailProvider = ApplicationDetailFamily._();

final class ApplicationDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Application>,
          Application,
          FutureOr<Application>
        >
    with $FutureModifier<Application>, $FutureProvider<Application> {
  ApplicationDetailProvider._({
    required ApplicationDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'applicationDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$applicationDetailHash();

  @override
  String toString() {
    return r'applicationDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Application> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Application> create(Ref ref) {
    final argument = this.argument as String;
    return applicationDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplicationDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$applicationDetailHash() => r'57fd5764db5e0c20493240b88065b33c27a287f7';

final class ApplicationDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Application>, String> {
  ApplicationDetailFamily._()
    : super(
        retry: null,
        name: r'applicationDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ApplicationDetailProvider call(String id) =>
      ApplicationDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'applicationDetailProvider';
}

@ProviderFor(applyTarget)
final applyTargetProvider = ApplyTargetFamily._();

final class ApplyTargetProvider
    extends
        $FunctionalProvider<
          AsyncValue<ApplyTarget>,
          ApplyTarget,
          FutureOr<ApplyTarget>
        >
    with $FutureModifier<ApplyTarget>, $FutureProvider<ApplyTarget> {
  ApplyTargetProvider._({
    required ApplyTargetFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'applyTargetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$applyTargetHash();

  @override
  String toString() {
    return r'applyTargetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ApplyTarget> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ApplyTarget> create(Ref ref) {
    final argument = this.argument as String;
    return applyTarget(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplyTargetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$applyTargetHash() => r'9b1c5e77800ad04c19055e4854e4c3525493f27c';

final class ApplyTargetFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ApplyTarget>, String> {
  ApplyTargetFamily._()
    : super(
        retry: null,
        name: r'applyTargetProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ApplyTargetProvider call(String missionId) =>
      ApplyTargetProvider._(argument: missionId, from: this);

  @override
  String toString() => r'applyTargetProvider';
}

/// Actions d'écriture. L'état indique si une action est en cours (bouton
/// en chargement) ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.

@ProviderFor(ApplicationActions)
final applicationActionsProvider = ApplicationActionsProvider._();

/// Actions d'écriture. L'état indique si une action est en cours (bouton
/// en chargement) ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
final class ApplicationActionsProvider
    extends $AsyncNotifierProvider<ApplicationActions, void> {
  /// Actions d'écriture. L'état indique si une action est en cours (bouton
  /// en chargement) ; chaque succès incrémente `dataRevisionProvider`.
  /// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
  ApplicationActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationActionsHash();

  @$internal
  @override
  ApplicationActions create() => ApplicationActions();
}

String _$applicationActionsHash() =>
    r'53cc20d67350769c8fb83df1e0dddde87431d0c2';

/// Actions d'écriture. L'état indique si une action est en cours (bouton
/// en chargement) ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.

abstract class _$ApplicationActions extends $AsyncNotifier<void> {
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
