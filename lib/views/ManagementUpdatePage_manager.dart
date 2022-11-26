import 'package:flutter/material.dart';

// import '/bar/Menubar.dart';
// import '../alert/AlertPage_manager.dart';
// import '/bar/Bottombar.dart';
import 'Menubar.dart';

// 사장용 알바생 관리 - 알바 정보 수정
class ManagementUpdatePage_manager extends StatefulWidget {
  const ManagementUpdatePage_manager({Key? key}) : super(key: key);


  @override
  State<ManagementUpdatePage_manager> createState() => ManagementUpdatePage();
}

class ManagementUpdatePage extends State<ManagementUpdatePage_manager> {
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AlertPage_manager()),
                // );
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
        // bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              //정보 업데이트다 되있음!! 디비에 넘겨줘야함.
            });
            Navigator.of(context).pop();
          },
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
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

class ManagerUpdate_manager extends StatefulWidget {
  const ManagerUpdate_manager({Key? key, required this.name}) : super(key: key);
  final name;

  @override
  State<ManagerUpdate_manager> createState() => Managerupdate_manager();
}

class Managerupdate_manager extends State<ManagerUpdate_manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  // 입사날짜, 근무일정(요일, 시작시간, 끝나는시간)도 데이터 받아서 출력해야한다.
  String money = "9160";
  String AccountNumber ="1111-1111";

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
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Text('2022.06.24 - 계속') // 근무기간
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
                  children: [
                    Text("시급 :  "),
                    Container(
                      width: 50,
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            money = text;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(MAINCOLOR)),
                          ),
                          hintText: money,
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Text(" 원"),
                  ],
                ),
              ),
              Container(
                // 근무일정 컨테이너
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text("근무 일정 :  "),
                    Container(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              for (int i = 0; i < _workschedule.length; i++)
                                WorkScheduleContainer(
                                    day: _workschedule[i].day,
                                    startHour: _workschedule[i].startHour,
                                    startMinute: _workschedule[i].startMinute,
                                    endHour: _workschedule[i].endHour,
                                    endMinute: _workschedule[i].endMinute)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // 계좌 컨테이너
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text("입금 계좌 :  "),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            AccountNumber = text;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Color(MAINCOLOR)),
                          ),
                          hintText: AccountNumber,
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
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


class WorkScheduleContainer extends StatefulWidget {
  WorkScheduleContainer(
      {Key? key,
        required this.day,
        required this.startHour,
        required this.startMinute,
        required this.endHour,
        required this.endMinute})
      : super(key: key);

  String day; // 요일
  int startHour; // 시작 시
  int startMinute; // 시작 분
  int endHour; // 종료 시
  int endMinute; // 종료 분


  @override
  State<WorkScheduleContainer> createState() => ContainerState();
}

class ContainerState extends State<WorkScheduleContainer> {
  final List<String> _dayList = ['월', '화', '수', '목', '금', '토', '일'];
  final List<int> _hourList = List.generate(24, (index) => index+1);
  final List<int> _minuteList = List.generate(60, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
      children: [
        DropdownButton( //요일
          value: widget.day,
          items: _dayList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.day = value!;
            });
          },
        ),
        Text("  "),
        DropdownButton( //시작 시
          value: widget.startHour,
          items: _hourList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.startHour = value!;
            });
          },
        ),
        Text(" : "),
        DropdownButton( //시작 분
          value: widget.startMinute,
          items: _minuteList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.startMinute = value!;
            });
          },
        ),
        Text("  ~  "),
        DropdownButton( //종료 시
          value: widget.endHour,
          items: _hourList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.endHour = value!;
            });
          },
        ),
        Text(" : "),
        DropdownButton( //종료 분
          value: widget.endMinute,
          items: _minuteList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.endMinute = value!;
            });
          },
        ),
      ],
      ),
    );
  }
}
