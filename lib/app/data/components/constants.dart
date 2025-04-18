import 'package:flutter/material.dart';


class APIConstant {
  static String getState = 'state/106';
}

getInitialRoutes() async {
  // if (await sharedPref.get(SharedPref.isLogin, defaultValue: false)) {
  //   AppPages.INITIAL = Routes.RESTRO_DASHBOARD;
  // } else if (await sharedPref.get(SharedPref.onBoarding, defaultValue: false)) {
  //   AppPages.INITIAL = Routes.ROLEMANAGER;
  // } else {
  //   AppPages.INITIAL = Routes.ONBOARDING;
  // }
  // return true;
}

getUserdata() async {
  // await sharedPref.currentSavedUser.then((UserModel? userModel) {
  //   print("getUserdata $userModel");
  //   user = userModel;
  // });
}

disposeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
