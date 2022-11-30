import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/WorkerManager.dart';
import 'AddWorkSpace.dart';

class MenuBar_manager extends StatefulWidget {
  const MenuBar_manager({Key? key}) : super(key: key);

  @override
  State<MenuBar_manager> createState() => MenuBarstate_manager();
}

class MenuBarstate_manager extends State<MenuBar_manager> {
  final int MAINCOLOR = 0xffE94869;
  String token = "", urlsrc = "", realname = "";
  int storeId = 0, userId = 0;
  List<StoreInfo> _storeList = [];
  String storeCode = "";

  _fetchStoreList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);
    userId = (prefs.getInt('userId') ?? 0);
    realname = (prefs.getString('realname') ?? "null");

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());
    print("realname: " + realname);

    // 사업장 조회
    String url = "http://${urlsrc}/albba/store/list/${userId}";
    Map<String, String> headers = {
      "authorization": "Bearer ${token}",
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        _storeList =
            body.map((dynamic item) => StoreInfo.fromJson(item)).toList();
      });
      Fluttertoast.showToast(msg: "사업장 조회 성공");
    } else {
      Fluttertoast.showToast(msg: "사업장 조회 실패");
    }
  }

  switchStoreId(int sid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("storeId", sid);
  }

  _fetchCode() async {
    // 초대코드 조회
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);
    realname = (prefs.getString('realname') ?? "null");

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());
    print("realname: " + realname);

    // 초대코드 조회
    String url = "http://${urlsrc}/albba/store/invite/${storeId}";
    Map<String, String> headers = {
      "authorization": "Bearer ${token}",
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      setState(() {
        storeCode = responseBody;
      });
      Fluttertoast.showToast(msg: "초대코드 성공");
    } else {
      Fluttertoast.showToast(msg: "초대코드 실패");
    }
  }

  showInviteCode() {
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
                    "초대코드",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(MAINCOLOR), width: 3),
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
  }

  @override
  initState() {
    super.initState();
    _fetchStoreList();
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
                    Text((realname + ' 님'),
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
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddWorkSpacePage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: Colors.grey),
                Container(
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (int i = 0; i < _storeList.length; i++)
                                if (_storeList[i].storeId == storeId)
                                  Text(
                                    (_storeList[i].storeName ?? "null"),
                                    style: TextStyle(
                                        color: Color(MAINCOLOR),
                                        fontWeight: FontWeight.w700),
                                  )
                                else
                                  GestureDetector(
                                    onTap: () async {
                                      // storeId 바뀌면서, 사업장이 바뀐다.
                                      setState(() {
                                        switchStoreId(_storeList[i].storeId);
                                      });
                                    },
                                    child: Text(
                                      (_storeList[i].storeName ?? "null"),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
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
              showInviteCode();
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
                  Text('초대코드 조회하기'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WorkerManager()),
              );
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
  String token = "", urlsrc = "", realname = "";
  int userId = 0, storeId = 0;
  List<StoreInfo> _storeList = [];
  String code = "";

  _fetchStoreList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    storeId = (prefs.getInt('storeId') ?? 0);
    realname = (prefs.getString('realname') ?? "null");

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());
    print("storeId: " + storeId.toString());
    print("realname: " + realname);

    // 사업장 조회
    String url = "http://${urlsrc}/albba/worker/${userId}";
    Map<String, String> headers = {
      "authorization": "Bearer ${token}",
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> body = json.decode(responseBody);
        _storeList =
            body.map((dynamic item) => StoreInfo.fromJson(item)).toList();
      });
      Fluttertoast.showToast(msg: "사업장 조회 성공");
    } else {
      Fluttertoast.showToast(msg: "사업장 조회 실패");
    }
  }

  _fetchCode() async {
    // 초대코드 입력, 입사요청
    String url = "http://${urlsrc}/albba/worker/signup/${userId}";
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
      String result = responseBody;
      if (result == "success") {
        Fluttertoast.showToast(msg: "입사요청 성공");
      } else if (result == "fail") {
        Fluttertoast.showToast(msg: "존재하지 않는 코드입니다.");
      }
    } else {
      Fluttertoast.showToast(msg: "입사요청 실패");
    }
  }

  showInviteCode() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
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
                            _fetchCode();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "입사요청",
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
  }

  @override
  initState() {
    super.initState();
    _fetchStoreList();
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
                    Text((realname + ' 님'),
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
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('  워크플레이스'),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Color(0xffE94869),
                        onPressed: () {
                          showInviteCode();
                        },
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: Colors.grey),
                Container(
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (int i = 0; i < _storeList.length; i++)
                                if (_storeList[i].storeId == storeId)
                                  GestureDetector(
                                    onTap: () async {
                                      // storeId 바뀌면서, 사업장이 바뀐다.
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setInt(
                                          "storeId", _storeList[i].storeId);
                                    },
                                    child: Text(
                                      (_storeList[i].storeName ?? "null"),
                                      style: TextStyle(
                                          color: Color(MAINCOLOR),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                else
                                  GestureDetector(
                                    onTap: () {
                                      // storeId 바뀌면서, 사업장 바껴야함
                                    },
                                    child: Text(
                                      (_storeList[i].storeName ?? "null"),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WorkerManager()),
              );
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

class StoreInfo {
  int storeId = 0;
  String storeName = "";

  StoreInfo(this.storeId, this.storeName);

  StoreInfo.fromJson(Map<String, dynamic> json) {
    storeId = json["storeId"];
    storeName = json["storeName"];

    Map toJson() {
      return {'storeId': storeId, 'storeName': storeName};
    }
  }
}
