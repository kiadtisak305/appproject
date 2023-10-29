import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28),
      ),
      backgroundColor: Colors.pink.shade400,
      centerTitle: true,
      toolbarHeight: 100,
      elevation: 30,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
