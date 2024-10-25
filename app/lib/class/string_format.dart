import 'package:intl/intl.dart';

class StringFormat {
  static String ConvertMoneyToString(double value) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    String formattedAmount = formatter.format(value);
    return '$formattedAmountđ';
  }
}
