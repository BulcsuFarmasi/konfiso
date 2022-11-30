import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/verify_user/view/pages/verify_user_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/features/loading/controller/loading_page_controller.dart';
import 'package:konfiso/shared/app_colors.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  static const routeName = '/loading';

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      ref.read(loadingPageControllerProvider).autoSignIn().then((UserSignInStatus userSignInStatus) {
        final navigator = Navigator.of(context);
        switch (userSignInStatus) {
          case UserSignInStatus.signedIn:
            navigator.pushReplacementNamed(BookHomePage.routeName);
            break;
          case UserSignInStatus.notSignedIn:
            navigator.pushReplacementNamed(SignInPage.routeName);
            break;
          case UserSignInStatus.notVerified:
            navigator.pushReplacementNamed(VerifyUserPage.routeName);
            break;
        }
        _isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.loading,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
