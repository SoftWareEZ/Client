import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//import '../alert/AlertPage_worker.dart';
//import '../bar/Bottombar.dart';
//import '../bar/Menubar.dart';

// 알바용 마이페이지 - 근무기록
class MyPageWork_worker extends StatefulWidget {
  const MyPageWork_worker({Key? key}) : super(key: key);

  @override
  State<MyPageWork_worker> createState() => _MyPageWork_worker();
}

class _MyPageWork_worker extends State<MyPageWork_worker> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  List<WorkMonthInfo> monthList = [];
  List<WorkInfo> infoList = [];
  String token = "", urlsrc = "";
  int userId = 0, month = 0;

  _fetchMonth() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());

    // userId를 바탕으로 2022년 달 요청
    String url = "http://${urlsrc}/albba/commute/list/${userId}/2022";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        monthList =
            body.map((dynamic item) => WorkMonthInfo.fromJson(item)).toList();
      });
    } else {
      // 요청 실패
    }
  }

  _fetchInfo(int selectedMonth) async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());

    print("selectedMonth: " + selectedMonth.toString());

    // userId를 바탕으로 2022년 해당 달의 정보 요청
    String url = "http://${urlsrc}/albba/commute/list/${userId}/2022/${selectedMonth}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        infoList = body.map((dynamic item) => WorkInfo.fromJson(item)).toList();
      });
    } else {
      // 요청 실패
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMonth();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('근무 기록',
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AlertPage_manager()),
                // );
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                children: [
                  Text(
                    "2022년",
                    style: TextStyle(
                      color: Color(MAINCOLOR),
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      _fetchMonth();
                      //_fetchInfo를 해줘야 할까..?
                    },
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    for (int i = 0; i < monthList.length; i++)
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                          children: [
                            Text(monthList[i].month.toString()),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: (){
                                setState((){
                                  _fetchInfo(monthList[i].month);
                                  for (int j = 0; j < infoList.length; j++)
                                    Text(infoList[j].info);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              ],
            )
          ],
        ),
        // bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

class WorkMonthInfo {
  // 근무일정 클래스
  int month = 0; // 달 받아오기

  WorkMonthInfo(int month) {
    this.month = month;
  }

  WorkMonthInfo.fromJson(Map<String, dynamic> json) {
    month = json["month"];

    Map toJson() {
      return {'month': month};
    }
  }
}

class WorkInfo {
  // 근무일정 클래스
  String info = ""; // 달을 누르면 나오는 근무기록
  WorkInfo(String info) {
    this.info = info;
  }

  WorkInfo.fromJson(Map<String, dynamic> json) {
    info = json["info"];

    Map toJson() {
      return {'info': info};
    }
  }
}