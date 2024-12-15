class CategoryType{
  late String _id;
  late String _name;
  late bool _isSelected;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  set name(String value) {
    _name = value;
  }
}