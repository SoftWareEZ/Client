import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../bar/Menubar.dart';
import '../alert/AlertPage_worker.dart';
import '../bar/Bottombar.dart';

class MyPageResign_worker extends StatefulWidget {
  const MyPageResign_worker({Key? key}) : super(key: key);

  @override
  State<MyPageResign_worker> createState() => _MyPageResign_workerState();
}

class _MyPageResign_workerState extends State<MyPageResign_worker> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  List<StoreInfo> _storeList = [];
  String token = "", urlsrc = "";
  int userId = 0;

  _fetchStoreList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + userId.toString());

    // 사업장 조회
    String url = "http://${urlsrc}/albba/worker/${userId}";
    Map<String, String> headers = {
      "authorization": "Bearer ${token}",
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 사업장 조회 성공
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        _storeList =
            body.map((dynamic item) => StoreInfo.fromJson(item)).toList();
      });
    } else {
      // 사업장 조회 실패
    }
  }

  _fetchLeave(int storeId) async {
    // 퇴사하기 요청
    String url = "http://${urlsrc}/albba/worker/${userId}/leave/${storeId}";
    Map<String, String> headers = {
    "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    var body = jsonEncode({});
    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 퇴사요청 성공
      setState(() {
        _fetchStoreList();
      });
    } else {
      // 퇴사요청 실패
    }
  }

  showMessage(int storeId) {
    showDialog(
        context: context,
        barrierDismissible: false, // 창 밖을 터치해도 창이 닫히지 않게
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.warning,
                    color: Color(MAINCOLOR),
                    size: 28,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "퇴사하시겠습니까?",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(MAINCOLOR),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  // 창 밖을 터치해도 창이 닫히지 않게
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Column(
                                                children: [
                                                  Text("사장님이 퇴사 요청을 수락하면"),
                                                  Text("퇴사가 완료됩니다!"),
                                                ],
                                              )),
                                          Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(MAINCOLOR),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _fetchLeave(storeId);
                                                },
                                                child: Text(
                                                  "확인",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        ],
                                      ),
                                    ));
                                  });
                            },
                            child: Text(
                              "예",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(MAINCOLOR),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "아니오",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _fetchStoreList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_worker(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('퇴사하기',
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
                      builder: (context) => const AlertPage_worker()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(SUBPINKCOLOR),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      for(int i=0; i<_storeList.length; i++)
                        recode(_storeList[i].storeName, _storeList[i].storeId)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }

  Widget recode(String storeName, int storeId) {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(SUBPINKCOLOR),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            storeName,
            style: TextStyle(
                color: Color(MAINCOLOR),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          Container(
              height: 35,
              decoration: BoxDecoration(
                color: Color(MAINCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                child: Text(
                  "퇴사요청",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                onPressed: () {
                  showMessage(storeId);
                },
              )),
        ],
      ),
    );
  }
}
