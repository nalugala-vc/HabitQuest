import 'package:flutter/material.dart';
import 'package:solutech/auth/mobile/sign_up.dart';
import 'package:solutech/auth/web/sign_up_web.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const SignUpWeb();
        } else {
          return const SignUpMobile();
        }
      },
    );
  }
}
