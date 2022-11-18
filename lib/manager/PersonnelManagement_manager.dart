import 'package:flutter/material.dart';

import '/bar/Menubar.dart';
import '../alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';

// 알바용  - 입퇴사 관리
class PersonnelManagement_manager extends StatelessWidget {
  const PersonnelManagement_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AlertPage_manager()),
                );
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(SUBCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "입사",
                      style: TextStyle(color: Color(MAINCOLOR), fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 2.0,
                    color: Color(0xffdcdbdb),
                    margin: EdgeInsets.only(bottom: 10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "조유정",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, //?? 옮겨야해
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(MAINCOLOR),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                },
                                child: Text(
                                  "수락",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 40.0),
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(MAINCOLOR),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                },
                                child: Text(
                                  "거절",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}
