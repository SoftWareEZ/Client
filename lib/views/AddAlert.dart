import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AlertPage_manager.dart';

class AddAlertpage extends StatefulWidget {
  const AddAlertpage({Key? key}) : super(key: key);

  @override
  State<AddAlertpage> createState() => Alert();
}

class Alert extends State<AddAlertpage> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  String token = "", storeId = "1";
  String title = "", contents = "";

  _fetchBoardPost() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    //storeId = (prefs.getString('storeId') ?? "null");
    print("token: " + token);
    //print("storeId: "+ storeId);

    // 글쓰기 요청
    String url = "http://165.229.229.104:8080/albba/board/Post";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body =
        jsonEncode({"storeId": storeId, "title": title, "contents": contents});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "글쓰기 성공");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                Text(
                  '제목',
                  style: TextStyle(
                      color: Color(MAINCOLOR),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      title = text;
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
                SizedBox(
                  height: 13,
                ),
                Text(
                  '내용',
                  style: TextStyle(
                      color: Color(MAINCOLOR),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      contents = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "내용을 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                  ),
                  maxLines: 6,
                ),
                SizedBox(
                  height: 13,
                ),
                Text(title + contents),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _fetchBoardPost();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AlertPage_manager()),
            );
          },
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }
}
