import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/alert/AlertPage.dart';
import '/manager/ManagementUpdatePage_manager.dart';
import '/bar/Menubar.dart';
import '/bar/Bottombar.dart';

// 사장용 알바생 관리
class ManagementPage_manager extends StatelessWidget {
  const ManagementPage_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
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
          children: [Management_manager()],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}

class Management_manager extends StatefulWidget {
  const Management_manager({Key? key}) : super(key: key);

  @override
  State<Management_manager> createState() => _ManagementState();
}

class _ManagementState extends State<Management_manager> {
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
  OwnerManagerStaffInfo(
      {Key? key, required this.name, required this.hour, required this.minute})
      : super(key: key);

  final name;
  final hour;
  final minute;

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  var f = NumberFormat('00');

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
                    builder: (context) => const ManagementUpdatePage_manager()),
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
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      f.format(hour) + '시간 ' + f.format(minute) + '분',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        //fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
