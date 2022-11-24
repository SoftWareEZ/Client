// 반환에 사용할 클래스
class ReturnValue{
  String? result;
  ReturnValue({this.result});
}
// 데이터 전달에 사용할 클래스
class Arguments {
  String arg;   // 전달에 사용할 데이터
  ReturnValue? returnValue; //반환때 사용할 클래스
  Arguments({this.arg: '', this.returnValue});
}