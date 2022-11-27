import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/alert/AlertPage_manager.dart';
import '/bar/Menubar.dart';
import '/bar/Bottombar.dart';

class AddWorkSpacePage extends StatefulWidget {
  const AddWorkSpacePage({Key? key}) : super(key: key);
  @override
  State<AddWorkSpacePage> createState() => AddWorkSpace();
}

class AddWorkSpace extends State<AddWorkSpacePage>{
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  String token = "", urlsrc = "";
  int userId = 0;
  String storeName = "", storeAddr = "";

  _fetchAddStore() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: "+ userId.toString());

    // 사업장 추가 요청
    String url = "http://${urlsrc}/albba/store/add";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body =
    jsonEncode({"userId": userId, "storeName": storeName, "storeAddr": storeAddr});
    var response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 글쓰기 성공
      Fluttertoast.showToast(
          msg: "글쓰기 성공",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      Fluttertoast.showToast(
          msg: "글쓰기 실패",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

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
                      storeName= text;
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
                      storeAddr= text;
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
                Text(storeName + storeAddr),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _fetchAddStore();
            Navigator.of(context).pop();},
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}
