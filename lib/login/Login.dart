import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/worker/CalendarPage_worker.dart';

FocusNode myFocusNode = new FocusNode();

//로그인
class Loginpage extends StatefulWidget {
  final String person;
  Loginpage(this.person, {Key? key}) : super(key: key);
  @override
  State<Loginpage> createState() => Login(person);
}

class Login extends State<Loginpage>{
  final String person;
  Login(this.person);
  // TextEditingController inputController = TextEditingController();
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  String id = '';
  String password = '';

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
                      id= text;
                    });
                  },
                  // controller: inputController,
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
                  obscureText: true, // 비밀번호를 적을때 안보이도록
                  onChanged: (text) {
                    setState(() {
                      password= text;
                    });
                  },
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
                    child: Text('로그인'),
                  ),
                ),
                Text(person+id+password),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
