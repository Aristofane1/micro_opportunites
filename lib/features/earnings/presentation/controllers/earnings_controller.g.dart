// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earningsSummary)
final earningsSummaryProvider = EarningsSummaryProvider._();

final class EarningsSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarningsSummary>,
          EarningsSummary,
          FutureOr<EarningsSummary>
        >
    with $FutureModifier<EarningsSummary>, $FutureProvider<EarningsSummary> {
  EarningsSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earningsSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earningsSummaryHash();

  @$internal
  @override
  $FutureProviderElement<EarningsSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarningsSummary> create(Ref ref) {
    return earningsSummary(ref);
  }
}

String _$earningsSummaryHash() => r'458a896cce697498854b14deb19b00a54cb29c30';

@ProviderFor(payout)
final payoutProvider = PayoutFamily._();

final class PayoutProvider
    extends $FunctionalProvider<AsyncValue<Payout>, Payout, FutureOr<Payout>>
    with $FutureModifier<Payout>, $FutureProvider<Payout> {
  PayoutProvider._({
    required PayoutFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'payoutProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$payoutHash();

  @override
  String toString() {
    return r'payoutProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Payout> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Payout> create(Ref ref) {
    final argument = this.argument as String;
    return payout(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PayoutProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$payoutHash() => r'f78630c6a3140052f5f03f0b52d9ea6902af156a';

final class PayoutFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Payout>, String> {
  PayoutFamily._()
    : super(
        retry: null,
        name: r'payoutProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PayoutProvider call(String id) => PayoutProvider._(argument: id, from: this);

  @override
  String toString() => r'payoutProvider';
}
