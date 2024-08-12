import 'package:get/instance_manager.dart';
import 'package:money_manager/screens/create_account/create_account_controller.dart';
import 'package:money_manager/services/auth/firebase_auth.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(auth: AuthService.instance),
    );
  }
}
