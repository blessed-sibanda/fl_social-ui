import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/providers/auth_page_provider.dart';
import 'package:flutter_social/widgets/signin_form.dart';
import 'package:flutter_social/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: const AuthPage(),
      name: AppPages.authPath,
      key: ValueKey(AppPages.authPath),
    );
  }

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _authPageProvider = AuthPageProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _authPageProvider),
      ],
      child: Consumer<AuthPageProvider>(
        builder: (context, authPageProvider, child) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: authPageProvider.onSignInPage
                    ? const SignInForm()
                    : const SignUpForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}
