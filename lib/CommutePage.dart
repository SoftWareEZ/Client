import 'package:flutter/material.dart';

// 알바용 한달근무표 - 메인 틀
class CommutePage extends StatelessWidget {
  const CommutePage({Key? key}) : super(key: key);

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

                  },
                  icon: Image.asset('assets/calendar.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/change.png'),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {},
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
            TextButton(
              onPressed: (){},
              child: Text('버튼'),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
          ],
        ));
  }
}