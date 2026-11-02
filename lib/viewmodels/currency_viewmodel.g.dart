

part of 'currency_viewmodel.dart';

// RiverpodGenerator

String _$currencyViewModelHash() => r'fa0d5a36371cfbe13c68e1465dd8eef2f205a2e9';

/// See also [CurrencyViewModel].
@ProviderFor(CurrencyViewModel)
final currencyViewModelProvider =
    AutoDisposeAsyncNotifierProvider<CurrencyViewModel, String>.internal(
  CurrencyViewModel.new,
  name: r'currencyViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currencyViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrencyViewModel = AutoDisposeAsyncNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_do_not_submit_accept_sparse_doc_comments
