import 'package:flutter/material.dart';
import 'package:software_engineering/worker/CalendarPage_worker.dart';
import '/manager/CalendarPage_manager.dart';
import 'Login.dart';
import 'SignUp.dart';

//로그인
class choose extends StatelessWidget {
  final String person;
  choose(this.person,{Key? key}): super(key:key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage_manager()),
                  );
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
