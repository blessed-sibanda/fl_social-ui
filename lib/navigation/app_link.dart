import 'package:flutter_social/models/app_pages.dart';

class AppLink {
  // Constants for each query parameter
  static const String kUserIdParam = 'userId';

  String? location;
  String? userId;

  AppLink({this.location, this.userId});

  static AppLink fromLocation(String location) {
    location = Uri.decodeFull(location);
    final uri = Uri.parse(location);
    final params = uri.queryParameters;

    void trySet(String key, void Function(String) setter) {
      if (params.containsKey(key)) setter.call(params[key]!);
    }

    final link = AppLink()..location = uri.path;

    trySet(AppLink.kUserIdParam, (s) => link.userId = s);

    return link;
  }

  String toLocation() {
    String addKeyValuePair({String? key, String? value}) =>
        value == null ? '' : '$key=$value';

    switch (location) {
      case AppPages.authPath:
        return AppPages.authPath;

      case AppPages.userPath:
        var loc = '${AppPages.userPath}?';
        loc += addKeyValuePair(key: kUserIdParam, value: userId);
        return Uri.encodeFull(loc);

      default:
        return AppPages.homePath;
    }
  }
}
