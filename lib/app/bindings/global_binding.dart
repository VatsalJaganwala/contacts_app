import 'package:get/get.dart';

import '../../data/database/database_service.dart';
import '../../modules/add_edit_contact/add_edit_contact_controller.dart';
import '../../modules/contact_profile/contact_profile_controller.dart';
import '../../modules/contacts/contacts_controller.dart';
import '../../modules/home/home_controller.dart';
import '../theme/theme_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseService>(() => DatabaseService());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ContactsController>(() => ContactsController());
    Get.lazyPut<AddEditContactController>(() => AddEditContactController());
    Get.lazyPut<ContactProfileController>(() => ContactProfileController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
