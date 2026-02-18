import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app/constants/string_const.dart';
import '../../app/routes/app_routes.dart';
import '../contacts/contacts_view.dart';
import '../contacts/favorites_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConst.kAppTitle)),
      body: Obx(() {
        return IndexedStack(index: controller.selectedIndex.value, children: [ContactsView(), FavoritesView()]);
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.addressBook, size: 20),
              label: StringConst.kTabContacts,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidStar, size: 20),
              label: StringConst.kTabFavorites,
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.kAddEditContact);
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
