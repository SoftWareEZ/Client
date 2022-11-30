import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '../alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';

// 사장용 알바생 관리 - 알바 정보 수정
class ManagementUpdatePage_manager extends StatefulWidget {
  ManagementUpdatePage_manager({Key? key, required this.workerId, required this.workerName}) : super(key: key);

  int workerId = 0;
  String workerName = "";

  @override
  State<ManagementUpdatePage_manager> createState() => ManagementUpdatePage();
}

class ManagementUpdatePage extends State<ManagementUpdatePage_manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;

  // List<WorkSchedule> _workschedule = [
  //   new WorkSchedule.orgin()
  // ];
  List<String> _dayList = [], _hourList = [], _minuteList = [];

  List<String> dayList = ['월', '화', '수', '목', '금', '토', '일'];
  List<int> inthourList = List.generate(24, (index) => index + 1);
  List<int> intminuteList = List.generate(60, (index) => index);

  List<WorkSchedule> _workschedule = new List.empty(growable: true);
  String day = "", start = "", end = "";
  String token = "", urlsrc = "", realname = "";
  int storeId = 0;
  String id = "", password = "";
  String wage = "9160",
      account = "1111-1111",
      mon_start = "null",
      mon_end = "null",
      tue_start = "null",
      tue_end = "null",
      wed_start = "null",
      wed_end = "null",
      thu_start = "null",
      thu_end = "null",
      fri_start = "null",
      fri_end = "null",
      sat_start = "null",
      sat_end = "null",
      sun_start = "null",
      sun_end = "null";

  var f = NumberFormat('00');

