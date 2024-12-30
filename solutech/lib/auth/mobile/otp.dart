import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:solutech/auth/controller/auth_controller.dart';
import 'package:solutech/common/widgets/rounded_button.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class OTPMobile extends StatefulWidget {
  const OTPMobile({super.key});

  @override
  State<OTPMobile> createState() => _OTPMobileState();
}

class _OTPMobileState extends State<OTPMobile> {
  var otp;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.27,
            child: Stack(
              children: [
                Positioned(
                  top: -screenHeight * 0.07,
                  right: -screenWidth * 0.05,
                  child: Image.asset(
                    'assets/icons/kaleido_logo.png',
                    width: screenWidth * 0.55,
                    height: screenWidth * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RobotoCondensed(
                  text: 'Check your email',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
                spaceH10,
                RobotoCondensed(
                    text: 'We\'ve sent an OTP code to your phone',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    textColor: AppColors.grey600),
                spaceH50,
                OtpTextField(
                  numberOfFields: 4,
                  enabledBorderColor: const Color.fromARGB(255, 255, 203, 182),
                  fieldWidth: 60,
                  fieldHeight: 60,
                  focusedBorderColor: AppColors.purple500,
                  borderColor: AppColors.purple500,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    otp = code;
                    OTPController.instance.verifyOTP(otp);
                  },
                  onSubmit: (String verificationCode) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        });
                  },
                ),
                spaceH50,
                RoundedButton(
                  label: 'Verify',
                  onPressed: () {},
                ),
                spaceH25,
                RoundedButton(
                  label: 'Send again',
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  border: true,
                  textColor: AppColors.purple500,
                  onPressed: () {
                    OTPController.instance.verifyOTP(otp);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
