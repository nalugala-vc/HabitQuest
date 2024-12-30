import 'package:flutter/material.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/dimensions.dart';

class SignInMobile extends StatefulWidget {
  const SignInMobile({super.key});

  @override
  State<SignInMobile> createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              color: AppColors.purple100,
              height: 300,
              child: const Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: AppColors.purple400,
                  child: Image(
                    image: AssetImage('assets/icons/logo.png'),
                    height: 90,
                    width: 90,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
