import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/providers/auth_page_provider.dart';
import 'package:flutter_social/widgets/signin_form.dart';
import 'package:flutter_social/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: AuthScreen(),
        name: AppPaths.authPath,
        key: ValueKey(AppPaths.authPath),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthPageProvider(),
      child: Consumer<AuthPageProvider>(
        builder: (_, authPageProvider, __) {
          return Scaffold(
            body: authPageProvider.onSignInPage
                ? const SignInForm()
                : const SignUpForm(),
          );
        },
      ),
    );
  }
}
