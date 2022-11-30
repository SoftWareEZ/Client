import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/bar/Menubar.dart';
import '../alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';

// 알바용  - 입퇴사 관리

class PersonnelManagement_manager extends StatefulWidget {
  const PersonnelManagement_manager({Key? key}) : super(key: key);

  @override
  State<PersonnelManagement_manager> createState() => _PersonnelManagement_managerState();
}

class _PersonnelManagement_managerState extends State<PersonnelManagement_manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  String token = "", urlsrc = "";
  int storeId = 0;

  List<RequestInfo> _requestList = [];

  _fetchRequestList() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    // 입퇴사 요청자 조회
    String url = "http://${urlsrc}/albba/store/${storeId}/checkIn";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      if(!responseBody.toString().isEmpty){
        setState(() {
          List<dynamic> body = json.decode(responseBody);
          _requestList =
              body.map((dynamic item) => RequestInfo.fromJson(item)).toList();
        });
      }
    } else {
      // 요청 실패
    }
  }

  _fetchJoin(int userId) async {
    // 입사요청 수락
    String url = "http://${urlsrc}/albba/store/${storeId}/join/${userId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      Fluttertoast.showToast(
          msg: "입사요청 수락 성공",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      // 요청 실패
      Fluttertoast.showToast(
          msg: "입사요청 수락 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  _fetchRejectJoin(int userId) async {
    // 입사요청 거절
    String url = "http://${urlsrc}/albba/store/${storeId}/rejectJoin/${userId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      Fluttertoast.showToast(
          msg: "입사요청 거절 성공",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      // 요청 실패
      Fluttertoast.showToast(
          msg: "입사요청 거절 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  _fetchLeave(int userId) async {
    // 퇴사요청 수락
    String url = "http://${urlsrc}/albba/store/${storeId}/leave/${userId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      Fluttertoast.showToast(
          msg: "퇴사요청 수락 성공",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      // 요청 실패
      Fluttertoast.showToast(
          msg: "퇴사요청 수락 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  _fetchRejectLeave(int userId) async {
    // 퇴사요청 수락
    String url = "http://${urlsrc}/albba/store/${storeId}/rejectLeave/${userId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      Fluttertoast.showToast(
          msg: "퇴사요청 거절 성공",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      // 요청 실패
      Fluttertoast.showToast(
          msg: "퇴사요청 거절 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  showMessage(int type, String text, int userId) {
    // type=0이면 입사, type=2이면 퇴사
    // text는 수락, 거절
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
                        text + "하시겠습니까?",
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
                              onPressed: () {
                                if (type == 0) {
                                  if (text == "수락") {
                                    // 입사요청 받기
                                    setState(() {
                                      _fetchJoin(userId);
                                    });
                                  } else if (text == "거절") {
                                    // 입사요청 거절
                                    setState(() {
                                      _fetchRejectJoin(userId);
                                    });
                                  }
                                } else if (type == 2) {
                                  if (text == "수락") {
                                    // 퇴사요청 받기
                                    setState(() {
                                      _fetchLeave(userId);
                                    });
                                  } else if (text == "거절") {
                                    // 퇴사요청 거절
                                    setState(() {
                                      _fetchRejectLeave(userId);
                                    });
                                  }
                                }
                                Navigator.of(context).pop();
                              },
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
              ));
        });
  }

  @override
  void initState() {
    _fetchRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알바에 빠지다',
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
            children: [list(0), list(2)]
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }

  Widget list(int type) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Color(SUBCOLOR),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              if (type == 0)
                Text("입사",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(MAINCOLOR),
                        fontWeight: FontWeight.w800))
              else if (type == 2)
                Text("퇴사",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(MAINCOLOR),
                        fontWeight: FontWeight.w800)),
            ],
          ),
          Divider(thickness: 1, color: Colors.grey),
          Stack(
            children: [
              Column(
                children: [
                  for (int i = 0; i < _requestList.length; i++)
                    if (_requestList[i].activated == type)
                      recode(type, _requestList[i].userId, _requestList[i].name)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget recode(int type, int userId, String name) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 35,
                decoration: BoxDecoration(
                  color: Color(MAINCOLOR),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    showMessage(type, "수락", userId);
                  },
                  child: Text("수락",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 35,
                decoration: BoxDecoration(
                  color: Color(MAINCOLOR),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    showMessage(type, "거절", userId);
                  },
                  child: Text("거절",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RequestInfo {
  int userId = 0;
  String name = "";
  int activated = 0;

  RequestInfo(int userId, String name, int activated) {
    this.userId = userId;
    this.name = name;
    this.activated = activated;
  }

  RequestInfo.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    name = json["name"];
    activated = json["activated"];

    Map toJson() {
      return {'userId': userId, 'name': name, 'activated': activated};
    }
  }
}
