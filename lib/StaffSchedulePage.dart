import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'CommutePage.dart';
import 'WorkinsteadPage.dart';

// 알바용 한달근무표 - 메인 틀
class StaffCalendarPage extends StatelessWidget {
  const StaffCalendarPage({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('한달근무표',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.menu),
              color: Color(MAINCOLOR),
              iconSize: 30,
              onPressed: () {}),
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
            StaffCalendar(),
            StaffCalendarSalary(),
            StaffCalendarInfo(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StaffCalendarPage()),
                    );
                  },
                  icon: Image.asset('assets/calendar.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkinsteadPage()),
                    );
                  },
                  icon: Image.asset('assets/change.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CommutePage()),
                    );
                  },
                  icon: Image.asset('assets/work.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/mypage.png'),
                  iconSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 알바용 한달근무표 - 달력
class StaffCalendar extends StatefulWidget {
  const StaffCalendar({Key? key}) : super(key: key);

  @override
  State<StaffCalendar> createState() => _StaffCalendarState();
}

class _StaffCalendarState extends State<StaffCalendar> {
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
        )
    );
  }
}


// 알바용 한달근무표 - 월급
class StaffCalendarSalary extends StatelessWidget {
  const StaffCalendarSalary({Key? key}) : super(key: key);

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
class StaffCalendarInfo extends StatelessWidget {
  const StaffCalendarInfo({Key? key}) : super(key: key);

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

