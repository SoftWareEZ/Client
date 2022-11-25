import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/worker/CalendarPage_worker.dart';

FocusNode myFocusNode = new FocusNode();

//로그인
class Loginpage extends StatefulWidget {
  final String person;
  Loginpage(this.person, {Key? key}) : super(key: key);
  @override
  State<Loginpage> createState() => Login(person);
}

class Login extends State<Loginpage>{
  final String person;
  Login(this.person);
  // TextEditingController inputController = TextEditingController();
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  String token = "", urlsrc = "192.168.0.70:8080";
  String id = "", password = "";

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
      prefs.setString("urlsrc", urlsrc); // 이때, urlsrc도 저장해두었다.

      // userinfo 저장
      _getUserInfo();

      // 화면전환
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CalendarPage_worker()));
    } else {
      // 로그인 실패
      Fluttertoast.showToast(msg: "로그인 실패");
    }
  }

  _getUserInfo() async {
    // 생성된 token 정보로 userinfo 요청
    // 전달된 내용 중 username, storeId만 디바이스 디스크에 저장한다.
    String url = "http://${urlsrc}/albba/userinfo";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if(response.statusCode == 200) {
      // userinfo 가져오기 성공
      Map<String, dynamic> json = jsonDecode(responseBody);
      String userId = json["username"];
      int storeId = json["storeId"];

      // 받은 token 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", userId);
      prefs.setInt("storeId", storeId);
    } else {
      // userinfo 가져오기 실패
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('알빠',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(MAINCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("닫기",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      id= text;
                    });
                  },
                  // controller: inputController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(MAINCOLOR),
                    ),
                    labelText: "아이디를 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                    hintText: 'id',
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                TextFormField(
                  obscureText: true, // 비밀번호를 적을때 안보이도록
                  onChanged: (text) {
                    setState(() {
                      password= text;
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
                Text(person+id+password),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
