import 'package:contacts_app/modules/contact_profile/contact_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/constants/string_const.dart';
import '../../data/database/database_service.dart';
import '../../data/models/contact_model.dart';
import '../contacts/contacts_controller.dart';

class AddEditContactController extends GetxController {
  final DatabaseService dbService = Get.find<DatabaseService>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final notesController = TextEditingController();

  RxBool isFavorite = false.obs;
  RxBool isSaving = false.obs;
  RxString avatarLetter = ''.obs;

  ContactModel? contactToEdit;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is ContactModel) {
      contactToEdit = Get.arguments as ContactModel;
      setFieldData();
    }

    nameController.addListener(() {
      if (nameController.text.isNotEmpty) {
        avatarLetter.value = nameController.text[0].toUpperCase();
      } else {
        avatarLetter.value = '';
      }
    });
  }

  void setFieldData() {
    if (contactToEdit != null) {
      nameController.text = contactToEdit!.name;
      phoneController.text = contactToEdit!.phone;
      emailController.text = contactToEdit!.email;
      companyController.text = contactToEdit!.company ?? '';
      notesController.text = contactToEdit!.notes ?? '';
      isFavorite.value = contactToEdit!.isFavorite;
      avatarLetter.value = contactToEdit!.name.isNotEmpty ? contactToEdit!.name[0].toUpperCase() : '';
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConst.kValidationNameRequired;
    }
    if (value.trim().length < 3) {
      return StringConst.kValidationNameTooShort;
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return StringConst.kValidationPhoneRequired;
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return StringConst.kValidationPhoneInvalid;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
        return StringConst.kValidationEmailInvalid;
      }
    }
    return null;
  }

  Future<void> saveContact() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isSaving.value = true;

      final contact = ContactModel(
        id: contactToEdit?.id,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        company: companyController.text.trim().isEmpty ? null : companyController.text.trim(),
        notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
        isFavorite: isFavorite.value,
        createdAt: contactToEdit?.createdAt ?? DateTime.now().toIso8601String(),
      );

      if (contactToEdit == null) {
        await dbService.insertContact(contact);
        try {
          final contactsController = Get.find<ContactsController>();
          await contactsController.fetchContacts();
        } catch (e) {}
        Get.back();
        Get.snackbar(
          StringConst.kSnackTitleSuccess,
          StringConst.kSnackMsgContactAdded,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        await dbService.updateContact(contact);
        try {
          final profileController = Get.find<ContactProfileController>();
          await profileController.refreshContact();
        } catch (e) {}
        Get.back();
        Get.snackbar(
          StringConst.kSnackTitleUpdated,
          StringConst.kSnackMsgContactUpdated,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(StringConst.kSnackTitleError, StringConst.kSnackMsgSaveFailed, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
