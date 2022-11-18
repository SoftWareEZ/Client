import 'package:flutter/material.dart';

import '../bar/Menubar.dart';
import '../alert/AlertPage_worker.dart';
import '../bar/Bottombar.dart';

// 알바용 마이페이지 - 퇴사하기
class MyPageResign_worker extends StatelessWidget {
  const MyPageResign_worker({Key? key}) : super(key: key);

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
          title: Text('퇴사하기',
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
          children: [MyPageResignWorkSpace_worker()],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

// 알바용 마이페이지 - 퇴사하기 워크페이스 목록
class MyPageResignWorkSpace_worker extends StatelessWidget {
  const MyPageResignWorkSpace_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(SUBPINKCOLOR),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "이마트24",
                  style: TextStyle(
                      color: Color(MAINCOLOR),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                ResignButton_worker()
              ],
            ),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(SUBPINKCOLOR),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "레프트뱅크",
                  style: TextStyle(
                      color: Color(MAINCOLOR),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                ResignButton_worker()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResignButton_worker extends StatelessWidget {
  const ResignButton_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        decoration: BoxDecoration(
          color: Color(MAINCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          child: Text(
            "퇴사요청",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false, // 창 밖을 터치해도 창이 닫히지 않게
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Color(MAINCOLOR),
                            size: 28,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(
                              "퇴사하시겠습니까?",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(MAINCOLOR),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false, // 창 밖을 터치해도 창이 닫히지 않게
                                          builder:
                                              (BuildContext context) {
                                              return AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                        child: Column(
                                                          children: [
                                                            Text("사장님이 퇴사 요청을 수락하면"),
                                                            Text("퇴사가 완료됩니다!"),
                                                          ],
                                                        ) 
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        decoration: BoxDecoration(
                                                          color: Color(MAINCOLOR),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                          /*
                                                          이 시점에서, 사장님한테 퇴사요청이 보내진다.
                                                           */
                                                        }, child: Text("확인", style: TextStyle(
                                                          color: Colors.white
                                                        ),)),
                                                      )
                                                    ],
                                                  ),
                                                )

                                              );
                                              });
                                    },
                                    child: Text(
                                      "예",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(MAINCOLOR),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "아니오",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
