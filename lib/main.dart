import 'package:flutter/material.dart';

void main() {
  runApp(const StaffSchedulePage());
}

class StaffSchedulePage extends StatelessWidget {
  const StaffSchedulePage({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('한달근무표',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5
              )
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.menu),
              color: Color(MAINCOLOR),
              iconSize: 40,
              onPressed: () {  }
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              color: Color(MAINCOLOR),
              iconSize: 40,
              onPressed: (){},)
          ],
        ),
        body: null,
        bottomNavigationBar: Container(
          height: 70,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Image.asset('calendar.png'),
                  iconSize: 80,
                ),
                IconButton(
                  onPressed: (){},
                  icon: Image.asset('change.png'),
                  iconSize: 80,
                ),
                IconButton(
                  onPressed: (){},
                  icon: Image.asset('work.png'),
                  iconSize: 80,
                ),
                IconButton(
                  onPressed: (){},
                  icon: Image.asset('mypage.png'),
                  iconSize: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








