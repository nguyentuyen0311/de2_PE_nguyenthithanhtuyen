import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../viewmodels/expense_viewmodel.dart';
import '../viewmodels/currency_viewmodel.dart';
import 'currency_dialog.dart';
import 'expense_edit_view.dart';

class ExpenseListView extends ConsumerWidget {
  const ExpenseListView({super.key});

  void _showCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CurrencyDialog(),
    );
  }

  void _navigateToEdit(BuildContext context, Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseEditView(expense: expense),
      ),
    );
  }

  String _formatAmount(double amount, String currency) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return '${formatter.format(amount.toInt())} $currency';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expenseViewModelProvider);
    final currencyAsync = ref.watch(currencyViewModelProvider);

    final currency = currencyAsync.value ?? 'VND';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý chi tiêu'),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showCurrencyDialog(context),
          ),
        ],
      ),
      body: expensesAsync.when(
        data: (expenses) {
          if (expenses.isEmpty) {
            return const Center(child: Text('Không có khoản chi nào'));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expense.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              expense.category,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            expense.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatAmount(expense.amount, currency),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 8),


                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        color: Colors.black87,
                        onPressed: () => _navigateToEdit(context, expense),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi: $err')),
      ),
    );
  }
}
