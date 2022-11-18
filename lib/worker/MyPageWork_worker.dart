import 'package:flutter/material.dart';

import '../alert/AlertPage_worker.dart';
import '../bar/Bottombar.dart';
import '../bar/Menubar.dart';

// 알바용 마이페이지 - 근무기록
class MyPageWork_worker extends StatelessWidget {
  const MyPageWork_worker({Key? key}) : super(key: key);

  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
        drawer: MenuBar_worker(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('근무기록',
              style: TextStyle(
                  color: Color(MAINCOLOR),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              color: Color(MAINCOLOR),
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AlertPage_worker()),
                );
              },
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
        bottomNavigationBar: BottomBar_worker(),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    '2022년',
    <Entry>[
      Entry(
        '3월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],
      ),
      Entry('4월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],),
      Entry('5월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],),
    ],
  ),
  Entry(
    '2021년',
    <Entry>[
      Entry('1월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],),
      Entry('2월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],),
    ],
  ),
  Entry(
    '2020년',
    <Entry>[
      Entry('10월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],),
      Entry('11월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],),
      Entry(
        '12월',
        <Entry>[
          Entry('9일 이마트24 11:00-16:30'),
          Entry('10일 이마트24 11:00-16:30'),
          Entry('25일 이마트24 11:00-16:30'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}