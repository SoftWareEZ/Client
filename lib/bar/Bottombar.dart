import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/worker/CalendarPage_worker.dart';
import '/worker/InsteadPage_worker.dart';
import '/worker/CommutePage_worker.dart';
import '/worker/MyPage_worker.dart';

import '/manager/CalendarPage_manager.dart';
import '/manager/InsteadPage_manager.dart';
import '/manager/PersonnelManagement_manager.dart';
import '/manager/ManagementPage_manager.dart';

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
                      builder: (context) => const InsteadPage_worker()),
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
                      builder: (context) => CommuteState_worker()),
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
                      builder: (context) => const MyPage_worker()),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InsteadPage_manager()),
                );
              },
              icon: Image.asset('assets/change.png'),
              iconSize: 20,
            ),
            // 인사
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonnelManagement_manager()),
                );
              },
              icon: Image.asset('assets/personnel.png'),
              iconSize: 40,
            ),
            // 관리
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManagementPage_manager()),
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
