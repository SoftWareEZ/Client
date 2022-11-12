import 'package:flutter/material.dart';
import 'StaffSchedulePage.dart';


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
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}
