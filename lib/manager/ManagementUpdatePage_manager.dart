import 'package:flutter/material.dart';

import '/bar/Menubar.dart';
import '../alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';

// 사장용 알바생 관리 - 알바 정보 수정
class ManagementUpdatePage_manager extends StatelessWidget {
  const ManagementUpdatePage_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알바생 정보 수정',
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
          children: [
            ManagerUpdate_manager(
              name: '김민지',
            )
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}

class WorkSchedule {
  // 근무일정 클래스
  String day = ""; // 요일
  int startHour = 0; // 시작 시
  int startMinute = 0; // 시작 분
  int endHour = 0; // 종료 시
  int endMinute = 0; // 종료 분

  WorkSchedule(
      String day, int startHour, int startMinute, int endHour, int endMinute) {
    this.day = day;
    this.startHour = startHour;
    this.startMinute = startMinute;
    this.endHour = endHour;
    this.endMinute = endMinute;
  }
}

class ManagerUpdate_manager extends StatelessWidget {
  ManagerUpdate_manager({Key? key, required this.name}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  final name; // 입사날짜, 근무일정(요일, 시작시간, 끝나는시간)도 데이터 받아서 출력해야한다.

  // 근무일정 데이터
  final List<WorkSchedule> _workschedule = [
    new WorkSchedule("화", 9, 0, 10, 0),
    new WorkSchedule("목", 9, 0, 10, 0)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // 아이콘, 이름, 근무기간 컨테이너
          height: 90,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: Color(SUBPINKCOLOR),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // 아이콘 컨테이너
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Icon(
                  Icons.person,
                  color: Color(MAINCOLOR),
                  size: 50,
                ),
              ),
              Container(
                // 이름, 근무기간 컨테이너
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 이름
                      '$name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('2022.06.24 - 계속') // 근무기간
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          // 시급, 근무일정 컨테이너
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: Color(SUBCOLOR),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                  // 시급 컨테이너
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("시급", style: TextStyle(fontWeight: FontWeight.w700)),
                      Text("9160원"), // 시급 입력할 수 있게 해야 함
                    ],
                  )),
              Container(
                // 근무일정 컨테이너
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "근무일정",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    for (int i = 0;
                                        i < _workschedule.length;
                                        i++)
                                      WorkScheduleContainer(
                                          day: _workschedule[i].day,
                                          startHour: _workschedule[i].startHour,
                                          startMinute:
                                              _workschedule[i].startMinute,
                                          endHour: _workschedule[i].endHour,
                                          endMinute: _workschedule[i].endMinute)
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      // 반복 종료일 컨테이너
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: Color(SUBCOLOR),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("2023년 2월 29일까지 반복"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkScheduleContainer extends StatelessWidget {
  WorkScheduleContainer(
      {Key? key,
      required this.day,
      required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute})
      : super(key: key);

  final String day; // 요일
  final int startHour; // 시작 시
  final int startMinute; // 시작 분
  final int endHour; // 종료 시
  final int endMinute; // 종료 분

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$day $startHour시 $startMinute분 - $endHour시 $endMinute분'),
    );
  }
}
