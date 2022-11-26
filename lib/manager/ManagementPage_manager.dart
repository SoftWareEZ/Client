import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/alert/AlertPage_manager.dart';
import '/manager/ManagementUpdatePage_manager.dart';
import '/bar/Menubar.dart';
import '/bar/Bottombar.dart';

// 사장용 알바생 관리
class ManagementPage_manager extends StatelessWidget {
  const ManagementPage_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알바생 관리',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              color: Color(MAINCOLOR),
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AlertPage_manager()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [Management_manager()],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}

class Management_manager extends StatefulWidget {
  const Management_manager({Key? key}) : super(key: key);

  @override
  State<Management_manager> createState() => _ManagementState();
}

class _ManagementState extends State<Management_manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  var f = NumberFormat('00');

  // 근무기록 월 데이터
  String year = DateFormat('yyyy').format(DateTime.now()),
      month = DateFormat('MM').format(DateTime.now());

  // 알바생 정보 데이터
  List<StaffInfo> _staffList = [];
  String token = "", urlsrc = "";
  int userId = 0, storeId = 0;
  String salary = "";

  _fetchCalendarList() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    // 월별 근무시간 post 요청
    String url = "http://${urlsrc}/albba/commute/${storeId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body = jsonEncode({"year": year, "month": month});
    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        var _staffList =
            body.map((dynamic item) => StaffInfo.fromJson(item)).toList();
      });
    } else {
      // 요청 실패
    }
  }

  showSendMoney() {
    showDialog(
        context: context,
        barrierDismissible: false, // 창 밖을 터치해도 창이 닫히지 않게
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "송금하시겠습니까?",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
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
                            onPressed: () {},
                            child: Text(
                              "예",
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
                              "아니오",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: year),
                    onChanged: (text) {
                      setState(() {
                        year = text;
                      });
                    },
                    // controller: inputController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.edit_calendar,
                        color: Color(MAINCOLOR),
                      ),
                      labelText: "년도",
                      labelStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(MAINCOLOR)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(text: month),
                    onChanged: (text) {
                      setState(() {
                        month = text;
                      });
                    },
                    // controller: inputController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(MAINCOLOR),
                      ),
                      labelText: "월",
                      labelStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(MAINCOLOR)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(MAINCOLOR),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // 조회
                    },
                    child: Text("조회",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey),
            Stack(
              children: [
                Column(
                  children: [
                    for (int i = 0; i < _staffList.length; i++)
                      infoBox(
                        _staffList[i].userId,
                        _staffList[i].username,
                        _staffList[i].time,
                      )
                  ],
                ),
              ],
            )
          ]),
    );
  }

  Widget infoBox(int userId, String username, int time) {
    return Row(
      children: [
        Expanded(
          child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: Color(SUBCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // background 속성이 없다.
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          // 테두리를 라운드하게 만들기
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 0.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ManagementUpdatePage_manager()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(MAINCOLOR),
                          size: 30,
                        ),
                        Text(
                          username,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          f.format(time/60) + '시간 ' + f.format(time%60) + '분',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            //fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ))),
        ),
        IconButton(
            onPressed: () {
              showSendMoney();
            },
            icon: Icon(Icons.send, color: Color(MAINCOLOR)))
      ],
    );
  }
}

class StaffInfo {
  int userId = 0;
  String username = "";
  int time = 0;

  StaffInfo(int userId, String username, int time) {
    this.userId = userId;
    this.username = username;
    this.time = time;
  }

  StaffInfo.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    username = json["username"];
    time = json["time"];

    Map toJson() {
      return {'userId': userId, 'username': username, 'time': time};
    }
  }
}
