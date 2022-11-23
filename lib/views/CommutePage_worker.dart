import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '/bar/Menubar.dart';
// import '/alert/AlertPage_worker.dart';
// import '/bar/Bottombar.dart';

// 알바용 - 출퇴근
class CommuteState_worker extends StatefulWidget {
  CommuteState_worker({Key? key}) : super(key: key);

  @override
  State<CommuteState_worker> createState() => CommutePage_worker();
}

class CommutePage_worker extends State<CommuteState_worker> {
  final int SUBCOLOR = 0xffF4F4F4;
  final int MAINCOLOR = 0xffE94869;
  String commute = '출근';
  String token = "", urlsrc = "165.229.229.104:8080";
  String id = "", password = "";

  _getToken() async {
    if(commute=='출근') {
      // 입력된 로그인 정보로 token 요청
      String startDate = new DateTime.now().toString();
      String url = "http://${urlsrc}:8080/albba/commute/start";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer ${token}"
      };
      var body = jsonEncode({
        "userId": "1",
        "storeId": "1",
        "date": "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}",
        "start": "12:00"
      });
      var response =
      await http.post(Uri.parse(url), headers: headers, body: body);
      var statusCode = response.statusCode;
      var responseBody = utf8.decode(response.bodyBytes);
      print("statusCode: ${statusCode}");
      print("responseBody: ${responseBody}");

      if (response.statusCode == 200) {
        // 출근 성공
        Map<String, dynamic> json = jsonDecode(responseBody);
        token = json["token"];
        print("token: ${token}");
        Fluttertoast.showToast(msg: "출근 성공");

        // 받은 token 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
        prefs.setString("urlsrc", urlsrc);

        // commuteinfo 저장
        // _getCommuteInfo();

        // 화면전환
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ViewAlert()));
      } else {
        // 출근 실패
        Fluttertoast.showToast(msg: "출근 실패");
      }
    }else if (commute=='퇴근'){
      String endDate = new DateTime.now().toString();
      String url = "http://${urlsrc}:8080/albba/commute/end";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer ${token}"
      };
      var body = jsonEncode({
        "userId": "1",
        "storeId": "1",
        "date": "${DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate))}",
        "end": "14:00"
      });
      var response =
      await http.post(Uri.parse(url), headers: headers, body: body);
      var statusCode = response.statusCode;
      var responseBody = utf8.decode(response.bodyBytes);
      print("statusCode: ${statusCode}");
      print("responseBody: ${responseBody}");

      if (response.statusCode == 200) {
        // 퇴근 성공
        Map<String, dynamic> json = jsonDecode(responseBody);
        token = json["token"];
        print("token: ${token}");
        Fluttertoast.showToast(msg: "퇴근 성공");

        // 받은 token 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
        prefs.setString("urlsrc", urlsrc);

        // commuteinfo 저장
        // _getCommuteInfo();

        // 화면전환
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ViewAlert()));
      } else {
        // 퇴근 실패
        Fluttertoast.showToast(msg: "퇴근 실패");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // drawer: MenuBar_worker(),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AlertPage_worker()),
                // );
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
                          //backgroundColor: Color(MAINCOLOR),
                          fixedSize: const Size(130, 130),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          // alignment: BorderRadius.all(Radius.circular(10)),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: Text(
                                          commute + " 성공 !",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Color(MAINCOLOR),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                              _getToken();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "닫기",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
        // bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}
