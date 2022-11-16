import 'package:flutter/material.dart';

import '../alert/AlertPage.dart';
import '../bar/Bottombar.dart';
import '../bar/Menubar.dart';

// 알바용 마이페이지 - 근무기록
class MyPageWork_worker extends StatelessWidget {
  const MyPageWork_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
        drawer: MenuBar_worker(),
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
                      builder: (context) => const AlertPage_worker()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [MyPageWorkLog_worker()
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

// 알바용 마이페이지 - 근무기록 캘린더
class MyPageWorkLog_worker extends StatelessWidget {
  const MyPageWorkLog_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}