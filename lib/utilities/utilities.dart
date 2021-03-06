import 'package:passwordreminder/models/reminder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:password/password.dart';
import 'package:intl/intl.dart';

class Utilities {
  static Future<void> launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<String> getDefInterval() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String definterval;
    if (prefs.containsKey('definterval'))
      definterval = prefs.getString('definterval');
    else {
      await prefs.setString(
          'definterval', reminding_time.daily.toShortString());
      definterval = reminding_time.daily.toShortString();
    }
    return definterval;
  }

  static Future<bool> getAuthBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authBool;
    if (prefs.containsKey('authBool'))
      authBool = prefs.getBool('authBool');
    else {
      await prefs.setBool('authBool', false);
      authBool = false;
    }
    return authBool;
  }

  static Future<String> getDefRemindingTimeOfDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String defRemindingTimeOfDay;
    if (prefs.containsKey('defRemindingTimeOfDay'))
      defRemindingTimeOfDay = prefs.getString('defRemindingTimeOfDay');
    else {
      await prefs.setString('defRemindingTimeOfDay', "21:00");
      defRemindingTimeOfDay = reminding_time.daily.toShortString();
    }
    return defRemindingTimeOfDay;
  }

  static Future<bool> getBatteryOptimisation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool batteryOptimisation;
    if (prefs.containsKey('BatteryOptimisation'))
      batteryOptimisation = prefs.getBool('BatteryOptimisation');
    else {
      await prefs.setBool('BatteryOptimisation', false);
      batteryOptimisation = false;
    }
    return batteryOptimisation;
  }

  static Future<bool> getAutoStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool autostart;
    if (prefs.containsKey('autostart'))
      autostart = prefs.getBool('autostart');
    else {
      await prefs.setBool('autostart', false);
      autostart = false;
    }
    return autostart;
  }

  static Future<bool> setStringInPref(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> setBoolInPref(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<String> hash(String psswd) {
    final algorithm = PBKDF2();

    return Future(() {
      return Password.hash(psswd, algorithm);
    });
  }

  static Future<bool> verify(String psswd, String hash) {
    return Future(() {
      return Password.verify(psswd, hash);
    });
  }

  static String formatDate(DateTime date) {
    try {
      final DateFormat formatter = DateFormat('yyyyMMdd');
      return formatter.format(date);
    } catch (e) {
      return "";
    }
  }

  static bool is12hours(int _hours) {
    if (_hours <= 12)
      return true;
    else
      return false;
  }
}
