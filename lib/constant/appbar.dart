import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/search/search_page.dart';

class NewAppBar extends StatelessWidget {
  const NewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const SearchPage());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 70, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Search for anything",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            Spacer(),
            Icon(Icons.camera_alt, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
