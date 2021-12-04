import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_route_parser.dart';
import 'package:flutter_social/navigation/app_router.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appProvider = AppProvider();
  late AppRouter _appRouter;
  final routeParser = AppRouteParser();

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(appProvider: _appProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appProvider),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Social',
            theme: ThemeData(
              primarySwatch: Colors.lightGreen,
            ),
            routeInformationParser: routeParser,
            routerDelegate: _appRouter,
            backButtonDispatcher: RootBackButtonDispatcher(),
          );
        },
      ),
    );
  }
}
