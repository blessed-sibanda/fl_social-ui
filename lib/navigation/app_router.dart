import 'package:flutter/cupertino.dart';
import 'package:flutter_social/navigation/app_link.dart';
import 'package:flutter_social/pages/auth.dart';
import 'package:flutter_social/pages/home.dart';
import 'package:flutter_social/pages/splash.dart';
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
        if (!appProvider.isInitialized) SplashPage.page(),
        if (appProvider.isInitialized && !appProvider.isLoggedIn)
          AuthPage.page(),
        HomePage.page(),
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
