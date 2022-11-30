/* choose */
import 'dart:convert';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering/worker/CalendarPage_worker.dart';
import '/manager/CalendarPage_manager.dart';
import 'Login.dart';
import 'SignUp.dart';
import '/Kakao/Kakao.dart';

//로그인
class choose extends StatelessWidget {
  choose(this.person,{Key? key}): super(key:key);
  String person = "";

  var viewModel = ViewModel(KakaoInfo());

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('알바에 빠지다',
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/Loginlogo.png',
                height: 200,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      //모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                    primary: Color(MAINCOLOR),
                    minimumSize: Size(200, 65),
                    //width, height
                    //child 정렬 - 아래의 Text('$test')
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 25)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Loginpage(person)),
                  );
                },
                child: Text("로그인"),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      //모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                    primary: Color(MAINCOLOR),
                    minimumSize: Size(200, 65),
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 25)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage(person)),
                  );
                },
                child: Text("회원가입"),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      //모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.amberAccent,
                    minimumSize: Size(200, 65),
                    //width, height
                    //child 정렬 - 아래의 Text('$test')
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 25)),
                onPressed: () async{
                  viewModel.setPerson(person);
                  await viewModel.login();
                  // 화면전환
                  if(person=="worker") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarPage_worker()));
                  } else if(person=="manager") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarPage_manager()));
                  }
                },
                child: Text("카카오로그인"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
