import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

FocusNode myFocusNode = new FocusNode();

//회원가입
class SignUpPage extends StatefulWidget {
  final String person;

  SignUpPage(this.person, {Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUp(person);
}

class SignUp extends State<SignUpPage> {
  final String person;

  SignUp(this.person);

  final int MAINCOLOR = 0xffE94869;
  final _formkey = GlobalKey<FormState>();
  String token = '', urlsrc = '', storeId = '';
  String name = '', id = '', password1 = '', password2 = '', email ='', phonenumber = '';
  int check = 0;

  _fetchSignUp() async {
    // 저장해둔 token 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId').toString() ?? "null");
    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId);

    // 회원가입 요청
    String url = "http://${urlsrc}/albba/signup";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}"
    };
    var body =
    jsonEncode({"username": id, "password": password1, "email": email, "realname": name});
    var response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // 회원가입 성공
      Fluttertoast.showToast(msg: "회원가입 성공");
      Navigator.of(context).pop();
    } else {
      // 회원가입 실패
      Fluttertoast.showToast(msg: "회원가입 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('알빠',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(MAINCOLOR),
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
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "이름을 입력해주세요";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          name = text;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_circle,
                          color: Color(MAINCOLOR),
                        ),
                        labelText: "이름을 입력해주세요",
                        labelStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                        ),
                        hintText: 'EX) 안수진',
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "아이디를 입력해주세요";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          id = text;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.perm_identity,
                          color: Color(MAINCOLOR),
                        ),
                        labelText: "아이디를 입력해주세요",
                        labelStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                        ),
                        hintText: 'id',
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력해주세요";
                        }
                        if (value.length < 8) {
                          return '8자 이상 입력해주세요!';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          password1 = text;
                        });
                      },
                      obscureText: true, // 비밀번호를 적을때 안보이도록
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Color(MAINCOLOR),
                          ),
                          labelText: "비밀번호를 입력해주세요",
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Color(MAINCOLOR)),
                          ),
                          hintText: 'password'),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 재입력해주세요";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          password2 = text;
                        });
                      },
                      obscureText: true, // 비밀번호를 적을때 안보이도록
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Color(MAINCOLOR),
                          ),
                          labelText: "비밀번호를 한번 더 입력해주세요",
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Color(MAINCOLOR)),
                          ),
                          hintText: 'password'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게
                              borderRadius: BorderRadius.circular(5)),
                          primary: Color(MAINCOLOR),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          if (password1 == password2) {
                            check = 1;
                            Fluttertoast.showToast(
                                msg: "비밀번호가 일치합니다",
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM);
                          } else {
                            Fluttertoast.showToast(
                                msg: "비밀번호가 일치하지 않습니다",
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM);
                          }
                        },
                        child: Text('확인'),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "전화번호를 입력해주세요";
                        }
                        if (!RegExp('[0-9]').hasMatch(value) ||
                            !(value.length == 11)) {
                          return '잘못된 전화번호 형식입니다.';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          phonenumber = text;
                        });
                      },
                      // inputFormatters: [
                      //   FilteringTextInputFormatter(RegExp('[0-9]'), allow: false),
                      // ],
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.call,
                          color: Color(MAINCOLOR),
                        ),
                        labelText: "전화번호를 입력해주세요",
                        labelStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                        ),
                        hintText: 'EX) 01012345678',
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "이메일를 입력해주세요";
                        }
                        if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return '잘못된 이메일 형식입니다.';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(MAINCOLOR),
                        ),
                        labelText: "이메일을 입력해주세요",
                        labelStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                        ),
                        hintText: 'EX) abcd@email.com',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              //모서리를 둥글게
                                borderRadius: BorderRadius.circular(5)),
                            primary: Color(MAINCOLOR),
                            minimumSize: Size(70, 50),
                            //width, height
                            alignment: Alignment.center,
                            textStyle: const TextStyle(fontSize: 15)),
                        onPressed: () {
                          if ((_formkey.currentState!.validate())) {
                            if (check == 1) {
                              _fetchSignUp();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "비밀번호 확인버튼을 누르세요",
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM);
                            }
                          }
                        },
                        child: Text('회원가입'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
