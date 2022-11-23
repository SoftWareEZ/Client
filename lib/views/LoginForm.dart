import 'package:connect/views/ViewAlert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  String token = "", urlsrc = "192.168.0.27:8080";
  String id = "", password = "";

  _getUserInfo() async {
    // 입력된 로그인 정보로 token 요청
    String url = "http://${urlsrc}/albba/userinfo";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if(response.statusCode == 200) {
      // userinfo 가져오기 성공
      Map<String, dynamic> json = jsonDecode(responseBody);
      String username = json["username"];
      int storeId = json["storeId"];

      // 받은 token 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("username", username);
      prefs.setInt("storeId", storeId);
    } else {
      // userinfo 가져오기 실패
    }
  }

  _getToken() async {
    // 입력된 로그인 정보로 token 요청
    String url = "http://${urlsrc}/albba/login";
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode({"username": id, "password": password});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 로그인 성공
      Map<String, dynamic> json = jsonDecode(responseBody);
      token = json["token"];
      print("token: ${token}");
      Fluttertoast.showToast(msg: "로그인 성공");

      // 받은 token 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token);
      prefs.setString("urlsrc", urlsrc);

      // userinfo 저장
      _getUserInfo();

      // 화면전환
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ViewAlert()));
    } else {
      // 로그인 실패
      Fluttertoast.showToast(msg: "로그인 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      id = text;
                    });
                  },
                  // controller: inputController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(MAINCOLOR),
                    ),
                    labelText: "이메일아이디를 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                    hintText: 'EX) abcd@naver.com',
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                TextFormField(
                  obscureText: true, // 비밀번호를 적을때 안보이도록
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color(MAINCOLOR),
                      ),
                      labelText: "비밀번호를 입력해주세요",
                      labelStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(MAINCOLOR)),
                      ),
                      hintText: 'password'),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            //모서리를 둥글게
                            borderRadius: BorderRadius.circular(5)),
                        primary: Color(MAINCOLOR),
                        minimumSize: Size(70, 50),
                        //width, height
                        alignment: Alignment.center,
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: _getToken,
                    child: Text('로그인'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
