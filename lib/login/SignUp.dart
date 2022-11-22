import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/worker/CalendarPage_worker.dart';

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
  String name = '';
  String id = '';
  String password1 = '';
  String password2 = '';
  String phonenumber = '';
  int check = 0;

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
        ),
        body: Container(
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
                      return "이메일아이디를 입력해주세요";
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
                      id = text;
                    });
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(MAINCOLOR),
                    ),
                    labelText: "이메일아이디를 입력해주세요",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Color(MAINCOLOR)),
                    ),
                    hintText: 'EX) abcd@naver.com',
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
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: Column(children: [
                                    Container(
                                      margin:
                                      EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: Text(
                                        "비밀번호가 일치합니다",
                                        style: TextStyle(fontSize: 20),
                                      ),
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
                                            /*
                          이 시점에 사장한테 대타요청
                          */
                                          },
                                          child: Text(
                                            "닫기",
                                            style:
                                            TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ]),
                                ),
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: Column(children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: Text(
                                        "비밀번호가 일치하지 않습니다",
                                        style: TextStyle(fontSize: 20),
                                      ),
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
                                            /*
                          이 시점에 사장한테 대타요청
                          */
                                          },
                                          child: Text(
                                            "닫기",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ]),
                                ),
                              );
                            });
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
                    if (!RegExp('[0-9]').hasMatch(value) || !(value.length==11)) {
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
                        if(check==1){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendarPage_worker()));
                      }else{
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(children: [
                                      Container(
                                        margin:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: Text(
                                          "비밀번호 확인버튼을 누르세요",
                                          style: TextStyle(fontSize: 20),
                                        ),
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
                                              /*
                          이 시점에 사장한테 대타요청
                          */
                                            },
                                            child: Text(
                                              "닫기",
                                              style:
                                              TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ]),
                                  ),
                                );
                              });
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
      ),
    );
  }
}
