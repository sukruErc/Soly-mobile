import 'package:intl/intl.dart';

extension MyDateFormat on DateTime {
  String? myDateFormat(String pattern) {
    try {
      return DateFormat(pattern).format(this);
    } catch (e) {
      return null;
    }
  }
}

extension GetDay on DateTime {
  String? getDay() {
    try {
      return this.day.toString();
    } catch (e) {
      return null;
    }
  }
}

extension GetMonthShortName on DateTime {
  String? getMonthShortName() {
    try {
      String dayNameTR = DateFormat('MMM').format(this);
      return dayNameTR;
    } catch (e) {
      return null;
    }
  }
}

extension GetYear on DateTime {
  String? getYear() {
    try {
      return this.year.toString();
    } catch (e) {
      return null;
    }
  }
}
