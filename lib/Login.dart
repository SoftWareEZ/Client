import 'package:flutter/material.dart';
import 'StaffSchedulePage.dart';
import 'SignUp.dart';


//로그인
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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

class Grade extends Login {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                    primary: Color(MAINCOLOR),
                    minimumSize: Size(200, 80),	//width, height
                    //child 정렬 - 아래의 Text('$test')
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 25)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StaffCalendarPage()
                    ),
                  );
                },
                child: Text("로그인"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.amberAccent,
                    minimumSize: Size(200, 80),	//width, height
                    //child 정렬 - 아래의 Text('$test')
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 25)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StaffCalendarPage()
                    ),
                  );
                },
                child: Text("카카오로그인"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                    primary: Color(MAINCOLOR),
                    minimumSize: Size(200, 80),	//width, height
                    //child 정렬 - 아래의 Text('$test')
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 25)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()
                    ),
                  );
                },
                child: Text("회원가입"),
              ),
            ],
          // children: [
          //   InkWell(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const SignUp()
          //         ),
          //       );
          //     },
          //     child: Container(
          //       width: 300,
          //       height: 200,
          //       margin: EdgeInsets.only(top: 80),
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: AssetImage('assets/a.png'),
          //             fit: BoxFit.contain,
          //           ),
          //           borderRadius: BorderRadius.circular(12),
          //           border: Border.all(color: Color(MAINCOLOR), width: 3)
          //
          //       ),
          //     ),
          //   ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const StaffCalendarPage()
          //       ),
          //     );
          //   },
          //   child: Container(
          //           width: 300,
          //           height: 200,
          //           margin: EdgeInsets.only(top: 40),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               border: Border.all(color: Color(MAINCOLOR), width: 3)
          //           ),
          //           child: Image.asset('assets/b.png', fit: BoxFit.contain,)
          //       ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
