import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/bar/Bottombar.dart';
import '/alert/AddAlert.dart';
import '/alert/ViewAlert.dart';

// 알림창
class AlertPage_manager extends StatelessWidget {
  const AlertPage_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;
  final int SUBGREYCOLOR = 0xff828282;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('알림',
              style: TextStyle(
                  color: Color(SUBCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: false,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.notifications),
              color: Color(SUBCOLOR),
              iconSize: 30,
              onPressed: () {}),
          actions: [
            Container(
              height: 5,
              width: 60,
              margin: EdgeInsets.fromLTRB(10, 12, 10, 12),
              decoration: BoxDecoration(
                color: Color(SUBCOLOR),
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
                  builder: (context) => const AddAlert()),
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
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewAlert1()),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$contents',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        )
    );
  }
}


// 알림창
class AlertPage_worker extends StatelessWidget {
  const AlertPage_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;
  final int SUBGREYCOLOR = 0xff828282;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('알림',
              style: TextStyle(
                  color: Color(SUBCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: false,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.notifications),
              color: Color(SUBCOLOR),
              iconSize: 30,
              onPressed: () {}),
          actions: [
            Container(
              height: 5,
              width: 60,
              margin: EdgeInsets.fromLTRB(10, 12, 10, 12),
              decoration: BoxDecoration(
                color: Color(SUBCOLOR),
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
        body: Container(
          color: Color(MAINCOLOR),
          child: Column(
            children: [
              InkWell(
                child: Container(
                  height: 110,
                  width: 500,
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('추석(9/9-11) 근무자 시급 15,000원으로 계산하겠습니다!! ^^',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('2022월 08월 06일',
                            style: TextStyle(
                                color: Color(SUBGREYCOLOR),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewAlert1()
                    ),
                  );
                },
              ),

              InkWell(
                child: Container(
                  height: 110,
                  width: 500,
                  margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("교대할 때 시재 안 맞으면 채우고 퇴근하세요.",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2022월 08월 01일",
                            style: TextStyle(color: Color(SUBGREYCOLOR),fontSize: 14, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewAlert2()
                    ),
                  );
                },
              ),

              InkWell(
                child: Container(
                  height: 110,
                  width: 500,
                  margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("매달 말일, 행사표 교체 잊지 말아주세요.",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2022월 07월 31일",
                            style: TextStyle(color: Color(SUBGREYCOLOR),fontSize: 14, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewAlert3()
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}