import 'package:flutter/material.dart';

import '/AlbaMenubar.dart';
import '/AlbaAlertPage.dart';
import '/Bottombar.dart';
import '/worker/MyPageResign.dart';
import '/worker/MyPageWork.dart';

// 알바용 마이페이지
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: AlbaMenuBar(),
        appBar: AppBar(
          title: Text('마이페이지',
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
                      builder: (context) => const AlbaAlertPage()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [
            MyPageMyInfo(),
            MyPageGoToWork(),
            MyPageGoToResign()
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

class MyPageMyInfo extends StatelessWidget {
  const MyPageMyInfo({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Color(MAINCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text("알바생",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text("프론트 님",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600))
                  ],
                ))
          ],
        ));
  }
}

// 알바생 마이페이지 근무기록
class MyPageGoToWork extends StatelessWidget {
  const MyPageGoToWork({Key? key}) : super(key: key);

  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBPINKCOLOR),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        // 버튼이 눌리면 StaffMyPageWork
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyPageWork()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("나의 근무기록",
                style: TextStyle(
                    color: Colors.black, fontSize: 20, letterSpacing: 1.3)),
            Icon(
              Icons.arrow_right,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class MyPageGoToResign extends StatelessWidget {
  const MyPageGoToResign({Key? key}) : super(key: key);

  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBPINKCOLOR),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        // 버튼이 눌리면 StaffMyPageResign
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyPageResign()),
          );
        }, // 버튼이 눌리면 StaffMyPageResign
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("퇴사하기",
                style: TextStyle(
                    color: Colors.black, fontSize: 20, letterSpacing: 1.3)),
            Icon(
              Icons.arrow_right,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
