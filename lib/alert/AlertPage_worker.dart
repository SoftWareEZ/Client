import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/bar/Bottombar.dart';
import '/alert/ViewAlert.dart';

// 알바용 알림창
class AlertPage_worker extends StatelessWidget {
  const AlertPage_worker({Key? key}) : super(key: key);

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
          children: [AlertList_worker()],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

class AlertList_worker extends StatefulWidget {
  const AlertList_worker({Key? key}) : super(key: key);

  @override
  State<AlertList_worker> createState() => _AlertList_workerState();
}

class _AlertList_workerState extends State<AlertList_worker> {
  final List<AlertInfo> _alertList = [
    new AlertInfo("추석(9/9-11) 근무자 시급 15,000원으로 계산하겠습니다!! ^^","20220806"),
    new AlertInfo("교대할 때 시재 안 맞으면 채우고 퇴근하세요.","20220801"),
    new AlertInfo("매달 말일, 행사표 교체 잊지 말아주세요.","20220731"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Column(
              children: [
                for (int i = 0; i < _alertList.length; i++)
                  AlertBox_worker(
                    contents: _alertList[i].contents,
                    date: _alertList[i].date,)
              ],
            )
          ],
        ));
  }
}

class AlertInfo {
  String contents = "";
  String date = "";

  AlertInfo(String contents, String date){
    this.contents = contents;
    this.date = date;
  }
}

class AlertBox_worker extends StatelessWidget {
  AlertBox_worker(
      {Key? key,
        required this.contents,
        required this.date})
      : super(key: key);

  final contents, date;

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
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ViewAlert1()),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
