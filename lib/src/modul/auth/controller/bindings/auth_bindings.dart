import 'package:get/get.dart';
import 'package:todoapp/src/modul/auth/controller/auth_controller.dart';
import 'package:todoapp/src/utils/theme.dart';

class AuthBinginds extends Bindings {
  // Create Pipeline between contrller to UI
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    // It will help us to load controller to Ui
  }
}
