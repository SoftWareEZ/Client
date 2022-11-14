import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '/AlbaMenubar.dart';
import '/AlbaAlertPage.dart';
import '/Bottombar.dart';

// 알바용 마이페이지 - 근무기록
class MyPageWork extends StatelessWidget {
  const MyPageWork({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
        drawer: AlbaMenuBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('근무기록',
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
          children: [MyPageWorkLog()
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

// 알바용 마이페이지 - 근무기록 캘린더
class MyPageWorkLog extends StatelessWidget {
  const MyPageWorkLog({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}