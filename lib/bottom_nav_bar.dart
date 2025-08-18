import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shoppng_app/pages/cart/cart_page.dart';
import 'package:shoppng_app/pages/home/home_page.dart';
import 'package:shoppng_app/pages/profile/profile_page.dart';
import 'package:shoppng_app/pages/wishlist/wishlist_page.dart';


class BottomNavBar extends StatefulWidget {
   BottomNavBar({super.key});

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProfilePage(),
    CartPage(),
    WishlistPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(

              rippleColor: Colors.grey,
              hoverColor: Colors.blue[200]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue[200]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
                GButton(
                  icon: Icons.shopping_bag_outlined,
                  text: 'Cart',
                ),
                GButton(
                  icon: CupertinoIcons.heart,
                  text: 'wishlist',
                ),

              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
