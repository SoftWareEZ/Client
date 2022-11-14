import 'package:flutter/material.dart';

import '/Menubar.dart';
import '/AlertPage.dart';
import '/Bottombar.dart';

class AddWorkSpace extends StatelessWidget{
  const AddWorkSpace({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          drawer: MenuBar(),
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
                SpaceName(),
                SpaceAddress(),
                SizedBox(
                  height: 140,
                ),
                Check(),
              ],
            ),
              bottomNavigationBar: BottomBar_manager(),
     ),
    );
  }
}

class SpaceName extends StatelessWidget {
  const SpaceName({Key? key}) : super(key: key);

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

class SpaceAddress extends StatelessWidget {
  const SpaceAddress({Key? key}) : super(key: key);

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