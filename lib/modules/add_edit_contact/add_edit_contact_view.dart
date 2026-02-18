import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app/constants/color_const.dart';
import '../../app/constants/string_const.dart';
import 'add_edit_contact_controller.dart';

class AddEditContactView extends GetView<AddEditContactController> {
  const AddEditContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.contactToEdit == null ? StringConst.kAddContact : StringConst.kEditContact),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Center(
                child: Obx(() {
                  final avatarColor = ColorConst.getAvatarColor(controller.nameController.text);
                  return CircleAvatar(
                    radius: 40,
                    backgroundColor: avatarColor,
                    foregroundColor: Colors.white,
                    child: Text(
                      controller.avatarLetter.value,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controller.nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: StringConst.kLabelFullName,
                  prefixIcon: Icon(FontAwesomeIcons.user),
                  border: OutlineInputBorder(),
                ),
                validator: controller.validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: StringConst.kLabelPhoneNumber,
                  prefixIcon: Icon(FontAwesomeIcons.phone),
                  border: OutlineInputBorder(),
                ),
                maxLength: 10,
                validator: controller.validatePhone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: StringConst.kLabelEmail,
                  prefixIcon: Icon(FontAwesomeIcons.envelope),
                  border: OutlineInputBorder(),
                ),
                validator: controller.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.companyController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: StringConst.kLabelCompany,
                  prefixIcon: Icon(FontAwesomeIcons.building),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.notesController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: StringConst.kLabelNotes,
                  prefixIcon: Icon(FontAwesomeIcons.noteSticky),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => SwitchListTile(
                  value: controller.isFavorite.value,
                  onChanged: (value) => controller.toggleFavorite(),
                  title: const Text(StringConst.kLabelMarkAsFavorite),
                  secondary: FaIcon(
                    controller.isFavorite.value ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                    color: controller.isFavorite.value ? Colors.amber : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isSaving.value ? null : controller.saveContact,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: controller.isSaving.value
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(
                          controller.contactToEdit == null
                              ? StringConst.kBtnSaveContact
                              : StringConst.kBtnUpdateContact,
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
