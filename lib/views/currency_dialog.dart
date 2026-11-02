import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/currency_viewmodel.dart';

class CurrencyDialog extends ConsumerStatefulWidget {
  const CurrencyDialog({super.key});

  @override
  ConsumerState<CurrencyDialog> createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends ConsumerState<CurrencyDialog> {
  String _selectedCurrency = 'VND';

  @override
  void initState() {
    super.initState();
    final currencyAsync = ref.read(currencyViewModelProvider);
    currencyAsync.whenData((currency) {
      setState(() {
        _selectedCurrency = currency;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Đơn vị tiền tệ',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: RadioGroup<String>(
        groupValue: _selectedCurrency,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedCurrency = value;
            });
          }
        },
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text('VND (Việt Nam Đồng)'),
              value: 'VND',
            ),
            RadioListTile<String>(
              title: Text('USD (Đô la Mỹ)'),
              value: 'USD',
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Hủy',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          ),
          onPressed: () async {
            await ref
                .read(currencyViewModelProvider.notifier)
                .setCurrency(_selectedCurrency);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
