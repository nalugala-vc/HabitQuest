import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:solutech/auth/mobile/sign_in.dart';
import 'package:solutech/auth/onboarding/onboarding_questions.dart';
import 'package:solutech/auth/onboarding/onboarding_screen_1.dart';
import 'package:solutech/auth/sign_in.dart';
import 'package:solutech/auth/sign_up.dart';
import 'package:solutech/core/di/app_bindings.dart';
import 'package:solutech/home/create_habit.dart';
import 'package:solutech/home/homepage.dart';
import 'package:solutech/initial_page.dart';
import 'package:solutech/profile/profile_page.dart';

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

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } else {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        initialBinding: AppBindings(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SignInMobile(),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => const InitialPage()),
          GetPage(name: '/sign-in', page: () => const SignIn()),
          GetPage(name: '/sign-up', page: () => const SignUp()),
          GetPage(name: '/homepage', page: () => const Homepage()),
          GetPage(name: '/onboarding', page: () => OnboardingScreen()),
          GetPage(name: '/onboarding-qs', page: () => OnboardingQuestions()),
          GetPage(name: '/create-habit', page: () => const CreateHabit()),
          GetPage(name: '/profile-page', page: () => const ProfilePage()),
        ]);
  }
}
