// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:software_engineering/worker/InsteadPage_worker.dart';

import '/bar/Menubar.dart';
import '/bar/Bottombar.dart';
import '/alert/AlertPage_worker.dart';

// 알바용 대타페이지
class AddInsteadPage_worker extends StatelessWidget {
  const AddInsteadPage_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_worker(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('대타 글쓰기',
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
          children: [
            AddInsteadDateForm_worker(),
            AddInsteadStartTimeForm_worker(),
            AddInsteadEndTimeForm_worker()
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*
            이 시점에서 Form submit
             */
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InsteadPage_worker()),
            );
          },
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}

class AddInsteadDateForm_worker extends StatelessWidget {
  const AddInsteadDateForm_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜
            Text(
              '날짜',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "년",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "월",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "일",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class AddInsteadStartTimeForm_worker extends StatelessWidget {
  const AddInsteadStartTimeForm_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜
            Text(
              '시작시간',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "시",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "분",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class AddInsteadEndTimeForm_worker extends StatelessWidget {
  const AddInsteadEndTimeForm_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜
            Text(
              '종료시간',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "시",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "분",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
