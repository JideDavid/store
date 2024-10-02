import 'package:flutter/foundation.dart';
import '../services/pref_helper.dart';

class UserSettingsProvider extends ChangeNotifier{
  bool isLightMode = true;
  bool balIsHidden = false;
  List<String> interests = [];

  changeLightMode(){
    //changing theme mode
    isLightMode = !isLightMode;
    //saving theme mode to device
    PrefHelper().setThemeMode(isLightMode);
    notifyListeners();
  }

  getSavedThemeMode() async{
    //setting theme mode from last save on device
    isLightMode = await PrefHelper().getThemeMode();
    notifyListeners();
  }

}