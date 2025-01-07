import 'package:flutter/material.dart';
import 'package:solutech/auth/mobile/sign_in.dart';
import 'package:solutech/auth/web/sign_in_web.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const SignInWeb();
        } else {
          return const SignInMobile();
        }
      },
    );
  }
}
