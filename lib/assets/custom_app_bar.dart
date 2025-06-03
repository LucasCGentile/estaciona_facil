import 'package:flutter/material.dart';
import 'package:estaciona_facil/assets/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAvatarTap;
  final TextEditingController? searchController;
  final String hintText;

  const CustomAppBar({
    super.key,
    required this.onAvatarTap,
    this.searchController,
    this.hintText = 'O que você procura ?',
  });

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.corPrincipal,
      automaticallyImplyLeading: false,
      toolbarHeight: 75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      title: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.person, color: AppColors.corPrincipal, size: 28),
              onPressed: onAvatarTap,
            ),
          ),

          const SizedBox(width: 12),

          // Campo de busca
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
