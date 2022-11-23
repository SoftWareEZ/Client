import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'ViewAlert.dart';
import 'AddAlert.dart';

// 사장용 알림창
class AlertPage_manager extends StatelessWidget {
  const AlertPage_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;

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
          children: [AlertList_manager()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //화면전환
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddAlertpage()));
          },
          child: Icon(Icons.add),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}

class AlertList_manager extends StatefulWidget {
  const AlertList_manager({Key? key}) : super(key: key);

  @override
  State<AlertList_manager> createState() => _AlertList_managerState();
}

class _AlertList_managerState extends State<AlertList_manager> {
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
    print("urlsrc: " + token);
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
              AlertBox_manager(
                  title: (_alertList[i].title ?? "null"), date: (_alertList[i].date ?? "null"), id:(_alertList[i].id ?? 0))
          ],
        )
      ],
    ));
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

class AlertBox_manager extends StatefulWidget {
  AlertBox_manager({Key? key, required this.title, required this.date, required this.id}) : super(key: key);

  String title = "", date = "";
  int id = 0;

  @override
  State<AlertBox_manager> createState() => _AlertBox_managerState();
}

class _AlertBox_managerState extends State<AlertBox_manager> {

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xff828282;
  var f = NumberFormat('00');

  String token = "", urlsrc = "";

  delete() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    print("token: "+ token);
    print("urlsrc: "+ urlsrc);

    // 글id를 바탕으로 글내용 get 요청
    String url = "h/ttp:/${urlsrc}/albba/board/delete/${widget.id}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.delete(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
    } else {
      // 요청 실패
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //화면전환
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewAlert(id: widget.id)));
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
                widget.title,
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
                    widget.date,
                    style: TextStyle(color: Color(SUBCOLOR), fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState((){
                        delete();
                        //화면전환
                        //리스트에서도 제거해야 하는데, 리스트에 접근하는 방법을 모르겠어서 그냥 화면다시 띄우기
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => AlertPage_manager()));
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


