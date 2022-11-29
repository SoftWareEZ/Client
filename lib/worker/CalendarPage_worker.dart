import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '/alert/AlertPage_worker.dart';
import '/bar/Bottombar.dart';

// 알바용 - 한달근무표
class CalendarPage_worker extends StatelessWidget {
  const CalendarPage_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

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
        body: Calendar(),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

// 한달근무표
class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  var f = NumberFormat('###,###,###,###');

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String day =
      DateFormat('EEE').format(DateTime.now()).toString().toLowerCase();

  var _calendarList = [];
  String token = "", urlsrc = "";
  int userId = 0, storeId = 0;
  String salary = "";

  // 대타요청 하지않은 상태 = 0
  // 대타요청 한 상태 = 1
  // 대타수락 된 상태 = 2
  int daetaState = 0;

  // 대타수락 된 상태면 acceptName에 값이 들어가 있다.
  String acceptName = "";

  _fetchSalary() async {
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

    // userId를 바탕으로 월별 월급 요청
    String url = "http://${urlsrc}/albba/commute/cost/${userId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body = jsonEncode({
      "storeId": storeId,
      "year": DateFormat("yyyy").format(focusedDay),
      "month": DateFormat("MM").format(focusedDay)
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: " + responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        salary = responseBody;
      });
    } else {
      // 요청 실패
    }
  }

  _fetchCalendarList() async {
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

    // 한달근무표 조회 요청
    String url = "http://${urlsrc}/albba/${storeId}/${day}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: " + responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        if (responseBody.toString().isEmpty) {
          _calendarList = [];
        } else {
          List<dynamic> body = json.decode(responseBody);
          _calendarList =
              body.map((dynamic item) => CalendarInfo.fromJson(item)).toList();
        }
      });
    } else {
      // 요청 실패
    }
  }

  _fetchDeataRequest() async {
    // 대타 요청
    String url = "http://${urlsrc}/albba/daeta/request";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body = jsonEncode({
      "date": DateFormat("yyyyMMdd").format(focusedDay),
      "storeId": storeId,
      "requestId": userId
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
    } else {
      // 요청 실패
    }
  }

  _fetchDeataRequestList() async {
    // 대타 요청리스트 조회
  }

  _fetchDeataAccept() async {
    // 대타 수락 리스트 조회
  }

  showMessage() {
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
                      "대타요청 하시겠습니까?",
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
                              _fetchDeataRequest();
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
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchSalary();
    _fetchCalendarList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        calendar(),
        calendarSalary(),
        calendarInfoBox(),
      ],
    );
  }

  Widget calendar() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: TableCalendar(
          // 날짜 설정
          focusedDay: selectedDay,
          firstDay: DateTime(2022, 1, 1),
          lastDay: DateTime(2099, 12, 31),
          // 한국어 설정
          locale: 'ko-KR',
          // 요일 높이 설정 (한국어로 설정하니까 높이가 낮아서 글자가 잘림)
          daysOfWeekHeight: 30,
          // 한달단위, 2주단위, 1주단위로 달력 표시하는 포멧 설정
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) => {
            setState(() => {format = _format})
          },
          // 날짜 선택하는 포멧 설정
          onDaySelected: (selectDay, focusDay) => {
            setState(() => {
                  selectedDay = selectDay,
                  focusedDay = focusDay,
                  day = DateFormat('EEE')
                      .format(focusedDay)
                      .toString()
                      .toLowerCase(),
                  _fetchCalendarList(),
                  _fetchSalary()
                }),
            print(focusedDay),
          },

          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },

          // 캘린더 디자인
          calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(MAINCOLOR), width: 1.5)),
              todayTextStyle: TextStyle(
                color: Color(MAINCOLOR),
              ),
              selectedDecoration: BoxDecoration(
                color: Color(MAINCOLOR),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
              )),
        ));
  }

  Widget calendarSalary() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("월급",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text(
              salary + " 원",
              style: TextStyle(color: Colors.black38, fontSize: 20),
            ),
          ],
        ));
  }

  Widget calendarInfoBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBCOLOR),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Text(
              DateFormat('MM월 dd일').format(focusedDay),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Stack(
            children: [
              Column(
                children: [
                  for (int i = 0; i < _calendarList.length; i++)
                    calendarInfo(_calendarList[i].userId, _calendarList[i].name,
                        _calendarList[i].start, _calendarList[i].end)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget calendarInfo(
      int currentUserId, String name, String start, String end) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(children: [
        Text(
          start + " - " + end,
          style: TextStyle(color: Colors.black38, fontSize: 20),
        ),
        SizedBox(
          width: 15,
        ),
        Stack(
          children: [
            if (daetaState == 2)
              Text(acceptName, style: TextStyle(fontSize: 20))
            else
              Text(name, style: TextStyle(fontSize: 20))
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Stack(
          children: [
            if (currentUserId == userId)
              if (daetaState == 0)
                GestureDetector(
                  onTap: () {
                    showMessage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Color(MAINCOLOR), width: 2))),
                    child: Text(
                      "대타요청",
                      style: TextStyle(
                          color: Color(MAINCOLOR), fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else if (daetaState == 1)
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(MAINCOLOR), width: 2))),
                  child: Text(
                    "대타요청 대기중",
                    style: TextStyle(
                        color: Color(MAINCOLOR), fontWeight: FontWeight.w700),
                  ),
                )
              else if (daetaState == 2)
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(MAINCOLOR), width: 2))),
                  child: Text(
                    "대타",
                    style: TextStyle(
                        color: Color(MAINCOLOR), fontWeight: FontWeight.w700),
                  ),
                )
          ],
        ),
      ]),
    );
  }
}

class CalendarInfo {
  int userId = 0;
  String name = "";
  String start = "";
  String end = "";

  CalendarInfo(int userId, String name, String start, String end) {
    this.userId = userId;
    this.name = name;
    this.start = start;
    this.end = end;
  }

  CalendarInfo.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    name = json["name"];
    start = json["start"];
    end = json["end"];

    Map toJson() {
      return {'userId': userId, 'name': name, 'start': start, 'end': end};
    }
  }
}
