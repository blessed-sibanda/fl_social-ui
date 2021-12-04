import 'package:flutter/cupertino.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/navigation/app_link.dart';
import 'package:flutter_social/screens/auth_screen.dart';
import 'package:flutter_social/screens/home_screen.dart';
import 'package:flutter_social/screens/people_screen.dart';
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
        if (appProvider.isInitialized && appProvider.isLoggedIn)
          HomeScreen.page,
        if (appProvider.isInitialized &&
            appProvider.isLoggedIn &&
            appProvider.didSelectUser)
          UserProfileScreen.page,
        if (appProvider.isInitialized &&
            appProvider.isLoggedIn &&
            appProvider.onPeople)
          PeopleScreen.page,
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) return false;

    if (route.settings.name == AppPaths.userPath) {
      appProvider.goToHome();
    }

    if (route.settings.name == AppPaths.peoplePath) {
      appProvider.goToHome();
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    switch (configuration.location) {
      case AppPaths.userPath:
        appProvider.goToProfile();
        break;
      case AppPaths.peoplePath:
        appProvider.goToPeople();
        break;
      case AppPaths.homePath:
        appProvider.goToHome();
        break;
      default:
        break;
    }
  }

  AppLink getCurrentPath() {
    if (!appProvider.isLoggedIn) {
      return AppLink(location: AppPaths.authPath);
    } else if (appProvider.didSelectUser) {
      return AppLink(location: AppPaths.userPath);
    } else if (appProvider.onPeople) {
      return AppLink(location: AppPaths.peoplePath);
    } else {
      return AppLink(location: AppPaths.homePath);
    }
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();
}
