import 'package:flutter/cupertino.dart';

enum ScreenSizes { small, medium, large }

class ScreenSize {
  static ScreenSizes _getSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width <= 576) return ScreenSizes.small;
    if (width > 576 && width <= 768) return ScreenSizes.medium;
    return ScreenSizes.large;
  }

  static bool isSmall(BuildContext context) =>
      _getSize(context) == ScreenSizes.small;

  static bool isMedium(BuildContext context) =>
      _getSize(context) == ScreenSizes.medium;

  static bool isLarge(BuildContext context) =>
      _getSize(context) == ScreenSizes.large;

  static EdgeInsets minPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      vertical: isLarge(context) ? 20.0 : 0.0,
      horizontal: isLarge(context) ? 30.0 : 0.0,
    );
  }
}
