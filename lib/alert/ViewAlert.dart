import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../bar/Bottombar.dart';
import '/alert/AlertPage_worker.dart';

class ViewAlert extends StatelessWidget {
  ViewAlert({Key? key, required this.title, required this.date, required this.contents,}): super(key: key);
  final title,date,contents;
  //String title = "";
  //String date = "";
  //String contents ="";

  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('알림',
                  style: TextStyle(
                      color: Color(SUBCOLOR),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5)),
              centerTitle: false,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(Icons.notifications),
                  color: Color(SUBCOLOR),
                  iconSize: 30,
                  onPressed: () {}),
              actions: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Color(SUBCOLOR),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();},
                          child: Text("닫기",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),),
                    ]
                  ),
                 ),
              ],

            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: 110,
                    width: 500,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                      Text('$title',
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800),),
                        SizedBox(height: 7,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(date)),
                              style: TextStyle(color: Colors.black,fontSize: 14),),
                          ],
                        ),
                    ]
                   ),
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('$contents', style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomBar_worker(),
        ),
    );
  }
}

