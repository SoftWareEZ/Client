import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '/alert/AlertPage_worker.dart';
import '/bar/Bottombar.dart';
import '/worker/MyPageResign_worker.dart';
import '/worker/MyPageWork_worker.dart';

// 알바용 마이페이지
class MyPage_worker extends StatelessWidget {
  const MyPage_worker({Key? key}) : super(key: key);

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
          title: Text('알바에 빠지다',
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
            MyPageMyInfo_worker(),
            MyPageGoToWork_worker(),
            MyPageGoToResign_worker()
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

class MyPageMyInfo_worker extends StatefulWidget {
  const MyPageMyInfo_worker({Key? key}) : super(key: key);

  @override
  State<MyPageMyInfo_worker> createState() => _MyPageMyInfo_workerState();
}

class _MyPageMyInfo_workerState extends State<MyPageMyInfo_worker> {

  final int MAINCOLOR = 0xffE94869;
  String realname = "";

  getRealName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      realname = (prefs.getString('realname') ?? "null");
    });
    print("realname: " + realname);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRealName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Color(MAINCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text("알바생",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text("${realname} 님",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600))
                  ],
                ))
          ],
        ));
  }
}

// 알바생 마이페이지 근무기록
class MyPageGoToWork_worker extends StatelessWidget {
  const MyPageGoToWork_worker({Key? key}) : super(key: key);

  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBPINKCOLOR),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        // 버튼이 눌리면 StaffMyPageWork
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyPageWork_worker()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("나의 근무기록",
                style: TextStyle(
                    color: Colors.black, fontSize: 20, letterSpacing: 1.3)),
            Icon(
              Icons.arrow_right,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class MyPageGoToResign_worker extends StatelessWidget {
  const MyPageGoToResign_worker({Key? key}) : super(key: key);

  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBPINKCOLOR),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        // 버튼이 눌리면 StaffMyPageResign
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyPageResign_worker()),
          );
        }, // 버튼이 눌리면 StaffMyPageResign
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("퇴사하기",
                style: TextStyle(
                    color: Colors.black, fontSize: 20, letterSpacing: 1.3)),
            Icon(
              Icons.arrow_right,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
