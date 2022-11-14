import 'package:flutter/material.dart';
import 'package:software_engineering/AlertPage.dart';
import 'package:software_engineering/manager/ManagerUpdatePage.dart';

import '/Menubar.dart';
import '/Bottombar.dart';

// 사장용 알바생 관리
class ManagerPage extends StatelessWidget {
  const ManagerPage({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알바생 관리',
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
          children: [Manager()],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}

class Manager extends StatefulWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  // 근무기록 월 데이터
  final List<String> _valueList = ['5월', '6월', '7월', '8월', '9월', '10월', '11월'];
  String _selectedValue = '9월';

  // 알바생 정보 데이터
  final List<StaffInfo> _staffList = [
    new StaffInfo('김민지', 34, 30),
    new StaffInfo('조유정', 38, 00),
    new StaffInfo('문예주', 36, 00)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: DropdownButton(
            value: _selectedValue,
            items: _valueList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value.toString();
              });
            },
          ),
        ),
        Stack(
          children: [
            Column(
              children: [
                for (int i = 0; i < _staffList.length; i++)
                  OwnerManagerStaffInfo(
                    name: _staffList[i].name,
                    hour: _staffList[i].hour,
                    minute: _staffList[i].minute,
                  )
              ],
            ),
          ],
        )
      ],
    ));
  }
}

class StaffInfo {
  String name = "";
  int hour = 0;
  int minute = 0;

  StaffInfo(String name, int hour, int minute) {
    this.name = name;
    this.hour = hour;
    this.minute = minute;
  }
}

class OwnerManagerStaffInfo extends StatelessWidget {
  const OwnerManagerStaffInfo(
      {Key? key, required this.name, required this.hour, required this.minute})
      : super(key: key);

  final name;
  final hour;
  final minute;

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                // background 속성이 없다.
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                    // 테두리를 라운드하게 만들기
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManagerUpdatePage()),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.person,
                    color: Color(MAINCOLOR),
                    size: 40,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(
                        color: Color(MAINCOLOR),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$hour시간 $minute분',
                      style: TextStyle(
                        color: Color(MAINCOLOR),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
