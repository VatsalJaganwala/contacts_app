import 'package:get/get.dart';

import '../../app/constants/string_const.dart';
import '../../data/database/database_service.dart';
import '../../data/models/contact_model.dart';

class ContactsController extends GetxController {
  final DatabaseService dbService = Get.find<DatabaseService>();

  RxList<ContactModel> contacts = <ContactModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      isLoading.value = true;
      final data = await dbService.getAllContacts();
      contacts.assignAll(data);
    } catch (e) {
      Get.snackbar(StringConst.kSnackTitleError, StringConst.kSnackMsgFetchFailed);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addContact(ContactModel contact) async {
    await dbService.insertContact(contact);
    await fetchContacts();
  }

  Future<void> updateContact(ContactModel contact) async {
    await dbService.updateContact(contact);
    await fetchContacts();
    Get.snackbar(StringConst.kSnackTitleUpdated, StringConst.kSnackMsgContactUpdated);
  }

  Future<void> deleteContact(int id) async {
    await dbService.deleteContact(id);
    contacts.removeWhere((contact) => contact.id == id);
    Get.snackbar(StringConst.kSnackTitleDeleted, StringConst.kSnackMsgContactDeleted);
  }

  Future<void> toggleFavorite(ContactModel contact) async {
    final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
    await dbService.updateContact(updatedContact);
    await fetchContacts();
  }
}
