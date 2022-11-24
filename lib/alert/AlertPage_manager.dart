import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Bottombar.dart';
import '/alert/AddAlert.dart';
import 'ViewAlert.dart';

// 사장용 알림창
class AlertPage_manager extends StatefulWidget {
  const AlertPage_manager({Key? key}) : super(key: key);

  @override
  State<AlertPage_manager> createState() => _AlertPage_managerState();
}

class _AlertPage_managerState extends State<AlertPage_manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xff828282;

  var _alertList = [];
  String token = "", urlsrc = "", storeId = "";
  String title = "", date = "", id = "";

  _fetchBoardList() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId').toString() ?? "null");
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId);

    // storeId를 바탕으로 글목록 get 요청
    String url = "http://${urlsrc}/albba/board/List/${storeId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        _alertList =
            body.map((dynamic item) => AlertInfo.fromJson(item)).toList();
      });
    } else {
      // 요청 실패
    }
  }

  delete(int id) async {
    print("삭제를 시작합니다.");

    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    print("token: " + token);
    print("urlsrc: " + urlsrc);

    // 글id를 바탕으로 삭제 요청
    String url = "http://${urlsrc}/albba/board/delete/${id}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.delete(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      //삭제 성공
      setState(() {
        _fetchBoardList();
      });
    } else {
      //삭제 실패
      Fluttertoast.showToast(msg: "삭제 실패");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBoardList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('알림',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: false,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.notifications),
              color: Color(MAINCOLOR),
              iconSize: 30,
              onPressed: () {}),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(MAINCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
                child: Stack(
              children: [
                Column(
                  children: [
                    for (int i = 0; i < _alertList.length; i++)
                      AlertBox(
                          (_alertList[i].title ?? "null"),
                          (_alertList[i].date ?? "null"),
                          (_alertList[i].id ?? 0))
                  ],
                )
              ],
            )),
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAlertpage()),
            );
            // -------------------------이 부분 해결 안됨
            // -------------------------게시글 추가 후 돌아오고 나서, 리스트 업데이트가 안 된다.
            if (result != null) {
              print(result.returnValue.result);
              setState(() {
                _fetchBoardList();
              });
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }

  Widget AlertBox(String title, String date, int id) {
    return GestureDetector(
      onTap: () {
        //화면전환
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewAlert(id: id)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(color: Color(SUBCOLOR), fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        delete(id);
                      });
                    },
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        color: Color(MAINCOLOR),
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AlertList extends StatefulWidget {
  const AlertList({Key? key}) : super(key: key);

  @override
  State<AlertList> createState() => _AlertListState();
}

class _AlertListState extends State<AlertList> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xff828282;

  var _alertList = [];
  String token = "", urlsrc = "", storeId = "";
  String title = "", date = "", id = "";

  _fetchBoardList() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId').toString() ?? "null");
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId);

    // storeId를 바탕으로 글목록 get 요청
    String url = "http://${urlsrc}/albba/board/List/${storeId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        _alertList =
            body.map((dynamic item) => AlertInfo.fromJson(item)).toList();
      });
    } else {
      // 요청 실패
    }
  }

  delete(int id) async {
    print("삭제를 시작합니다.");

    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    print("token: " + token);
    print("urlsrc: " + urlsrc);

    // 글id를 바탕으로 삭제 요청
    String url = "http://${urlsrc}/albba/board/delete/${id}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.delete(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      //삭제 성공
      setState(() {
        _fetchBoardList();
      });
    } else {
      //삭제 실패
      Fluttertoast.showToast(msg: "삭제 실패");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBoardList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Column(
          children: [
            for (int i = 0; i < _alertList.length; i++)
              AlertBox((_alertList[i].title ?? "null"),
                  (_alertList[i].date ?? "null"), (_alertList[i].id ?? 0))
          ],
        )
      ],
    ));
  }

  Widget AlertBox(String title, String date, int id) {
    return GestureDetector(
      onTap: () {
        //화면전환
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewAlert(id: id)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(color: Color(SUBCOLOR), fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        delete(id);
                      });
                    },
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        color: Color(MAINCOLOR),
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AlertInfo {
  String title = "";
  String date = "";
  int id = 0;

  AlertInfo(String title, String date, int id) {
    this.title = title;
    this.date = date;
    this.id = id;
  }

  AlertInfo.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    date = json["createdAt"];
    id = json["id"];

    Map toJson() {
      return {'title': title, 'date': date, 'id': id};
    }
  }
}
