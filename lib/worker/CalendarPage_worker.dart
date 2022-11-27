import 'package:flutter/material.dart';
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
    print(responseBody);

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
    storeId = (prefs.getInt('storeId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    // storeId를 바탕으로 글목록 get 요청
    String url = "http://${urlsrc}/albba/${storeId}/${day}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        _calendarList =
            body.map((dynamic item) => CalendarInfo.fromJson(item)).toList();
      });
    } else {
      // 요청 실패
    }
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
                    calendarInfo(
                        (_calendarList[i].name ?? "null"),
                        (_calendarList[i].start ?? "null"),
                        (_calendarList[i].end ?? "null"))
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget calendarInfo(String name, String start, String end) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        children: [
          Text(
            start + " - " + end + " ",
            style: TextStyle(color: Colors.black38, fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          Text(name, style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}

class CalendarInfo {
  String name = "";
  String start = "";
  String end = "";

  AlertInfo(String name, String start, String end) {
    this.name = name;
    this.start = start;
    this.end = end;
  }

  CalendarInfo.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    start = json["start"];
    end = json["end"];

    Map toJson() {
      return {'name': name, 'start': start, 'end': end};
    }
  }
}