//  근무일정 데이터
  _transWorkSchedule() async {
    for (int i = 0; i < _workschedule.length; i++) {
      start = f.format(int.parse(_workschedule[i].startHour)) +
          ":" +
          f.format(int.parse(_workschedule[i].startMinute));
      end = f.format(int.parse(_workschedule[i].endHour)) +
          ":" +
          f.format(int.parse(_workschedule[i].endMinute));
      print(start+end);
      if (_workschedule[i].day == "월") {
        mon_start = start;
        mon_end = end;
      } else if (_workschedule[i].day == "화") {
        tue_start = start;
        tue_end = end;
      } else if (_workschedule[i].day == "수") {
        wed_start = start;
        wed_end = end;
      } else if (_workschedule[i].day == "목") {
        thu_start = start;
        thu_end = end;
      } else if (_workschedule[i].day == "금") {
        fri_start = start;
        fri_end = end;
      } else if (_workschedule[i].day == "토") {
        sat_start = start;
        sat_end = end;
      } else if (_workschedule[i].day == "일") {
        sun_start = start;
        sun_end = end;
      }
    }
  }

  _postWorkSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    String url =
        "http://${urlsrc}/albba/store/${storeId}/worker/setting/${widget.workerId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    _transWorkSchedule();

    var body = jsonEncode({
      "wage": int.parse(wage),
      "account": account,
      "activated": 1,
      "monStart": mon_start,
      "monEnd": mon_end,
      "tueStart": tue_start,
      "tueEnd": tue_end,
      "wedStart": wed_start,
      "wedEnd": wed_end,
      "thuStart": thu_start,
      "thuEnd": thu_end,
      "friStart": fri_start,
      "friEnd": fri_end,
      "satStart": sat_start,
      "satEnd": sat_end,
      "sunStart": sun_start,
      "sunEnd": sun_end
    });
    print("body: "+body);

    var response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "성공");
    } else {
      Fluttertoast.showToast(msg: "실패");
    }
  }

  _getWorkSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    storeId = (prefs.getInt('storeId') ?? 0);

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("storeId: " + storeId.toString());

    String url = "http://${urlsrc}/albba/store/${storeId}/worker/list/${widget.workerId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody:" + responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "성공");
      if (responseBody != null) {
        Map<String, dynamic> json = jsonDecode(responseBody);
        setState(() {
          wage = json["wage"].toString();
          account = json["account"];
          mon_start = json["monStart"];
          mon_end = json["monEnd"];
          tue_start = json["tueStart"];
          tue_end = json["tueEnd"];
          wed_start = json["wedStart"];
          wed_end = json["wedEnd"];
          thu_start = json["thuStart"];
          thu_end = json["thuEnd"];
          fri_start = json["friStart"];
          fri_end = json["friEnd"];
          sat_start = json["satStart"];
          sat_end = json["satEnd"];
          sun_start = json["sunStart"];
          sun_end = json["sunEnd"];
        });
        if (mon_start != "null") {
          var idx = mon_start.toString().indexOf(':');
          String starthour = mon_start.toString().substring(0, idx);
          String startminute =
          mon_start.toString().substring(idx + 1, mon_start.length);
          idx = mon_end.toString().indexOf(':');
          String endhour = mon_end.toString().substring(0, idx);
          String endminute =
          mon_end.toString().substring(idx + 1, mon_end.length);
          _workschedule.add(new WorkSchedule("월", starthour, startminute, endhour, endminute));
          print("월");
        }
        if (tue_start != "null") {
          var idx = tue_start.toString().indexOf(':');
          String starthour = tue_start.toString().substring(0, idx);
          String startminute =
          tue_start.toString().substring(idx + 1, tue_start.length);
          idx = tue_end.toString().indexOf(':');
          String endhour = tue_end.toString().substring(0, idx);
          String endminute =
          tue_end.toString().substring(idx + 1, tue_end.length);
          _workschedule.add(new WorkSchedule("화", starthour, startminute, endhour, endminute));
          print("화");
        }
        if (wed_start != "null") {
          var idx = wed_start.toString().indexOf(':');
          String starthour = wed_start.toString().substring(0, idx);
          String startminute =
          wed_start.toString().substring(idx + 1, wed_start.length);
          idx = wed_end.toString().indexOf(':');
          String endhour = wed_end.toString().substring(0, idx);
          String endminute =
          wed_end.toString().substring(idx + 1, wed_end.length);
          _workschedule.add(new WorkSchedule("수", starthour, startminute, endhour, endminute));
          print("수");
        }
        if (thu_start != "null") {
          var idx = thu_start.toString().indexOf(':');
          String starthour = thu_start.toString().substring(0, idx);
          String startminute =
          thu_start.toString().substring(idx + 1, thu_start.length);
          idx = thu_end.toString().indexOf(':');
          String endhour = thu_end.toString().substring(0, idx);
          String endminute =
          thu_end.toString().substring(idx + 1, thu_end.length);
          _workschedule.add(new WorkSchedule("목", starthour, startminute, endhour, endminute));
          print("목");
        }
        if (fri_start != "null") {
          var idx = fri_start.toString().indexOf(':');
          String starthour = fri_start.toString().substring(0, idx);
          String startminute =
          fri_start.toString().substring(idx + 1, fri_start.length);
          idx = fri_end.toString().indexOf(':');
          String endhour = fri_end.toString().substring(0, idx);
          String endminute =
          fri_end.toString().substring(idx + 1, fri_end.length);
          _workschedule.add(new WorkSchedule("금", starthour, startminute, endhour, endminute));
          print("금");
        }
        if (sat_start != "null") {
          var idx = sat_start.toString().indexOf(':');
          String starthour = sat_start.toString().substring(0, idx);
          String startminute =
          sat_start.toString().substring(idx + 1, sat_start.length);
          idx = sat_end.toString().indexOf(':');
          String endhour = sat_end.toString().substring(0, idx);
          String endminute =
          sat_end.toString().substring(idx + 1, sat_end.length);
          _workschedule.add(new WorkSchedule("토", starthour, startminute, endhour, endminute));
          print("토");
        }
        if (sun_start != "null") {
          var idx = sun_start.toString().indexOf(':');
          String starthour = sun_start.toString().substring(0, idx);
          String startminute =
          sun_start.toString().substring(idx + 1, sun_start.length);
          idx = sun_end.toString().indexOf(':');
          String endhour = sun_end.toString().substring(0, idx);
          String endminute =
          sun_end.toString().substring(idx + 1, sun_end.length);
          _workschedule.add(new WorkSchedule("일", starthour, startminute, endhour, endminute));
          print("일");
        }
      }
    } else {
      Fluttertoast.showToast(msg: "실패");
    }
  }

  @override
  void initState() {
    super.initState();
    _getWorkSchedule();
  }

  @override
  Widget build(BuildContext context) {
    List<String> hourList = inthourList.map((e) => e.toString()).toList();
    List<String> minuteList = intminuteList.map((e) => e.toString()).toList();
    var set = Set<String>();
    _dayList = dayList.where((value) => set.add(value)).toList();
    set = Set<String>();
    _hourList = hourList.where((value) => set.add(value)).toList();
    set = Set<String>();
    _minuteList = minuteList.where((value) => set.add(value)).toList();

    return MaterialApp(
      home: Scaffold(
        drawer: MenuBar_manager(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(MAINCOLOR)),
          title: Text('알바생 정보 수정',
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
                      builder: (context) => const AlertPage_manager()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              // 아이콘, 이름, 근무기간 컨테이너
              height: 90,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(SUBPINKCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // 아이콘 컨테이너
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Icon(
                      Icons.person,
                      color: Color(MAINCOLOR),
                      size: 50,
                    ),
                  ),
                  Container(
                    // 이름, 근무기간 컨테이너
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 이름
                          widget.workerName ?? "null",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // Text('2022.06.24 - 계속') // 근무기간
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              // 시급, 근무일정 컨테이너
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color(SUBCOLOR),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    // 시급 컨테이너
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text("시급 :  "),
                        Container(
                          width: 50,
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                wage = text;
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Color(MAINCOLOR)),
                              ),
                              hintText: wage,
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        Text(" 원"),
                      ],
                    ),
                  ),
                  Container(
                    // 근무일정 컨테이너
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("근무 일정 :  " ),),
                            Container(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      for (int i = 0;
                                      i < _workschedule.length;
                                      i++)
                                        WorkScheduleContainer(
                                            i,
                                            _workschedule[i].day,
                                            _workschedule[i].startHour,
                                            _workschedule[i].startMinute,
                                            _workschedule[i].endHour,
                                            _workschedule[i].endMinute)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _workschedule.add(new WorkSchedule.orgin());
                              _postWorkSchedule();
                            });
                          },
                          child: Icon(Icons.add, color: Color(MAINCOLOR)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // 계좌 컨테이너
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text("입금 계좌 :  "),
                        Container(
                          width: 150,
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                account = text;
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Color(MAINCOLOR)),
                              ),
                              hintText: account,
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              for(int i=0;i<_workschedule.length;i++){
                print(_workschedule[i].day+_workschedule[i].startHour);
              }
              _transWorkSchedule();
              print("mon: "+sun_start);
              _postWorkSchedule();
            });
            Navigator.of(context).pop();
          },
          child: Icon(Icons.check),
          backgroundColor: Color(MAINCOLOR),
        ),
      ),
    );
  }

  Widget WorkScheduleContainer(var i, var day, var startHour,
      var startMinute, var endHour, var endMinute) {
    return Container(
      child: Row(
        children: [
          DropdownButton(
            //요일
            value: day,
            items: _dayList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].day = value as String;
                print(value);
              });
            },
          ),
          Text("  "),
          DropdownButton(
            //시작 시
            value: int.parse(startHour).toString(),
            items: _hourList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].startHour = value as String;
                print(value);
              });
            },
          ),
          Text(" : "),
          DropdownButton(
            //시작 분
            value: int.parse(startMinute).toString(),
            items: _minuteList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].startMinute = value as String;
              });
            },
          ),
          Text("  ~  "),
          DropdownButton(
            //종료 시
            value: int.parse(endHour).toString(),
            items: _hourList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].endHour = value as String;
              });
            },
          ),
          Text(" : "),
          DropdownButton(
            //종료 분
            value: int.parse(endMinute).toString(),
            items: _minuteList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].endMinute = value as String;
              });
            },
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _workschedule.removeAt(i);
              });
            },
            child: Icon(Icons.remove, color: Color(MAINCOLOR)),
          ),
        ],
      ),
    );
  }
}

class WorkSchedule {
  // 근무일정 클래스

  var day = ""; // 요일
  var startHour = ""; // 시작 시
  var startMinute = ""; // 시작 분
  var endHour = ""; // 종료 시
  var endMinute = ""; // 종료 분

  WorkSchedule(
      this.day, this.startHour, this.startMinute, this.endHour, this.endMinute);

  WorkSchedule.orgin()
      : day = "월",
        startHour = "09",
        startMinute = "00",
        endHour = "12",
        endMinute = "30";

}
