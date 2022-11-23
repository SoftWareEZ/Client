import 'package:flutter/material.dart';

import '/bar/Bottombar.dart';
import 'AlertPage_manager.dart';

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
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(MAINCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();},
                    child: Text("닫기",
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),),
                ],
              ),)
          ],
        ),
        body: ListView(
          children: [AlertList()],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}
