class BaseListModel<T>{
  int _outarized;

  int get outarized => _outarized;

  set outarized(int value) {
    _outarized = value;
  }

   List<T> _datas;

  List<T> get datas => _datas;

  set datas(List<T> value) {
    _datas = value;
  }
}