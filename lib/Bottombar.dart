import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'worker/StaffCalendarPage.dart';
import 'worker/CommutePage.dart';
import 'worker/WorkinsteadPage.dart';

import '';

class Bottombar extends StatelessWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StaffCalendarPage()),
                );
              },
              icon: Image.asset('assets/calendar.png'),
              iconSize: 20,
            ),
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
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/mypage.png'),
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
