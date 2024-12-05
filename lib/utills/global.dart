import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyticket/model/login_json.dart';

class GlobalClass {
  static String userRoleType = "";
  static String name = "";
  static String userId = "";
  static bool isLogin = false;

  setUserInfo(LoginJson login) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", true);
    pref.setString("name", login.data.name);
    pref.setString("userId", login.data.userId);
    pref.setString("roleType", login.data.role[0].name);
    setGlobalVariables();
  }

  resetUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    pref.setString("name", "");
    pref.setString("userId", "");
    pref.setString("roleType", "");
    isLogin = false;
    userId = "";
    name = "";
    userRoleType = "";
  }

  checkLoginStatus() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      isLogin = pref.getBool("isLogin")!;
    } catch (e) {
      //
    }
  }

  getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("userId")!;
  }

  getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString("name")!;
  }

  getRoleType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userRoleType = pref.getString("roleType")!;
  }

  setGlobalVariables() {
    checkLoginStatus();
    getName();
    getRoleType();
    getUserId();
  }
}
