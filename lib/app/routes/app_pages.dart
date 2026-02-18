import 'package:contacts_app/app/bindings/global_binding.dart';
import 'package:get/get.dart';

import '../../modules/add_edit_contact/add_edit_contact_view.dart';
import '../../modules/contact_profile/contact_profile_view.dart';
import '../../modules/contacts/contacts_view.dart';
import '../../modules/home/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.kHome, page: () => const HomeView(), binding: GlobalBinding()),
    GetPage(name: AppRoutes.kContacts, page: () => ContactsView(), binding: GlobalBinding()),
    GetPage(name: AppRoutes.kAddEditContact, page: () => const AddEditContactView(), binding: GlobalBinding()),
    GetPage(name: AppRoutes.kContactProfile, page: () => const ContactProfileView(), binding: GlobalBinding()),
  ];
}
