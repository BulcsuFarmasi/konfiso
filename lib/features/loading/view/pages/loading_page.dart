import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/book/book_home/view/book_home_page.dart';
import 'package:konfiso/features/loading/controller/loading_page_state_notifier.dart';
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
      ref.read(loadingPageStateNotifierProvider.notifier).autoSignIn().then((bool isUserSignedIn) {
        final navigator = Navigator.of(context);
        if (isUserSignedIn) {
          navigator.pushReplacementNamed(BookHomePage.routeName);
        } else {
          navigator.pushReplacementNamed(SignInPage.routeName);
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
              Intl.message('Loading'),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
