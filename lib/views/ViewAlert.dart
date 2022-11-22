import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAlert extends StatelessWidget {
  ViewAlert({Key? key, required this.id}) : super(key: key);

  final int MAINCOLOR = 0xffeeeded;
  final int SUBCOLOR = 0xffE94869;

  int id = 0;

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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("닫기",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
          ],
        ),
        body: Alert(id: id),
      ),
    );
  }
}

class Alert extends StatefulWidget {
  Alert({Key? key, required this.id}) : super(key: key);

  int id = 0;

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  String token = "", urlsrc = "";
  String title = "", date = "", contents = "";

  _fetchBorad() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    print("token: "+ token);
    print("urlsrc: "+ urlsrc);

    // 글id를 바탕으로 글내용 get 요청
    String url = "http://${urlsrc}/albba/board/View/${widget.id}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 요청 성공
      // 전달받은 값 저장
      Map<String, dynamic> json = jsonDecode(responseBody);
      setState(() {
        // 화면에 출력되는 값은 setState()안에서 저장해야 한다.
        // 그래야 바로 빌드가 되면서, 화면에 바로 업데이트 된다.
        title = json["title"];
        date = json["createdAt"];
        contents = json["contents"];
      });
    } else {
      // 요청 실패
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBorad();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ]),
          ),
          Divider(thickness: 1, color: Colors.grey),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contents,
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
