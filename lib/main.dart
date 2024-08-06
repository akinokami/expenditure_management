import 'package:expenditure_management/firebase_options.dart';
import 'package:expenditure_management/language/languages.dart';
import 'package:expenditure_management/splash_screen.dart';
import 'package:expenditure_management/utils/global.dart';
import 'package:expenditure_management/views/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          translations: Languages(),
          locale: Global.language == 'vi'
              ? const Locale('vi', 'VN')
              : const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          home: const SplashScreen(),
        );
      },
    );
  }
}
