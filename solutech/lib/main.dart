import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePageMobile(),
      debugShowCheckedModeBanner: false,
    );
  }
}
