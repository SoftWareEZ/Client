import 'package:connect/views/AddAlert.dart';
import 'package:connect/views/AlertPage_manager.dart';
import 'package:connect/views/CommutePage_worker.dart';
import 'package:connect/views/LoginForm.dart';
import 'package:intl/intl.dart';
import 'views/ViewAlert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {

  String urlsrc = "192.168.0.27:8080";
  String url;
  Map<String, String> headers;
  var body;

  var response, statusCode, responseHeaders, responseBody;

  // Server와 연결 - token 가져오기
  // url = "http://${urlsrc}/albba/login";
  // headers = {"Content-Type": "application/json"};
  // body = jsonEncode({"username": "admin", "password": "admin"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseBody = utf8.decode(response.bodyBytes);
  // print("statusCode: ${statusCode}");
  // print("responseBody: ${responseBody}");
  //
  // Map<String, dynamic> json = jsonDecode(responseBody);
  // var token = json["token"];
  // print("token: ${token}");

  // token으로 게시판 정보 post 요청
  // url = "http://${urlsrc}/albba/board/Post";
  // headers =
  // {"Content-Type": "application/json", "authorization": "Bearer ${token}"};
  // body = jsonEncode({"title": "제목", "contents": "내용"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseHeaders = response.headers;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseHeaders: ${responseHeaders}");
  // print("responseBody: ${responseBody}");

  // token으로 게시판 리스트 get 요청
  // url = "http://${urlsrc}/albba/board/List";
  // headers = {"authorization": "Bearer ${token}"};
  // response = await http.get(Uri.parse(url), headers: headers);
  // statusCode = response.statusCode;
  // responseHeaders = response.headers;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseHeaders: ${responseHeaders}");
  // print("responseBody: ${responseBody}");

  // token으로 signup post 요청
  // url = "http://${urlsrc}/albba/signup";
  // headers =
  // {"Content-Type": "application/json"};
  // body = jsonEncode({"username": "newid", "password": "0000", "email": "newEmail@gmail.com", "realname":"유정이"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseHeaders = response.headers;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseHeaders: ${responseHeaders}");
  // print("responseBody: ${responseBody}");
  //
  // url = "http://${urlsrc}/albba/login";
  // headers = {"Content-Type": "application/json"};
  // body = jsonEncode({"username": "newid", "password": "0000"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseHeaders = response.headers;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseHeaders: ${responseHeaders}");
  // print("responseBody: ${responseBody}");
  //
  // Map<String, dynamic> json = jsonDecode(responseBody);
  // var token = json["token"];
  //
  // print("token: ${token}");


  // 출퇴근 - 출근하기
  // String startDate = new DateTime.now().toString();
  // url = "http://${urlsrc}:8080/albba/commute/start";
  // headers =
  // {"Content-Type": "application/json", "authorization": "Bearer ${token}"};
  // body = jsonEncode({"userId": "1", "storeId": "1", "date": "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}", "start": "12:00"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseBody: ${responseBody}");
  //
  // // 출퇴근 - 퇴근하기
  // String endDate = new DateTime.now().toString();
  // url = "http://${urlsrc}/albba/commute/end";
  // headers =
  // {"Content-Type": "application/json", "authorization": "Bearer ${token}"};
  // body = jsonEncode({"userId": "1", "storeId": "1", "date": "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}", "end": "14:00"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseBody: ${responseBody}");
  //
  // // 근무기록
  // url = "http://${urlsrc}/albba/commute/list";
  // headers =
  // {"Content-Type": "application/json", "authorization": "Bearer ${token}"};
  // body = jsonEncode({"userId": "1"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseBody: ${responseBody}");

  // url = "https://kauth.kakao.com/oauth/authorize?client_id=a099ba48b51cee72bb46feaa603ef1a1&redirect_uri=http://localhost:8080/albba/kakao/callback&response_type=code";
  // response = await http.get(Uri.parse(url));
  // responseBody = utf8.decode(response.bodyBytes);
  // print("responseBody: ${responseBody}");


  runApp(AlertPage_manager());
}


