import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../app/constants/color_const.dart';
import '../../app/constants/string_const.dart';
import 'contact_profile_controller.dart';

class ContactProfileView extends GetView<ContactProfileController> {
  const ContactProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? ColorConst.kSurfaceDark : colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        actions: [
          Obx(() {
            return IconButton(
              icon: FaIcon(
                controller.isFavorite.value ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                color: controller.isFavorite.value ? Colors.amber : Colors.white,
                size: 20,
              ),
              onPressed: controller.toggleFavorite,
            );
          }),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.penToSquare, color: Colors.white, size: 20),
            onPressed: controller.editContact,
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.trashCan, color: Colors.red, size: 20),
            onPressed: controller.deleteContact,
          ),
          const SizedBox(width: 8),
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [ColorConst.kSurfaceDark, ColorConst.kSurfaceDark2]
                    : [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
              ),
            ),
          ),
        ),
      ),

      body: Obx(() {
        final contact = controller.contact.value;
        final avatarColor = ColorConst.getAvatarColorFromContact(contact.name, contact.phone);

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: SizedBox.shrink(),
              expandedHeight: 260,
              pinned: true,
              stretch: true,
              backgroundColor: avatarColor,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final double top = constraints.biggest.height;
                  final bool isCollapsed = top <= kToolbarHeight;

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.only(left: 16, top: 4),
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isCollapsed ? 1 : 0,
                      child: SizedBox(
                        height: kToolbarHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          spacing: 12,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Text(
                                contact.name.isNotEmpty ? contact.name[0].toUpperCase() : "",
                                style: TextStyle(color: avatarColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                contact.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isCollapsed ? 0 : 1,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Text(
                              contact.name.isNotEmpty ? contact.name[0].toUpperCase() : "",
                              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: avatarColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SliverToBoxAdapter(
              child: ColoredBox(
                color: avatarColor,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      _buildInfoBlock(
                        context,
                        icon: FontAwesomeIcons.phone,
                        iconColor: Colors.green,
                        label: StringConst.kInfoMobile,
                        value: contact.phone,
                        onTap: controller.makeCall,
                      ),

                      if (contact.email.isNotEmpty)
                        _buildInfoBlock(
                          context,
                          icon: FontAwesomeIcons.envelope,
                          iconColor: Colors.blue,
                          label: StringConst.kInfoEmail,
                          value: contact.email,
                        ),

                      if (contact.company != null && contact.company!.isNotEmpty)
                        _buildInfoBlock(
                          context,
                          icon: FontAwesomeIcons.building,
                          iconColor: Colors.orange,
                          label: StringConst.kInfoCompany,
                          value: contact.company!,
                        ),

                      if (contact.notes != null && contact.notes!.isNotEmpty)
                        _buildInfoBlock(
                          context,
                          icon: FontAwesomeIcons.noteSticky,
                          iconColor: Colors.purple,
                          label: StringConst.kInfoNotes,
                          value: contact.notes!,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInfoBlock(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? ColorConst.kSurfaceDark2 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: FaIcon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (onTap != null) Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
