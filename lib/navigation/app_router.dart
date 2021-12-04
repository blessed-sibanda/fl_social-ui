import 'package:flutter/cupertino.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/navigation/app_link.dart';
import 'package:flutter_social/screens/auth_screen.dart';
import 'package:flutter_social/screens/home_screen.dart';
import 'package:flutter_social/screens/splash_screen.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/screens/user_profile_screen.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppProvider appProvider;

  AppRouter({
    required this.appProvider,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appProvider.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appProvider.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appProvider.isInitialized) SplashScreen.page,
        if (appProvider.isInitialized && !appProvider.isLoggedIn)
          AuthScreen.page,
        if (appProvider.isLoggedIn && appProvider.didSelectUser)
          UserProfileScreen.page,
        if (appProvider.isLoggedIn && !appProvider.didSelectUser)
          HomeScreen.page,
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) return false;

    if (route.settings.name == AppPages.userPath) {
      appProvider.goToHome();
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    switch (configuration.location) {
      case AppPages.userPath:
        appProvider.goToProfile();
        break;
      case AppPages.homePath:
        appProvider.goToHome();
        break;
      default:
        break;
    }
  }

  AppLink getCurrentPath() {
    if (!appProvider.isLoggedIn) {
      return AppLink(location: AppPages.authPath);
    } else if (appProvider.didSelectUser) {
      return AppLink(location: AppPages.userPath);
    } else {
      return AppLink(location: AppPages.homePath);
    }
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();
}
