import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/auth/controller/sign_in_controller.dart';
import 'package:solutech/auth/widgets/auth_field.dart';
import 'package:solutech/auth/widgets/logo_widget.dart';
import 'package:solutech/utils/fonts/poppins.dart';
import 'package:solutech/utils/spacers.dart';

class SignInMobile extends StatefulWidget {
  const SignInMobile({super.key});

  @override
  State<SignInMobile> createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {
  final controller = Get.put(SignInController());
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
                    Poppins(
                      text: 'Sign In',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                    spaceH15,
                    AuthField(
                      controller: controller.email,
                      hintText: 'Email',
                    ),
                    spaceH25,
                    AuthField(
                      controller: controller.password,
                      isPassword: true,
                      fieldType: FieldType.password,
                      hintText: 'Password',
                    ),
                    spaceH40,
                    RoundedButton(
                      label: 'Sign In',
                      onPressed: () {},
                    ),
                    spaceH50,
                    const SignUpOptions(
                      text: 'or sign in with',
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
                            onTap: () {},
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
                          style: GoogleFonts.pragatiNarrow(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: KaleidoColors.greyPlaceholder),
                          children: [
                            TextSpan(
                                text: ' Sign up',
                                style: GoogleFonts.pragatiNarrow(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: KaleidoColors.orangeMain),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAll(() => const SignUp());
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
