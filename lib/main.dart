import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:software_engineering/AlbaMenubar.dart';
import 'login/AlbaPresident.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const AlbaPresident()));
}