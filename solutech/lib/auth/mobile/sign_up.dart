import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solutech/auth/controller/auth_controller.dart';
import 'package:solutech/auth/widgets/logo_widget.dart';
import 'package:solutech/auth/widgets/sign_up_option_widget.dart';
import 'package:solutech/auth/widgets/social_icons.dart';
import 'package:solutech/common/widgets/auth_field.dart';
import 'package:solutech/common/widgets/rounded_button.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class SignUpMobile extends StatefulWidget {
  const SignUpMobile({super.key});

  @override
  State<SignUpMobile> createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {
  final controller = Get.put(SignUpController());
  final signIpController = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LogoWidget(),
            spaceH15,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RobotoCondensed(
                      text: 'Sign Up',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                    spaceH15,
                    AuthField(
                      controller: controller.email,
                      hintText: 'Email',
                    ),
                    spaceH15,
                    AuthField(
                      controller: controller.password,
                      isPassword: true,
                      fieldType: FieldType.password,
                      hintText: 'Password',
                    ),
                    spaceH15,
                    AuthField(
                      controller: controller.confirmPassword,
                      isPassword: true,
                      fieldType: FieldType.password,
                      hintText: 'Confirm Password',
                    ),
                    spaceH40,
                    RoundedButton(
                      label: 'Sign Up',
                      onPressed: () {
                        controller.register(
                          controller.email.text.trim(),
                          controller.password.text.trim(),
                          controller.confirmPassword.text.trim(),
                        );
                      },
                    ),
                    spaceH50,
                    const SignUpOptions(
                      text: 'or sign up with',
                    ),
                    spaceH50,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIcons(
                            onTap: () {},
                            socialLogo: "assets/icons/logos_facebook.png",
                            logoheight: 20,
                            logowidth: 20),
                        spaceW20,
                        SocialIcons(
                            onTap: () {
                              signIpController.loginWithGoogle();
                            },
                            socialLogo: "assets/icons/devicon_google.png",
                            logoheight: 20,
                            logowidth: 20),
                        spaceW20,
                        SocialIcons(
                          onTap: () {},
                          socialLogo: "assets/icons/logos_apple.png",
                          logoheight: 20,
                          logowidth: 20,
                        )
                      ],
                    ),
                    spaceH50,
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.onPrimary),
                          children: [
                            TextSpan(
                                text: ' Sign In',
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed('/sign-in');
                                  })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
