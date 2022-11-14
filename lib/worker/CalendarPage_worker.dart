import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '/AlbaMenubar.dart';
import '/AlertPage.dart';
import '/Bottombar.dart';

// 알바용 - 한달근무표
class CalendarPage_worker extends StatelessWidget {
  const CalendarPage_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: AlbaMenuBar(),
        appBar: AppBar(
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
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: const [
            //여기서 if로 변수해서 클릭시 변수 바뀌면 그거만 로딩하는건 안되는강
            Calendar(),
            CalendarSalary(),
            CalendarInfo(),
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

// 알바용 한달근무표 - 달력
class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final int MAINCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context) {
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
}

// 알바용 한달근무표 - 월급
class CalendarSalary extends StatelessWidget {
  const CalendarSalary({Key? key}) : super(key: key);

  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
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
              "1,000,000 원",
              style: TextStyle(color: Colors.black38, fontSize: 20),
            ),
          ],
        ));
  }
}

// 알바용 한달근무표 - 세부일정
class CalendarInfo extends StatelessWidget {
  const CalendarInfo({Key? key}) : super(key: key);

  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
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
              "8월 6일",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Row(
              children: [
                Text(
                  "08:00 - 12:00  ",
                  style: TextStyle(color: Colors.black38, fontSize: 20),
                ),
                Text("조유정", style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Row(
              children: [
                Text(
                  "12:00 - 16:00  ",
                  style: TextStyle(color: Colors.black38, fontSize: 20),
                ),
                Text("김민지", style: TextStyle(fontSize: 20))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
