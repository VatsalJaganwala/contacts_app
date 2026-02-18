import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app/constants/color_const.dart';
import '../../app/routes/app_routes.dart';
import '../../data/models/contact_model.dart';
import 'contacts_controller.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({super.key, required this.contact, required this.controller});

  final ContactModel contact;
  final ContactsController controller;

  @override
  Widget build(BuildContext context) {
    final avatarColor = ColorConst.getAvatarColorFromContact(contact.name, contact.phone);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: kElevationToShadow[1],
        color: Theme.of(context).colorScheme.surface,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: avatarColor,
            foregroundColor: Colors.white,
            child: Text(
              contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(contact.name),
          subtitle: Row(
            children: [const FaIcon(FontAwesomeIcons.phone, size: 12), const SizedBox(width: 6), Text(contact.phone)],
          ),
          trailing: Row(
            mainAxisSize: .min,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.phone, size: 20, color: Colors.green),
                onPressed: () async {
                  bool? res = await FlutterPhoneDirectCaller.callNumber(contact.phone);
                },
              ),

              IconButton(
                icon: FaIcon(
                  contact.isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                  color: contact.isFavorite ? Colors.amber : null,
                  size: 20,
                ),
                onPressed: () {
                  controller.toggleFavorite(contact);
                },
              ),
            ],
          ),
          onTap: () {
            Get.toNamed(AppRoutes.kContactProfile, arguments: contact);
          },
        ),
      ),
    );
  }
}
