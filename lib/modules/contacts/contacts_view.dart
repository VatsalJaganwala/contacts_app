import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/constants/string_const.dart';
import 'contact_list_tile.dart';
import 'contacts_controller.dart';

class ContactsView extends StatelessWidget {
  ContactsView({super.key});

  final ContactsController controller = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.contacts.isEmpty) {
        return const Center(child: Text(StringConst.kNoContactsFound));
      }

      return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        padding: const EdgeInsets.all(12),
        itemCount: controller.contacts.length,
        itemBuilder: (context, index) {
          final contact = controller.contacts[index];

          return ContactListTile(contact: contact, controller: controller);
        },
      );
    });
  }
}
