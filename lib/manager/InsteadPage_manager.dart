import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '../alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';

// 알바용  - 대타
class InsteadPage_manager extends StatelessWidget {
  const InsteadPage_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
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
                      builder: (context) => const AlertPage_manager()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [InsteadPageBox()],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}

class InsteadPageBox extends StatefulWidget {
  const InsteadPageBox({Key? key}) : super(key: key);

  @override
  State<InsteadPageBox> createState() => _InsteadPageBoxState();
}

class _InsteadPageBoxState extends State<InsteadPageBox> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  var _daetaFinalRequestList = [];
  String token = "", urlsrc = "";
  int storeId = 0;

  _fetchDaetaFinalRequestList() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    // 대타최종요청 리스트 가져오기
    String url = "http://${urlsrc}/albba/daeta/request/view/admin/${storeId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: " + responseBody);

    if (response.statusCode == 200) {
      if (responseBody.toString().isEmpty) {
        _daetaFinalRequestList = [];
      } else {
        setState(() {
          List<dynamic> body = json.decode(responseBody);
          _daetaFinalRequestList = body
              .map((dynamic item) => DaetaFinalRequestInfo.fromJson(item))
              .toList();
        });
      }
    } else {
      // 요청 실패
    }
  }

  _fetchDaetaFinalRequest(int no) async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    // 대타최종요청 리스트 가져오기
    String url = "http://${urlsrc}/albba/daeta/approved/${no}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: " + responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      Fluttertoast.showToast(msg: "대타요청 수락 성공");
    } else {
      // 요패 실패
      Fluttertoast.showToast(msg: "대타요청 수락 실패");
    }
  }

  showMessage(int no, String type) {
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
                    "${type}하시겠습니까?",
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
                            setState(() {
                              if (type == '수락') {
                                _fetchDaetaFinalRequest(no);
                              }
                            });
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
    // TODO: implement initState
    super.initState();
    _fetchDaetaFinalRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            for (int i = 0; i < _daetaFinalRequestList.length; i++)
              insteadBox(
                  _daetaFinalRequestList[i].no,
                  _daetaFinalRequestList[i].date,
                  _daetaFinalRequestList[i].requestName,
                  _daetaFinalRequestList[i].acceptName)
          ],
        )
      ],
    );
  }

  Widget insteadBox(int no, int date, String requestName, String acceptName) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBCOLOR),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              DateFormat('yyyy년 MM월 dd일')
                  .format(DateTime.parse(date.toString())),
              style: TextStyle(color: Colors.black38, fontSize: 15)),
          Container(
            margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    requestName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    " -> ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    acceptName,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.0),
                height: 35,
                decoration: BoxDecoration(
                  color: Color(MAINCOLOR),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: TextButton(
                    onPressed: () {
                      showMessage(no, '수락');
                    },
                    child: Text(
                      "수락",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(right: 40.0),
                height: 35,
                decoration: BoxDecoration(
                  color: Color(MAINCOLOR),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: TextButton(
                    onPressed: () {
                      showMessage(no, '거절');
                    },
                    child: Text(
                      "거절",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DaetaFinalRequestInfo {
  int no = 0;
  int date = 0;
  int storeId = 0;
  int requestId = 0;
  String requestName = "";
  String acceptName = "";

  DaetaFinalRequestInfo(int no, int date, int storeId, int requestId,
      String requestName, String acceptName) {
    this.no = no;
    this.date = date;
    this.storeId = storeId;
    this.requestId = requestId;
    this.requestName = requestName;
  }

  DaetaFinalRequestInfo.fromJson(Map<String, dynamic> json) {
    no = json["no"];
    date = json["date"];
    storeId = json["storeId"];
    requestId = json["requestId"];
    requestName = json["requestName"];
    acceptName = json["acceptName"];

    Map toJson() {
      return {
        'no': no,
        'date': date,
        'storeId': storeId,
        'requestId': requestId,
        'requestName': requestName,
        'acceptName': acceptName
      };
    }
  }
}
