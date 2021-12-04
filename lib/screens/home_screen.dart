import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: const HomeScreen(),
        name: AppPages.homePath,
        key: ValueKey(AppPages.homePath),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MenuItems {
  static const people = 'People';
  static const myProfile = 'My Profile';
  static const signOut = 'Sign Out';

  static List<String> get smallScreen => [people, myProfile, signOut];
  static List<String> get bigScreen => [myProfile, signOut];
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = false;
    if (MediaQuery.of(context).size.width < 600) isSmallScreen = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Social'),
        automaticallyImplyLeading: false,
        actions: [
          isSmallScreen
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.home))
              : InkWell(
                  child: _buildMenuButton(icon: Icons.home, label: 'Home'),
                  onTap: () {},
                ),
          _buildDropdownMenu(isSmallScreen),
        ],
      ),
      body: const SafeArea(
        child: Center(child: Text('Home')),
      ),
    );
  }

  PopupMenuButton<String> _buildDropdownMenu(bool isSmallScreen) {
    var popUpMenuButton = isSmallScreen
        ? PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: _performAction,
            itemBuilder: (_) => _buildMenuItems(MenuItems.smallScreen),
          )
        : PopupMenuButton<String>(
            child:
                _buildMenuButton(icon: Icons.account_circle, label: 'Account'),
            onSelected: _performAction,
            itemBuilder: (_) => _buildMenuItems(MenuItems.bigScreen),
          );

    return popUpMenuButton;
  }

  Center _buildMenuButton({required IconData icon, required String label}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 5.0),
            Text(label),
          ],
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(List<String> menuItems) {
    return menuItems.map((item) {
      return PopupMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  void _performAction(valueSelected) {
    switch (valueSelected) {
      case MenuItems.signOut:
        Provider.of<AppProvider>(context, listen: false).logOut();
        break;
      default:
    }
  }
}
