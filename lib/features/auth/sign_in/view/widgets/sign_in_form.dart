import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/view/pages/forgotten_password_page.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  static const emailKey = Key('signInEmail');
  static const passwordKey = Key('signInPassword');

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  void _navigateToSignUp() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
  }

  void _navigateToForgottenPassword() {
    Navigator.of(context).pushNamed(ForgottenPasswordPage.routeName);
  }

  void _saveEmail(String? email) {
    _email = email;
  }

  void _savePassword(String? password) {
    _password = password;
  }

  void _submitForm() {
    final formIsValid = _formKey.currentState!.validate();
    if (!formIsValid) {
      return;
    }
    _formKey.currentState!.save();
    final notifier = ref.read(signInPageNotiferProvider.notifier);
    notifier.signIn(_email!, _password!);
  }

  String? _validateEmail(String? email) {
    String? errorMessage;
    if (AppValidators.required(email)) {
      errorMessage = AppLocalizations.of(context)!.pleaseProvideAnEmailAddress;
    }
    return errorMessage;
  }

  String? _validatePassword(String? password) {
    String? errorMessage;
    if (AppValidators.required(password)) {
      errorMessage = AppLocalizations.of(context)!.pleaseProvideAPassword;
    }
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: SignInForm.emailKey,
            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.emailAddress),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
            onSaved: _saveEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            key: SignInForm.passwordKey,
            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: _validatePassword,
            onSaved: _savePassword,
          ),
          const SizedBox(
            height: 34,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: _navigateToForgottenPassword,
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                  ),
                )),
          ),
          const SizedBox(
            height: 34,
          ),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 41),
            ),
            child: Text(
              AppLocalizations.of(context)!.login,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.ifYouDontHaveAnAccount,
                style: const TextStyle(color: AppColors.greyColor, fontSize: 14),
              ),
              GestureDetector(
                onTap: _navigateToSignUp,
                child: Text(AppLocalizations.of(context)!.signUp,
                    style: const TextStyle(color: AppColors.greyDarkerColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
