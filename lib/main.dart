import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'login/WorkerManager.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {



  initializeDateFormatting().then((_) => runApp(const WorkerManager()));
}