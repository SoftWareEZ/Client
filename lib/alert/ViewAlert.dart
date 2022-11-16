import 'package:flutter/material.dart';
import '../bar/Bottombar.dart';

class ViewAlert1 extends StatelessWidget {
  const ViewAlert1({Key? key}) : super(key: key);
  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;

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
              child: Column(
                children: [
                  Container(
                    height: 110,
                    width: 500,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                      Text('추석(9/9-11) 근무자 시급 15,000원으로 계산하겠습니다!! ^^',
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800),),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('2022월 08월 06일',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),),
                          ],
                        ),
                    ]
                   ),
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                ],
              ),
            ),
            bottomNavigationBar: BottomBar_worker(),
        ),
    );
  }
}

class ViewAlert2 extends StatelessWidget {
  const ViewAlert2({Key? key}) : super(key: key);
  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;

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
          child: Column(
            children: [
              Container(
                height: 110,
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('교대할 때 시재 안 맞으면 채우고 퇴근하세요.',
                            style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800),),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('2022월 08월 01일',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ]
                ),
              ),
              Divider(thickness: 1, color: Colors.grey),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

class ViewAlert3 extends StatelessWidget {
  const ViewAlert3({Key? key}) : super(key: key);
  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;

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
          child: Column(
            children: [
              Container(
                height: 110,
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('매달 말일, 행사표 교체 잊지 말아주세요.',
                            style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800),),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('2022월 07월 31일',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ]
                ),
              ),
              Divider(thickness: 1, color: Colors.grey),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

