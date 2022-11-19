import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/bar/Bottombar.dart';
import '/alert/AddAlert.dart';

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
              height: 5,
              width: 60,
              margin: EdgeInsets.fromLTRB(10, 12, 10, 12),
              decoration: BoxDecoration(
                color: Color(MAINCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text("닫기",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),)
          ],
        ),
        body: ListView(
          children: [AlertList_manager()],
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddAlertpage()),
            );
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
  final List<AlertInfo> _alertList = [
    new AlertInfo("추석(9/9-11) 근무자 시급 15,000원으로 계산하겠습니다!! ^^","20220806","삭제"),
    new AlertInfo("교대할 때 시재 안 맞으면 채우고 퇴근하세요.","20220801","삭제"),
    new AlertInfo("매달 말일, 행사표 교체 잊지 말아주세요.","20220731","삭제"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              for (int i = 0; i < _alertList.length; i++)
                AlertBox_manager(
                  contents: _alertList[i].contents,
                  date: _alertList[i].date,
                  delete: _alertList[i].delete,)
            ],
          )
        ],
      ));
  }
}

class AlertInfo {
  String contents = "";
  String date = "";
  String delete = "";

  AlertInfo(String contents, String date, String delete){
    this.contents = contents;
    this.date = date;
    this.delete = delete;
  }
}

class AlertBox_manager extends StatelessWidget {
  AlertBox_manager(
      {Key? key,
        required this.contents,
        required this.date,
        required this.delete})
      : super(key: key);

  final contents, date, delete;

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xff828282;
  var f = NumberFormat('00');

  @override
  Widget build(BuildContext context){
    return Container(
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
                        '$contents',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(date)),
                      style: TextStyle(color: Color(SUBCOLOR),fontSize: 14),),
                      Text(
                        '$delete',
                        style: TextStyle(
                          color: Color(MAINCOLOR),
                          fontSize: 14,
                        ),),
                    ],
                  )
                ],
            ),
          ),
    );
  }
}
