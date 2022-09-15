import 'package:flutter/material.dart';
import 'StaffSchedulePage.dart';


class AlbaPresident extends StatelessWidget {
  const AlbaPresident({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "choose",
      home: Grade(),
    );
  }
}

class Grade extends StatelessWidget {
  const Grade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("choose"),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StaffCalendarPage()
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
                    border: Border.all(color: Color(0xffE94869), width: 3)

                ),
              ),
            ),
            Container(
                width: 300,
                height: 200,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xffE94869), width: 3)
                ),
                child: Image.asset('assets/b.png', fit: BoxFit.contain,)
            ),
          ],
        ),
      ),
    );
  }
}
