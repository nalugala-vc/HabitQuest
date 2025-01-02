import 'package:get/get.dart';
import 'package:solutech/auth/controller/auth_controller.dart';
import 'package:solutech/home/controller/habit_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => OTPController());
    Get.lazyPut(() => HabitController());
  }
}
