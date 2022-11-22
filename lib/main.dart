import 'package:connect/views/AddAlert.dart';
import 'package:connect/views/AlertPage_manager.dart';
import 'package:connect/views/LoginForm.dart';
import 'views/ViewAlert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {

  // String url;
  // Map<String, String> headers;
  // var body;
  //
  // var response, statusCode, responseHeaders, responseBody;

  // Server와 연결
  // url = "http://172.20.10.5:8080/albba/login";
  // headers = {"Content-Type": "application/json"};
  // body = jsonEncode({"username": "admin", "password": "admin"});
  // response = await http.post(Uri.parse(url), headers: headers, body: body);
  // statusCode = response.statusCode;
  // responseHeaders = response.headers;
  // responseBody = utf8.decode(response.bodyBytes);
  //
  // print("statusCode: ${statusCode}");
  // print("responseHeaders: ${responseHeaders}");
  // print("responseBody: ${responseBody}");

  // json에서 token 분리
  // Map<String, dynamic> json = jsonDecode(responseBody);
  // var token = json["token"];
  //
  // print("token: ${token}");

  // token으로 게시판 정보 post 요청
  // url = "http://172.20.10.5:8080/albba/board/Post";
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
  // url = "http://172.20.10.5:8080/albba/board/List";
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
  // url = "http://172.20.10.5:8080/albba/signup";
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
  // url = "http://172.20.10.5:8080/albba/login";
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

  runApp(AlertPage_manager());
}


