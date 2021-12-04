import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/widgets/people_list.dart';
import 'package:flutter_social/widgets/posts_feed.dart';
import 'package:flutter_social/widgets/user_profile.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = false;
    if (MediaQuery.of(context).size.width < 600) isSmallScreen = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Social'),
        automaticallyImplyLeading: false,
        actions: [
          if (isSmallScreen)
            IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          if (!isSmallScreen)
            InkWell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: const [
                      Icon(Icons.home),
                      SizedBox(width: 5.0),
                      Text('Home'),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          _buildDropdownMenu(isSmallScreen),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [PostsFeed(), PeopleList(), UserProfile()],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.black54,
          unselectedLabelColor: Colors.black38,
          tabs: const [
            Tab(icon: Icon(Icons.feed), text: 'Feed'),
            Tab(icon: Icon(Icons.people), text: 'People'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
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
            child: InkWell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: const [
                      Icon(Icons.account_circle),
                      SizedBox(width: 5.0),
                      Text('Account'),
                    ],
                  ),
                ),
              ),
            ),
            onSelected: _performAction,
            itemBuilder: (_) => _buildMenuItems(MenuItems.bigScreen),
          );

    return popUpMenuButton;
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
