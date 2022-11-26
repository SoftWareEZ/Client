import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:software_engineering/login/WorkerManager.dart';
// import 'AddWorkSpace.dart';

class MenuBar_manager extends StatefulWidget {
  const MenuBar_manager({Key? key}) : super(key: key);

  @override
  State<MenuBar_manager> createState() => MenuBarstate_manager();
}

class MenuBarstate_manager extends State<MenuBar_manager> {
  final int MAINCOLOR = 0xffE94869;
  String token = "", urlsrc = "", userId = "프론트", storeId = "";
  List<String> storeList = ["파스쿠찌", "레프트뱅크"];
  String storeCode = "일하기시러!!";

  _fetchCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");

    print("token: " + token);
    print("urlsrc: " + urlsrc);

    String url = "http:/192.168.0.27:8080/albba/store/invite/${storeId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      setState(() {
        storeCode = json["storeCode"];
      });
      Fluttertoast.showToast(msg: "초대코드 성공");
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: "초대코드 실패");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCode();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffdcdbdb),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('사장  ', style: TextStyle(color: Colors.white)),
                    Text((userId + ' 님'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(MAINCOLOR),
            ),
          ),
          Container(
            height: 130,
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('  나의 사업장'),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Color(0xffE94869),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       // builder: (context) => const AddWorkSpacePage()),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2.0,
                  width: 500.0,
                  color: Color(0xffdcdbdb),
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 3, 10, 5),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              for (int i = 0; i < storeList.length; i++)
                                Text(
                                  storeList[i],
                                  style: TextStyle(color: Colors.black),
                                ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Text(
                              "초대코드 보내기",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Color(MAINCOLOR), width: 3),
                            ),
                            child: Text(
                              storeCode,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 20),
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
                                    },
                                    child: Text(
                                      "닫기",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
                  });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('초대코드 보내기'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const WorkerManager()),
              // );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('로그아웃', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//알바용
class MenuBar_worker extends StatefulWidget {
  const MenuBar_worker({Key? key}) : super(key: key);

  @override
  State<MenuBar_worker> createState() => MenuBarstate_worker();
}

class MenuBarstate_worker extends State<MenuBar_worker> {
  final int MAINCOLOR = 0xffE94869;

  String token = "", urlsrc = "", userId = "문예주", storeId = "레드";
  String code = "";

  _fetchworkplaceInfo() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getString('userId') ?? "null");
    storeId = (prefs.getInt('storeId').toString() ?? "null");
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId);
    print("storeId: " + storeId);

    // storeId를 바탕으로 글목록 get 요청
    String url = "http://192.168.0.27:8080/albba/worker/${userId}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "info 성공");

      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: "info 실패");
    }
  }

  _fetchCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getString('userId') ?? "null");

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId);
    print("code: " + code);

    String url = "http:/192.168.0.27:8080/albba/worker/join/${userId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    var body = jsonEncode({"code": code});

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "초대코드 성공");
      _fetchworkplaceInfo();
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: "초대코드 실패");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchworkplaceInfo();
    // _fetchCode();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffdcdbdb),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('알바생  ', style: TextStyle(color: Colors.white)),
                    Text((userId + ' 님'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffE94869),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('  워크 플레이스'),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Color(0xffE94869),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: Text(
                                          "초대코드 입력하기",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      TextFormField(
                                        onChanged: (text) {
                                          setState(() {
                                            code = text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: Color(MAINCOLOR),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(MAINCOLOR)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(MAINCOLOR),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                                onPressed: () {
                                                  _fetchCode();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "입사요청",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
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
                                                },
                                                child: Text(
                                                  "닫기",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                              });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2.0,
                  width: 500.0,
                  color: Color(0xffdcdbdb),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        storeId,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const WorkerManager()),
              // );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              decoration: BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('로그아웃', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Stack(
// children: [
// Column(
// children: [
// for (int i = 0; i < _alertList.length; i++)
// AlertBox((_alertList[i].title ?? "null"),
// (_alertList[i].date ?? "null"), (_alertList[i].id ?? 0))
// ],
// )
// ],
// )
