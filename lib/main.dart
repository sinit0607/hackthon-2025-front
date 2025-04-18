import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:codesapp/firebase_options.dart';
import 'app/data/components/Helpers/shared_pref_helper.dart';
import 'app/data/components/initial_binding.dart';
import 'app/routes/app_pages.dart';

GetIt sl = GetIt.instance;

Future<void> main() async {
  sl.registerLazySingleton<SharedPref>(() => SharedPref());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    GetMaterialApp(
      title: "code'sapp",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      // home: VideoList(),
    ),
  );
}
