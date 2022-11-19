import 'package:flutter/material.dart';
import 'package:software_engineering/alert/AlertPage_manager.dart';
import 'package:software_engineering/bar/Menubar.dart';
import '/bar/Bottombar.dart';

class AddWorkSpacePage extends StatefulWidget {
  const AddWorkSpacePage({Key? key}) : super(key: key);
  @override
  State<AddWorkSpacePage> createState() => AddWorkSpace();
}

class AddWorkSpace extends State<AddWorkSpacePage>{
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  String S_name = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text('매장 이름',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      S_name= text;
                    });
                  },
                  // controller: inputController,
                  decoration: InputDecoration(
                    labelText: "매장 이름을 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                Text('사업장 주소',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      address= text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "주소를 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                  ),
                ),

                SizedBox(height: 13,),
                Text(S_name + address),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {Navigator.of(context).pop();},
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}
