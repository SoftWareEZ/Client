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
  String name = '';
  String id = '';
  String password = '';
  String phonenumber = '';

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
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      name= text;
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
                    hintText: 'EX) 김철수',
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      id= text;
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
                  onChanged: (text) {
                    setState(() {
                      password = text;
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
                    onPressed: () {},
                    child: Text('확인'),
                  ),
                ),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      phonenumber= text;
                    });
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp('[0-9]'), allow: false),
                  ],
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage_worker()));
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
