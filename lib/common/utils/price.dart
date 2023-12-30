import 'package:intl/intl.dart';

String formatPrice(double price, String locale, String currencyCode) {
  final format =
      NumberFormat.simpleCurrency(locale: locale, name: currencyCode);
  return format.format(price);
}
