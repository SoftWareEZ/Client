import 'package:flutter/material.dart';
import 'StaffSchedulePage.dart';
import 'WorkinsteadPage.dart';
import 'Menubar.dart';


// 알바용 - 출퇴근
class CommutePage extends StatelessWidget {
  const CommutePage({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar(),
        appBar: AppBar(
          title: Text('알빠',
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
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: const [
            Commutebody()
          ],
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

class Commutebody extends StatelessWidget {
  const Commutebody({Key? key}) : super(key: key);

  final int SUBCOLOR = 0xffF4F4F4;
  final int MAINCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("근무지 근방 100m 내에서\n출근 버튼을 누르면\n정상적으로 출근처리를 합니다.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(backgroundColor: Color(MAINCOLOR),
                  fixedSize: const Size(130, 130),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),

                  // alignment: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {
                },
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.check,size:40),
                  Text(
                      "출근",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                      ),
                   ),
                ],
                ),
              ),
            ),
          ],
        ));
  }
}