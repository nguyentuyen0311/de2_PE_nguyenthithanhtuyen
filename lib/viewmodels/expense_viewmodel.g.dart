

part of 'expense_viewmodel.dart';

// RiverpodGenerator

String _$expenseViewModelHash() => r'26915b80ee9fb3d376eb1ee2787d6e4659b91bb6';

/// See also [ExpenseViewModel].
@ProviderFor(ExpenseViewModel)
final expenseViewModelProvider =
    AutoDisposeAsyncNotifierProvider<ExpenseViewModel, List<Expense>>.internal(
  ExpenseViewModel.new,
  name: r'expenseViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseViewModel = AutoDisposeAsyncNotifier<List<Expense>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_do_not_submit_accept_sparse_doc_comments
