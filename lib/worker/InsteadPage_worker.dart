import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '/bar/Bottombar.dart';
import '/alert/AlertPage_worker.dart';

// 알바용 대타페이지
class InsteadPage_worker extends StatelessWidget {
  const InsteadPage_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_worker(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('대타페이지',
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
          children: [InsteadList_worker()],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

class InsteadList_worker extends StatefulWidget {
  const InsteadList_worker({Key? key}) : super(key: key);

  @override
  State<InsteadList_worker> createState() => _InsteadList_workerState();
}

class _InsteadList_workerState extends State<InsteadList_worker> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  var f = NumberFormat('00');
  var _daetaRequestList = [];
  String token = "", urlsrc = "";
  int userId = 0, storeId = 0;

  _fetchDaetaRequestList() async {
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

    // 대타요청 리스트 가져오기
    String url = "http://${urlsrc}/albba/daeta/request/list/${storeId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: " + responseBody);

    if (response.statusCode == 200) {
      // 요청성공
      if (responseBody.toString().isEmpty) {
        _daetaRequestList = [];
      } else {
        setState(() {
          List<dynamic> body = json.decode(responseBody);
          _daetaRequestList = body
              .map((dynamic item) => DaetaRequestInfo.fromJson(item))
              .toList();
        });
      }
    } else {
      // 요청실패
    }
  }

  _fetchDaetaRequest(int no) async {
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

    // 대타요청 리스트 가져오기
    String url = "http://${urlsrc}/albba/daeta/accept";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body = jsonEncode({"no": no, "acceptId": userId});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: " + responseBody);

    if (response.statusCode == 200) {
      // 요청성공
      Fluttertoast.showToast(msg: "대타요청 성공");
    } else {
      // 요청실패
      Fluttertoast.showToast(msg: "대타요청 성공");
    }
  }

  showMessage(int no) {
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
                    "대타하시겠습니까?",
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
                            _fetchDaetaRequest(no);
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
    _fetchDaetaRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Column(
          children: [
            for (int i = 0; i < _daetaRequestList.length; i++)
              InsteadBox(_daetaRequestList[i].no,
                  _daetaRequestList[i].requestName, _daetaRequestList[i].date)
          ],
        )
      ],
    ));
  }

  Widget InsteadBox(int no, String name, int date) {
    return GestureDetector(
      onTap: () {
        setState(() => {
          showMessage(no)
        });
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text("|"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('yyyy년 MM월 dd일')
                    .format(DateTime.parse(date.toString()))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DaetaRequestInfo {
  int no = 0;
  int date = 0;
  int storeId = 0;
  int requestId = 0;
  String requestName = "";

  DaetaRequestInfo(
      int no, int date, int storeId, int requestId, String requestName) {
    this.no = no;
    this.date = date;
    this.storeId = storeId;
    this.requestId = requestId;
    this.requestName = requestName;
  }

  DaetaRequestInfo.fromJson(Map<String, dynamic> json) {
    no = json["no"];
    date = json["date"];
    storeId = json["storeId"];
    requestId = json["requestId"];
    requestName = json["requestName"];

    Map toJson() {
      return {
        'no': no,
        'date': date,
        'storeId': storeId,
        'requestId': requestId,
        'requestName': requestName
      };
    }
  }
}
