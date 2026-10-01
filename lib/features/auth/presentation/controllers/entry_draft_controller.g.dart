// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_draft_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EntryDraftController)
final entryDraftControllerProvider = EntryDraftControllerProvider._();

final class EntryDraftControllerProvider
    extends $NotifierProvider<EntryDraftController, EntryDraft> {
  EntryDraftControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entryDraftControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entryDraftControllerHash();

  @$internal
  @override
  EntryDraftController create() => EntryDraftController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntryDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntryDraft>(value),
    );
  }
}

String _$entryDraftControllerHash() =>
    r'5ada889029897147d344755a63e74fd0790e930b';

abstract class _$EntryDraftController extends $Notifier<EntryDraft> {
  EntryDraft build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EntryDraft, EntryDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EntryDraft, EntryDraft>,
              EntryDraft,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
