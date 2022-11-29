import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'login/WorkerManager.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  KakaoSdk.init(nativeAppKey: '1872cc5931815a7a61eb2954c9196b83');
  initializeDateFormatting().then((_) => runApp(const WorkerManager()));
}