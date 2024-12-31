import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:solutech/auth/mobile/sign_in.dart';
import 'package:solutech/auth/mobile/sign_up.dart';
import 'package:solutech/auth/onboarding/onboarding_questions.dart';
import 'package:solutech/auth/onboarding/onboarding_screen_1.dart';
import 'package:solutech/home/mobile/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCDiz5XZsR9FbxWH1EQ21KCVxR850S5sWE",
            authDomain: "habitquest-b5a20.firebaseapp.com",
            projectId: "habitquest-b5a20",
            storageBucket: "habitquest-b5a20.firebasestorage.app",
            messagingSenderId: "260752576315",
            appId: "1:260752576315:web:094bd759253fc68a05f11e"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInMobile(),
      debugShowCheckedModeBanner: false,
    );
  }
}
