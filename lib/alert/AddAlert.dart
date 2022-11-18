import 'package:flutter/material.dart';

import '/bar/Menubar.dart';
import 'AlertPage_manager.dart';
import '/bar/Bottombar.dart';

class AddAlert extends StatelessWidget{
  const AddAlert({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알림 등록',
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
        body: ListView(
          children: const [
            AlertName_manager(),
            AlertContent_manager(),
            SizedBox(height: 60,),
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AlertPage_manager()),);
          },
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}

class AlertName_manager extends StatelessWidget {
  const AlertName_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context){
    return Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            children: <Widget>[
              Text('제목',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "제목을 입력해주세요",
                  labelStyle: TextStyle(
                    color: Color(MAINCOLOR),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),),
                ),
              ),
            ]
        )
    );
  }
}
class AlertContent_manager extends StatelessWidget {
  const AlertContent_manager({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context){
    return Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          color: Color(SUBCOLOR),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            children: <Widget>[
              Text('내용',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "내용을 입력해주세요",
                  labelStyle: TextStyle(
                    color: Color(MAINCOLOR),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),),
                ),
                maxLines: 6,
              )
            ]
        )
    );
  }
}