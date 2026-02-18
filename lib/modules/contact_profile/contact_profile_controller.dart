import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../../app/constants/string_const.dart';
import '../../app/routes/app_routes.dart';
import '../../data/database/database_service.dart';
import '../../data/models/contact_model.dart';
import '../contacts/contacts_controller.dart';

class ContactProfileController extends GetxController {
  final DatabaseService dbService = Get.find();

  late Rx<ContactModel> contact;
  RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is ContactModel) {
      contact = (Get.arguments as ContactModel).obs;
      isFavorite.value = contact.value.isFavorite;
    }
  }

  Future<void> refreshContact() async {
    try {
      final databaseService = Get.find<DatabaseService>();
      contact.value = (await databaseService.getContactById(contact.value.id!))!;
      isFavorite.value = contact.value.isFavorite;
    } catch (e) {}
  }

  Future<void> toggleFavorite() async {
    try {
      isFavorite.value = !isFavorite.value;
      final updatedContact = contact.value.copyWith(isFavorite: isFavorite.value);
      await dbService.updateContact(updatedContact);
      contact.value = updatedContact;

      // Update contacts list
      try {
        final contactsController = Get.find<ContactsController>();
        await contactsController.fetchContacts();
      } catch (e) {
        // Controller might not be loaded
      }

      Get.snackbar(
        StringConst.kSnackTitleSuccess,
        isFavorite.value ? StringConst.kSnackMsgAddedToFavorites : StringConst.kSackMsgRemovedFromFavorites,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(StringConst.kSnackTitleError, StringConst.kSnackMsgFavoriteFailed);
    }
  }

  void editContact() {
    Get.toNamed(AppRoutes.kAddEditContact, arguments: contact.value);
  }

  Future<void> makeCall() async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(contact.value.phone);
    // final Uri phoneUri = Uri(scheme: 'tel', path: contact.value.phone);
    // if (await canLaunchUrl(phoneUri)) {
    //   await launchUrl(phoneUri);
    // }
  }

  Future<void> deleteContact() async {
    Get.dialog(
      AlertDialog(
        title: const Text(StringConst.kDialogDeleteTitle),
        content: Text('Are you sure you want to delete ${contact.value.name}?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text(StringConst.kDialogDeleteCancel)),
          TextButton(
            onPressed: () async {
              try {
                await dbService.deleteContact(contact.value.id!);

                // Update contacts list
                try {
                  final contactsController = Get.find<ContactsController>();
                  await contactsController.fetchContacts();
                } catch (e) {
                  // Controller might not be loaded
                }

                Get.back(); // Close dialog
                Get.back(); // Close profile screen
                Get.snackbar(
                  StringConst.kSnackTitleDeleted,
                  StringConst.kSnackMsgContactDeleted,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } catch (e) {
                Get.back();
                Get.snackbar(StringConst.kSnackTitleError, StringConst.kSnackMsgDeleteFailed);
              }
            },
            child: const Text(StringConst.kDialogDeleteConfirm, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
