import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';
import 'package:konfiso/shared/capabiliities/email_form_capability.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({required this.privacyPolicyUrl, super.key});

  final String privacyPolicyUrl;

  static const emailKey = Key('signUpEmail');
  static const passwordKey = Key('signUpPassword');
  static const otherPasswordKey = Key('signUpOtherPassword');

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> with EmailValidationCapability {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void _navigateToSignIn() {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
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
    final notifier = ref.read(signUpStateNotifierProvider.notifier);
    notifier.signUp(_email!, _password!);
  }

  String? _validateOtherPassword(String? value) {
    String? errorMessage;
    if (AppValidators.passwordMatch(passwordController.text, value)) {
      errorMessage = AppLocalizations.of(context)!.pleaseWriteIdenticalPasswords;
    }
    return errorMessage;
  }

  String? _validatePassword(String? password) {
    String? errorMessage;
    const minLength = 6;
    if (AppValidators.required(password)) {
      errorMessage = AppLocalizations.of(context)!.pleaseProvideAPassword;
    } else if (AppValidators.minLength(password!, minLength)) {
      errorMessage = AppLocalizations.of(context)!.shortPasswordMessage(minLength);
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
            key: SignUpForm.emailKey,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.emailAddress,
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: validateEmail,
            onSaved: _saveEmail,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              key: SignUpForm.passwordKey,
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
              controller: passwordController,
              textInputAction: TextInputAction.next,
              obscureText: true,
              validator: _validatePassword,
              onSaved: _savePassword,
              toolbarOptions: const ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              )),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            key: SignUpForm.otherPasswordKey,
            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.passwordAgain),
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: _validateOtherPassword,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 41),
            ),
            child: Text(AppLocalizations.of(context)!.signup),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.ifYouHaveAnAccount,
                  style: const TextStyle(color: AppColors.greyColor, fontSize: 14)),
              GestureDetector(
                onTap: _navigateToSignIn,
                child:
                    Text(AppLocalizations.of(context)!.logIn, style: const TextStyle(color: AppColors.greyDarkerColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
