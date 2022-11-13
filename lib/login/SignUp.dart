import 'package:flutter/material.dart';
import '/worker/CalendarPage_worker.dart';

//회원가입
class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Grade(),
    );
  }
}

class Grade extends SignUp {
  const Grade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: "이름을 입력해주세요",
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              SizedBox(
                height: 13,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: "이메일아이디를 입력해주세요",
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                ),
              ),
              SizedBox(
                height: 13,
              ),
              TextFormField(
                obscureText: true, // 비밀번호를 적을때 안보이도록
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "비밀번호를 입력해주세요",
                    border: OutlineInputBorder(),
                    hintText: 'password'),
              ),
              SizedBox(
                height: 13,
              ),
              TextFormField(
                obscureText: true, // 비밀번호를 적을때 안보이도록
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "비밀번호를 한번 더 입력해주세요",
                    border: OutlineInputBorder(),
                    hintText: 'password'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(5)),
                    primary: Color(MAINCOLOR),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {},
                  child: Text('확인'),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: "전화번호를 입력해주세요",
                  border: OutlineInputBorder(),
                  hintText: 'Phone number',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(5)),
                    primary: Color(MAINCOLOR),
                      minimumSize: Size(70, 50),	//width, height
                      alignment: Alignment.center,
                      textStyle: const TextStyle(fontSize: 15)
                  ),
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
    );
  }
}
