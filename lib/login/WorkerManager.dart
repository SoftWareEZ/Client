import 'package:flutter/material.dart';
import 'Choose.dart';


//알바 사장 선택
class WorkerManager extends StatelessWidget {
  const WorkerManager({Key? key}) : super(key: key);

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

class Grade extends WorkerManager {
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
              onTap: () async {
                final String person = 'worker';
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => choose(person)
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
            onTap: () async {
              final String person = 'manager';
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => choose(person)
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
