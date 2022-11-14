import 'package:flutter/material.dart';

import '/Menubar.dart';
import '/AlertPage.dart';
import '/Bottombar.dart';

class AddAlert extends StatelessWidget{
  const AddAlert({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar(),
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
            AlertName(),
            AlertContent(),
            SizedBox(height: 60,),
            Check(),
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
      ),
    );
  }
}
class AlertName extends StatelessWidget {
  const AlertName({Key? key}) : super(key: key);

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
class AlertContent extends StatelessWidget {
  const AlertContent({Key? key}) : super(key: key);

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
class Check extends StatelessWidget {
  const Check({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
      alignment: Alignment.centerRight,
      child: (
          RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Color(MAINCOLOR),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 25.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          )
      ),
    );
  }
}