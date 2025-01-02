import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BaseController extends GetxController {
  var isLoading = RxBool(false);

  setBusy(bool value) {
    isLoading.value = value;
  }
}
