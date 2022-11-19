import 'package:flutter/material.dart';
import 'package:software_engineering/alert/AlertPage_manager.dart';
import 'package:software_engineering/bar/Menubar.dart';
import '/bar/Bottombar.dart';
import 'package:flutter/services.dart';

class AddAlertpage extends StatefulWidget {
  const AddAlertpage({Key? key}) : super(key: key);
  @override
  State<AddAlertpage> createState() => Alert();
}

class Alert extends State<AddAlertpage>{
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  String title = "";
  String contents = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text('제목',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      title= text;
                    });
                  },
                  // controller: inputController,
                  decoration: InputDecoration(
                    labelText: "제목을 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                Text('내용',style: TextStyle(color: Color(MAINCOLOR), fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      contents= text;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "내용을 입력해주세요",
                      labelStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 2, color: Color(MAINCOLOR)),
                      ),
                  ),
                  maxLines: 6,
                ),

                SizedBox(height: 13,),
                Text(title + contents),
              ],
            ),
          ),
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
