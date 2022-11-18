import 'package:flutter/material.dart';

import '/bar/Menubar.dart';
import '/alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';

class AddWorkSpace extends StatelessWidget{
  const AddWorkSpace({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          drawer: MenuBar_manager(),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color(MAINCOLOR)),
              title: Text('사업장 추가',
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
                SpaceName_manager(),
                SpaceAddress_manager(),
                SizedBox(height: 140,),
              ],
            ),
              bottomNavigationBar: BottomBar_manager(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();},
            child: Icon(Icons.check),
            backgroundColor: Color(MAINCOLOR),
          ),
     ),
    );
  }
}

class SpaceName_manager extends StatelessWidget {
  const SpaceName_manager({Key? key}) : super(key: key);

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
              Text('매장 이름',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "매장 이름을 입력해주세요",
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

class SpaceAddress_manager extends StatelessWidget {
  const SpaceAddress_manager({Key? key}) : super(key: key);

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
              Text('사업장 주소',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "주소를 입력해주세요",
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