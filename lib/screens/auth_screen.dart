import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/providers/auth_page_provider.dart';
import 'package:flutter_social/widgets/signin_form.dart';
import 'package:flutter_social/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: const AuthScreen(),
        name: AppPages.authPath,
        key: ValueKey(AppPages.authPath),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthPageProvider(),
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
