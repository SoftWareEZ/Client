import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/bar/Menubar.dart';
import '../alert/AlertPage_manager.dart';
import '/bar/Bottombar.dart';
// import 'Menubar.dart';

// 사장용 알바생 관리 - 알바 정보 수정
class ManagementUpdatePage_manager extends StatefulWidget {
  const ManagementUpdatePage_manager({Key? key}) : super(key: key);

  @override
  State<ManagementUpdatePage_manager> createState() => ManagementUpdatePage();
}

class ManagementUpdatePage extends State<ManagementUpdatePage_manager> {
  final int MAINCOLOR = 0xffE94869;
  final int SUBCOLOR = 0xffF4F4F4;
  final int SUBPINKCOLOR = 0xffFDF6F8;
  // String _m="09:00";

  // int nnn=0;
  final List<String> _dayList = ['월', '화', '수', '목', '금', '토', '일'];
  final List<String> _EdayList = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  final List<int> _hourList = List.generate(24, (index) => index + 1);
  final List<int> _minuteList = List.generate(60, (index) => index);
  List<WorkSchedule> _workschedule = [
    // new WorkSchedule("화", 9, 0, 10, 0),
    // new WorkSchedule("목", 9, 0, 10, 0),
  ];
  String day="",start="",end="";
  String token = "", urlsrc = "", realname = "";
  int userId = 0, storeId = 0;
  String id = "", password = "";
  String wage = "9160",
      account = "1111-1111",
      mon_start= "null",
      mon_end= "null",
      tue_start= "null",
      tue_end= "null",
      wed_start= "null",
      wed_end= "null",
      thu_start= "null",
      thu_end= "null",
      fri_start= "null",
      fri_end= "null",
      sat_start= "null",
      sat_end= "null",
      sun_start= "null",
      sun_end= "null";

  var f = NumberFormat('00');
  // 근무일정 데이터
  _transWorkSchedule() async {
    for(int i=0;i<_workschedule.length;i++){
      start=f.format(_workschedule[i].startHour)+":"+f.format(_workschedule[i].startMinute);
      end=f.format(_workschedule[i].endHour)+":"+f.format(_workschedule[i].endMinute);
      if (_workschedule[i].day == "월") {
        mon_start=start;
        mon_end=end;
      }
      else if (_workschedule[i].day == "화") {
        tue_start=start;
        tue_end=end;
      }
      else if (_workschedule[i].day == "수") {
        wed_start=start;
        wed_end=end;
      }
      else if (_workschedule[i].day == "목") {
        thu_start=start;
        thu_end=end;
      }
      else if (_workschedule[i].day == "금") {
        fri_start=start;
        fri_end=end;
      }
      else if (_workschedule[i].day == "토") {
        sat_start=start;
        sat_end=end;
      }
      else if (_workschedule[i].day == "일") {
        sun_start=start;
        sun_end=end;
      }
    }
  }

