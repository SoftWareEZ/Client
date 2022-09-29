import 'package:flutter/material.dart';
import 'CommutePage.dart';
import 'StaffSchedulePage.dart';

// 알바용  - 메인 틀
class WorkinsteadPage extends StatelessWidget {
  const WorkinsteadPage({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('한달근무표',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.menu),
              color: Color(MAINCOLOR),
              iconSize: 30,
              onPressed: () {}),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              color: Color(MAINCOLOR),
              iconSize: 30,
              onPressed: () {},
            )
          ],
        ),
        body: ListView(

        ),
        bottomNavigationBar: Container(
          height: 70,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StaffCalendarPage()),
                    );
                  },
                  icon: Image.asset('assets/calendar.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkinsteadPage()),
                    );
                  },
                  icon: Image.asset('assets/change.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CommutePage()),
                    );
                  },
                  icon: Image.asset('assets/work.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {

                  },
                  icon: Image.asset('assets/mypage.png'),
                  iconSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}