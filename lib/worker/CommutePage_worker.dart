import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '/alert/AlertPage_worker.dart';
import '/bar/Bottombar.dart';

// 알바용 - 출퇴근
class CommuteState_worker extends StatefulWidget {
  CommuteState_worker({Key? key}) : super(key: key);

  @override
  State<CommuteState_worker> createState() => CommutePage_worker();
}

class CommutePage_worker extends State<CommuteState_worker> {
  final int SUBCOLOR = 0xffF4F4F4;
  final int MAINCOLOR = 0xffE94869;
  String token = "", urlsrc = "";
  int userId = 0, storeId = 0;
  String commute = '출근';

  _fetchCommuteStart() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());
    print("storeId: " + storeId.toString());

    // 출근하기
    DateTime startDate = new DateTime.now();
    String url = "http://${urlsrc}/albba/commute/start";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };

    print("year: " + DateFormat('yyyy').format(startDate));
    print("month: " + DateFormat('MM').format(startDate));
    print("day: " + DateFormat('dd').format(startDate));
    print("start: " + DateFormat.Hm().format(startDate));

    var body = jsonEncode({
      "userId": userId,
      "storeId": storeId,
      "year": DateFormat('yyyy').format(startDate),
      "month": DateFormat('MM').format(startDate),
      "day": DateFormat('dd').format(startDate),
      "start": DateFormat.Hm().format(startDate)
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: ${responseBody}");

    if (response.statusCode == 200) {
      // 출근 성공
      showCommuteResult();
    } else {
      // 출근 실패
      Fluttertoast.showToast(
          msg: "출근 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  _fetchCommuteEnd() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());
    print("storeId: " + storeId.toString());

    // 출근하기
    DateTime endDate = new DateTime.now();
    String url = "http://${urlsrc}/albba/commute/end";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body = jsonEncode({
      "userId": userId,
      "storeId": storeId,
      "year": DateFormat('yyyy').format(endDate),
      "month": DateFormat('MM').format(endDate),
      "day": DateFormat('dd').format(endDate),
      "end": DateFormat.Hm().format(endDate)
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: ${responseBody}");

    if (response.statusCode == 200) {
      // 퇴근 성공
      showCommuteResult();
    } else {
      // 퇴근 실패
      Fluttertoast.showToast(
          msg: "퇴근 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  showCommuteResult() {
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
                    commute + " 성공 !",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(MAINCOLOR),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (commute == '출근') {
                            commute = '퇴근';
                          } else {
                            commute = '출근';
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "닫기",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_worker(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알빠',
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
                      builder: (context) => const AlertPage_worker()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("근무지 근방 100m 내에서\n출근 버튼을 누르면\n정상적으로 출근처리를 합니다.",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(MAINCOLOR),
                          fixedSize: const Size(130, 130),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            print(commute);
                            if (commute == '출근') {
                              print("start commute");
                              _fetchCommuteStart();
                            } else if (commute == '퇴근') {
                              print("end commute");
                              _fetchCommuteEnd();
                            }
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 40),
                            Text(
                              commute,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}
