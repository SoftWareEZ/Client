import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  final KakaoInfo _login;
  String person = "";
  bool isLogined = false; //처음에는 로그인 안되어 있음
  String urlsrc = "";
  String token = "";
  String kakaoId = "";
  String nickname = "";
  String email = "";

  ViewModel(this._login) {}

  void setPerson(String person) {
    this.person = person;
  }

  Future login() async {
    isLogined = await _login.Info();
    if (isLogined) {
      User user = await UserApi.instance.me(); //현재 접속한 유저 로그인 정보 가져옴
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id.toString()}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');

      // 저장된 url 가져오기
      SharedPreferences prefs = await SharedPreferences.getInstance();
      urlsrc = (prefs.getString('urlsrc') ?? "null");
      print("urlsrc: " + urlsrc);

      // 카카오 로그인
      String url = "http://${urlsrc}/albba/kakao/login";
      Map<String, String>headers = {"Content-Type": "application/json"};
      var body = jsonEncode({
        "username": user!.id.toString(),
        "realname": user!.kakaoAccount!.profile!.nickname,
        "email": user!.kakaoAccount!.email!
      });
      print('${body}');
      var response = await http.post(Uri.parse(url), headers: headers, body: body);
      var responseBody = utf8.decode(response.bodyBytes);
      print("responseBody: ${responseBody}");

      // json에서 token 분리
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(responseBody);
        token = json["token"];
        print("token: ${token}");

        // 받은 token 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);

        _getUserInfo();
      } else {
        // 로그인 실패
      }
    }
  }

  _getUserInfo() async {
    int type = 0;
    if (person == "worker") {
      type = 0;
    } else if (person == "manager") {
      type = 1;
    }

    // 저장된 url 가져오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token') ?? "null");

    // 생성된 token 정보로 userinfo 요청
    // 전달된 내용 중 username, storeId만 디바이스 디스크에 저장한다.
    String url = "http://${urlsrc}/albba/userinfo/${type}";
    Map<String, String> headers = {"authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse(url), headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 200) {
      // userinfo 가져오기 성공
      Map<String, dynamic> json = jsonDecode(responseBody);
      int userId = json["userId"];
      String username = json["username"];
      String realname = json["realname"];
      int storeId = json["storeId"];

      // 받은 token 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("userId", userId);
      prefs.setString("username", username);
      prefs.setString("realname", realname);
      prefs.setInt("storeId", storeId);
    } else {
      // userinfo 가져오기 실패
    }
  }
}

class KakaoInfo {
  Future<bool> Info() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount(); //카카오계정으로 로그인 유도
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }
}
