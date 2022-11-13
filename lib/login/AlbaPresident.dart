import 'package:flutter/material.dart';
import 'Login.dart';


//알바 사장 선택
class AlbaPresident extends StatelessWidget {
  const AlbaPresident({Key? key}) : super(key: key);

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

class Grade extends AlbaPresident {
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
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()
                  ),
                );
              },
              child: Container(
                width: 300,
                height: 200,
                margin: EdgeInsets.only(top: 80),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/a.png'),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(MAINCOLOR), width: 3)

                ),
              ),
            ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()
                ),
              );
            },
            child: Container(
                    width: 300,
                    height: 200,
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(MAINCOLOR), width: 3)
                    ),
                    child: Image.asset('assets/b.png', fit: BoxFit.contain,)
                ),
            ),
          ],
        ),
      ),
    );
  }
}
