import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/worker/AddInsteadPage_worker.dart';

import '/bar/Menubar.dart';
import '/bar/Bottombar.dart';
import '/alert/AlertPage_worker.dart';

// 알바용 대타페이지
class InsteadPage_worker extends StatelessWidget {
  const InsteadPage_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_worker(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('대타페이지',
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
          children: [InsteadList_worker()],
        ),
        bottomNavigationBar: BottomBar_worker(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddInsteadPage_worker()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}

class InsteadList_worker extends StatefulWidget {
  const InsteadList_worker({Key? key}) : super(key: key);

  @override
  State<InsteadList_worker> createState() => _InsteadList_workerState();
}

class _InsteadList_workerState extends State<InsteadList_worker> {
  final List<InsteadInfo> _insteadList = [
    new InsteadInfo("조유정", "20220806", 8, 0, 12, 00),
    new InsteadInfo("문예주", "20220802", 16, 0, 12, 00),
    new InsteadInfo("김민지", "20220725", 20, 0, 24, 00)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Column(
          children: [
            for (int i = 0; i < _insteadList.length; i++)
              InsteadBox_worker(
                  name: _insteadList[i].name,
                  date: _insteadList[i].date,
                  startHour: _insteadList[i].startHour,
                  startMinute: _insteadList[i].startMinute,
                  endHour: _insteadList[i].endHour,
                  endMinute: _insteadList[i].endMinute)
          ],
        )
      ],
    ));
  }
}

class InsteadInfo {
  String name = "";
  String date = "";
  int startHour = 0, startMinute = 0, endHour = 0, endMinute = 0;

  InsteadInfo(String name, String date, int startHour, int startMinute,
      int endHour, int endMinute) {
    this.name = name;
    this.date = date;
    this.startHour = startHour;
    this.startMinute = startMinute;
    this.endHour = endHour;
    this.endMinute = endMinute;
  }
}

class InsteadBox_worker extends StatelessWidget {
  InsteadBox_worker(
      {Key? key,
      required this.name,
      required this.date,
      required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute})
      : super(key: key);

  final name, date, startHour, startMinute, endHour, endMinute;

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  var f = NumberFormat('00');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text(
                        "대타하시겠습니까?",
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
                                /*
                          이 시점에 사장한테 대타요청
                          */
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
              ));
            });
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text("|"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(date))),
                Text(f.format(startHour) +
                    ":" +
                    f.format(startMinute) +
                    " - " +
                    f.format(endHour) +
                    ":" +
                    f.format(endMinute)),
              ],
            )
          ],
        ),
      ),
    );
  }
}