import 'package:flutter/material.dart';

import '/Bottombar.dart';

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
        body: Container(
          color: Color(MAINCOLOR),
          child: Column(
            children: [
              Container(
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
                          Text('삭제',
                            style: TextStyle(
                                color: Color(SUBCOLOR), fontSize: 14.0, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ]
                ),
              ),
              Container(
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
                        Text('삭제',
                          style: TextStyle(
                              color: Color(SUBCOLOR), fontSize: 14.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
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
                        Text('삭제',
                          style: TextStyle(
                              color: Color(SUBCOLOR), fontSize: 14.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Color(SUBCOLOR),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ],
              )


            ],
          ),
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}