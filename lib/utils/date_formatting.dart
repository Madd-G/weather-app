import 'package:intl/intl.dart';

String formatDate(String inputDateTime, String outputFormatString) {
  final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final outputFormat = DateFormat(outputFormatString, 'id');

  final dateTime = inputFormat.parse(inputDateTime);
  final dateString = outputFormat.format(dateTime);
  return dateString;
}

