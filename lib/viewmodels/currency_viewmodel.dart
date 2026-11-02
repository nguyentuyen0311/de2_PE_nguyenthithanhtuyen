import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'currency_viewmodel.g.dart';

@riverpod
class CurrencyViewModel extends _$CurrencyViewModel {
  static const String _key = 'selected_currency';

  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'VND';
  }

  Future<void> setCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, currency);
    state = AsyncValue.data(currency);
  }
}
