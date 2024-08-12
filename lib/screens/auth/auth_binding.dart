import 'package:get/instance_manager.dart';
import 'package:money_manager/screens/auth/auth_controller.dart';
import 'package:money_manager/services/auth/firebase_auth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(auth: AuthService.instance),
    );
  }
}
