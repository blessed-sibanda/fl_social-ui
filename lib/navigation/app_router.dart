import 'package:flutter/cupertino.dart';
import 'package:flutter_social/navigation/app_link.dart';
import 'package:flutter_social/screens/auth_screen.dart';
import 'package:flutter_social/screens/home_screen.dart';
import 'package:flutter_social/screens/splash_screen.dart';
import 'package:flutter_social/providers/app_provider.dart';

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
        HomeScreen.page,
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) return false;

    return true;
  }

  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    return;
  }

  AppLink getCurrentPath() {
    if (!appProvider.isLoggedIn) {
      return AppLink(location: AppLink.kAuthPath);
    } else {
      return AppLink(location: AppLink.kHomePath);
    }
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();
}
