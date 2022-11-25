import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:software_engineering/login/WorkerManager.dart';
// import 'AddWorkSpace.dart';

class MenuBar_manager extends StatefulWidget {
  const MenuBar_manager({Key? key}) : super(key: key);

  @override
  State<MenuBar_manager> createState() => MenuBarstate_manager();
}

class MenuBarstate_manager extends State<MenuBar_manager> {
  final int MAINCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffdcdbdb),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.of(context).pop();},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('사장  ', style: TextStyle(color: Colors.white)),
                    Text('프론트 님',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(MAINCOLOR),
            ),
          ),
          Container(
            height: 130,
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('  나의 사업장'),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Color(0xffE94869),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       // builder: (context) => const AddWorkSpacePage()),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
                Container(height: 2.0, width: 500.0, color: Color(0xffdcdbdb),),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "파스쿠찌",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "레프트뱅크",
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Text(
                                  "초대코드 보내기",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(MAINCOLOR), width: 3),
                                ),
                                child: Text("LeftBank",style: TextStyle(fontWeight: FontWeight.w500),),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(MAINCOLOR),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          /*
                          이 시점에 사장한테 입사요청
                          */
                                        },
                                        child: Text(
                                          "닫기",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('초대코드 보내기'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const WorkerManager()),
              // );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('로그아웃', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuBar_worker extends StatefulWidget {
  const MenuBar_worker({Key? key}) : super(key: key);

  @override
  State<MenuBar_worker> createState() => MenuBarstate_worker();
}

class MenuBarstate_worker extends State<MenuBar_worker> {
  final int MAINCOLOR = 0xffE94869;

  String token = "",
      urlsrc = "",
      userId="";
  String code="";

  _fetchCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getString('userId') ?? "null");

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId);
    print("code: " + code);

    String url = "http://albba/worker/join/${userId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST",
      "Access-Control-Allow-Headers": "X-Requested-With",
      'Accept': '*/*'
    };
    var body = jsonEncode({"code" : code});

    var response = await http.post(Uri.parse(url), headers: headers, body:body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "성공");
    } else {
      Fluttertoast.showToast(msg: "실패");
    }

  }

  @override
  void initState() {
    super.initState();
    _fetchCode();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffdcdbdb),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('알바생  ', style: TextStyle(color: Colors.white)),
                    Text('문예주 님',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffE94869),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('  워크 플레이스'),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Color(0xffE94869),
                        onPressed:(){
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                            child: Text(
                                              "초대코드 입력하기",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          TextFormField(
                                            onChanged: (text) {
                                              setState(() {
                                                code = text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                color: Color(MAINCOLOR),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Color(MAINCOLOR),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                    onPressed: () {
                                                      _fetchCode();
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      "입사요청",
                                                      style: TextStyle(color: Colors.white),
                                                    )),
                                              ),
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Color(MAINCOLOR),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      "닫기",
                                                      style: TextStyle(color: Colors.white),
                                                    )),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              });
                        },
                      ),
                    ],
                  ),
                ),
                Container(height: 2.0, width: 500.0, color: Color(0xffdcdbdb),),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "파스쿠찌",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "레프트뱅크",
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const WorkerManager()),
              // );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('로그아웃', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}