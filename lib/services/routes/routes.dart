import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:money_manager/screens/auth/auth_binding.dart';
import 'package:money_manager/screens/auth/auth_screen.dart';
import 'package:money_manager/screens/create_account/create_account_binding.dart';
import 'package:money_manager/screens/create_account/create_account_screen.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_bindings.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_screen.dart';
import 'package:money_manager/screens/dashboard/dashbaord_screen.dart';
import 'package:money_manager/screens/dashboard/dashboard_binding.dart';
import 'package:money_manager/screens/settings/settings_binding.dart';
import 'package:money_manager/screens/settings/settings_screen.dart';
import 'package:money_manager/screens/transaction_history/transaction_history_bindings.dart';
import 'package:money_manager/screens/transaction_history/transaction_history_screen.dart';

class Routes {
  Routes._();
  static final Routes instance = Routes._();

  List<GetPage> getGetXPages() {
    return [
      GetPage(
        name: AuthScreen.routeName,
        page: () => const AuthScreen(),
        binding: AuthBinding(),
        maintainState: false,
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: CreateAccountScreen.routeName,
        page: () => const CreateAccountScreen(),
        binding: CreateAccountBinding(),
        maintainState: false,
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: DashbaordScreen.routeName,
        page: () => const DashbaordScreen(),
        binding: DashboardBinding(),
        maintainState: false,
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: CreateTransactionScreen.routeName,
        page: () => const CreateTransactionScreen(),
        binding: CreateTransactionBindings(),
        maintainState: false,
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: TransactionHistoryScreen.routeName,
        page: () => const TransactionHistoryScreen(),
        binding: TransactionHistoryBindings(),
        maintainState: false,
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: SettingsScreen.routeName,
        page: () => const SettingsScreen(),
        binding: SettingsBinding(),
        maintainState: false,
        transition: Transition.fadeIn,
      ),
    ];
  }
}
