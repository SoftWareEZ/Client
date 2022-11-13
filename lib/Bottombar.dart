import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'worker/CalendarPage_worker.dart';
import 'worker/WorkinsteadPage.dart';
import 'worker/CommutePage.dart';
import 'worker/MyPage.dart';

import 'manager/CalendarPage_manager.dart';
import 'manager/ManagerPage.dart';

class BottomBar_worker extends StatelessWidget {
  const BottomBar_worker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 한달근무표
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalendarPage_worker()),
                );
              },
              icon: Image.asset('assets/calendar.png'),
              iconSize: 20,
            ),
            // 대타
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WorkinsteadPage()),
                );
              },
              icon: Image.asset('assets/change.png'),
              iconSize: 20,
            ),
            // 출퇴근
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommutePage()),
                );
              },
              icon: Image.asset('assets/work.png'),
              iconSize: 20,
            ),
            // 마이페이지
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyPage()),
                );
              },
              icon: Image.asset('assets/mypage.png'),
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar_manager extends StatelessWidget {
  const BottomBar_manager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 한달근무표
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalendarPage_manager()),
                );
              },
              icon: Image.asset('assets/calendar.png'),
              iconSize: 20,
            ),
            // 대타
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/change.png'),
              iconSize: 20,
            ),
            // 인사
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/personnel.png'),
              iconSize: 20,
            ),
            // 관리
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManagerPage()),
                );
              },
              icon: Image.asset('assets/manage.png'),
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
