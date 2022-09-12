import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'AlbaPresident.dart';
import 'StaffSchedulePage.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const AlbaPresident()));

}