import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app/constants/string_const.dart';
import 'contact_list_tile.dart';
import 'contacts_controller.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({super.key});

  final ContactsController controller = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final favoriteContacts = controller.contacts.where((contact) => contact.isFavorite).toList();

      if (favoriteContacts.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.star, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(StringConst.kNoFavoriteContacts, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        );
      }

      return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        padding: const EdgeInsets.all(12),
        itemCount: favoriteContacts.length,
        itemBuilder: (context, index) {
          final contact = favoriteContacts[index];

          return ContactListTile(contact: contact, controller: controller);
        },
      );
    });
  }
}