  _postWorkSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "null");
    urlsrc = (prefs.getString('urlsrc') ?? "null");
    userId = (prefs.getInt('userId') ?? 0);
    storeId = (prefs.getInt('storeId') ?? 0);

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());
    print("storeId: " + storeId.toString());

    String url = "http://${urlsrc}/albba/store/${storeId}/worker/setting/${userId}";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    _transWorkSchedule();

    var body = jsonEncode({
      "wage": wage,
      "account": account,
      "mon_start": mon_start,
      "mon_end": mon_end,
      "tue_start": tue_start,
      "tue_end": tue_end,
      "wed_start": wed_start,
      "wed_end": wed_end,
      "thu_start": thu_start,
      "thu_end": thu_end,
      "fri_start": fri_start,
      "fri_end": fri_end,
      "sat_start": sat_start,
      "sat_end": sat_end,
      "sun_start": sun_start,
      "sun_end" : sun_end
    });

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
    userId = (prefs.getInt('userId') ?? 0);
    storeId = (prefs.getInt('storeId') ?? 0);

    print("token: " + token);
    print("urlsrc: " + urlsrc);
    print("userId: " + userId.toString());
    print("storeId: " + storeId.toString());

    String url = "http://${urlsrc}/albba/store/2/worker/list/1";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer ${token}",
    };
    var response =
    await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody:"+responseBody);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "성공");
      if(responseBody!=null) {
        Map<String, dynamic> json = jsonDecode(responseBody);
        setState(() {
          wage = json["wage"].toString();
          account = json["account"];
          mon_start = json["mon_start"];
          mon_end = json["mon_end"];
          tue_start = json["tue_start"];
          tue_end = json["tue_end"];
          wed_start = json["wed_start"];
          wed_end = json["wed_end"];
          thu_start = json["thu_start"];
          thu_end = json["thu_end"];
          fri_start = json["fri_start"];
          fri_end = json["fri_end"];
          sat_start = json["sat_start"];
          sat_end = json["sat_end"];
          sun_start = json["sun_start"];
          sun_end = json["sun_end"];
        });
        if (mon_start != "null") {
          List<String> starttime = mon_start.split(":");
          List<String> endtime = mon_end.split(":");
          new WorkSchedule(
              "월", starttime[0], starttime[1], endtime[0], endtime[1]);
        }
        else if (tue_start != "null") {
          List<String> starttime = (tue_start.split(":"));
          List<String> endtime = (tue_end.split(":"));
          new WorkSchedule(
              "화", starttime[0], starttime[1], endtime[0], endtime[1]);
        }
        else if (wed_start != "null") {
          List<String> starttime = wed_start.split(":");
          List<String> endtime = wed_end.split(":");
          new WorkSchedule(
              "수", starttime[0], starttime[1], endtime[0], endtime[1]);
        }
        else if (thu_start != "null") {
          List<String> starttime = thu_start.split(":");
          List<String> endtime = thu_end.split(":");
          new WorkSchedule(
              "목", starttime[0], starttime[1], endtime[0], endtime[1]);
        }
        else if (fri_start != "null") {
          List<String> starttime = fri_start.split(":");
          List<String> endtime = fri_end.split(":");
          new WorkSchedule(
              "금", starttime[0], starttime[1], endtime[0], endtime[1]);
        }
        else if (sat_start != "null") {
          List<String> starttime = sat_start.split(":");
          List<String> endtime = sat_end.split(":");
          new WorkSchedule(
              "토", starttime[0], starttime[1], endtime[0], endtime[1]);
        } else if (sun_start != "null") {
          List<String> starttime = sun_start.split(":");
          List<String> endtime = sun_end.split(":");
          new WorkSchedule(
              "일", starttime[0], starttime[1], endtime[0], endtime[1]);
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AlertPage_manager()),
                // );
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Column(
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
                              realname,
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
                                    borderSide:
                                    BorderSide(width: 2, color: Color(MAINCOLOR)),
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
                            Row(
                              children: [
                                Text("근무 일정 :  "),
                                Container(
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          for (int i = 0; i < _workschedule.length; i++)
                                            WorkScheduleContainer(i,_workschedule[i].day,_workschedule[i].startHour,_workschedule[i].startMinute,
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
                              onPressed: (){
                                _workschedule.add(new WorkSchedule("월", "0", "0", "0", "0"));
                                _getWorkSchedule();
                                print(_workschedule.length); //새로 정보 받아와야함
                              },
                              child: Icon(Icons.add,color: Color(MAINCOLOR)),
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
                                    borderSide:
                                    BorderSide(width: 2, color: Color(MAINCOLOR)),
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
          ],
        ),
        bottomNavigationBar: BottomBar_manager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
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
  Widget WorkScheduleContainer(int i,String day,String startHour,String startMinute,String endHour,String endMinute){
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
                _workschedule[i].day = value.toString();
                print(value);
              });
            },
          ),
          Text("  "),
          DropdownButton(
            //시작 시
            value: startHour,
            items: _hourList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].startHour = value.toString();
                print(value);
              });
            },
          ),
          Text(" : "),
          DropdownButton(
            //시작 분
            value: startMinute,
            items: _minuteList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].startMinute = value.toString();
              });
            },
          ),
          Text("  ~  "),
          DropdownButton(
            //종료 시
            value: endHour,
            items: _hourList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].endHour = value.toString();
              });
            },
          ),
          Text(" : "),
          DropdownButton(
            //종료 분
            value: endMinute,
            items: _minuteList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _workschedule[i].endMinute = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}

class WorkSchedule {
  // 근무일정 클래스

  // var f = NumberFormat('##:##');
  String day = ""; // 요일
  // int n = NumberFormat('00') as int;
  String startHour = ""; // 시작 시
  String startMinute = ""; // 시작 분
  String endHour = ""; // 종료 시
  String endMinute = ""; // 종료 분
  // var start=f.format(startHour);
  // String end="";

  WorkSchedule(
      String day, String startHour, String startMinute, String endHour, String endMinute) {
    this.day = day;
    this.startHour = startHour;
    this.startMinute = startMinute;
    this.endHour = endHour;
    this.endMinute = endMinute;
  }
}