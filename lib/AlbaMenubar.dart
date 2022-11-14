import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbaMenuBar extends StatelessWidget {
  const AlbaMenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffdcdbdb),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('알바생  ', style: TextStyle(color: Colors.white)),
                    Text('문예주 님',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffE94869),
            ),
          ),
          Container(
            height: 110,
            margin: EdgeInsets.fromLTRB(30, 20, 30, 6),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('  워크 플레이스'),
                      Icon(
                        Icons.add,
                        color: Color(0xffE94869),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2.0,
                  width: 500.0,
                  color: Color(0xffdcdbdb),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "파스쿠찌",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "레프트뱅크",
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(30, 6, 30, 6),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('로그아웃', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
