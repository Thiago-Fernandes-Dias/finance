import 'package:intl/intl.dart';

extension NumExtension on num {
  String toUTCFormat() {
    final number = this is double ? this : toDouble();
    final oCcy = NumberFormat('#,##0.00');
    return '\$${oCcy.format(number)}';
  }
}
