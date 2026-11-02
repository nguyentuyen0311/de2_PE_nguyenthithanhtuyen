import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/expense.dart';
import '../data/database_helper.dart';

part 'expense_viewmodel.g.dart';

@riverpod
class ExpenseViewModel extends _$ExpenseViewModel {
  @override
  Future<List<Expense>> build() async {
    return await DatabaseHelper.instance.getExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await DatabaseHelper.instance.updateExpense(expense);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await DatabaseHelper.instance.getExpenses());
  }
}
