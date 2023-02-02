import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/privacy_policy/privacy_policy/view/pages/privacy_policy_page.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';
import 'package:konfiso/shared/capabiliities/email_validation_capability.dart';

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
  static const passwordMinLength = 6;

  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _privacyPolicyConsented = false;
  bool _formSubmitted = false;

  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void _changePrivacyPolicyConsented(bool? newPrivacyPolicyConsented) {
    setState(() {
      _privacyPolicyConsented = newPrivacyPolicyConsented ?? false;
    });
  }

  void _navigateToSignIn() {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
  }

  void _openPrivacyPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PrivacyPolicyPage(),
        fullscreenDialog: true,
      ),
    );
  }

  void _saveEmail(String? email) {
    _email = email;
  }

  void _savePassword(String? password) {
    _password = password;
  }

  void _submitForm() {
    setState(() {
      _formSubmitted = true;
    });
    final formIsValid = _formKey.currentState!.validate() && _privacyPolicyConsented;
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
    if (AppValidators.required(password)) {
      errorMessage = AppLocalizations.of(context)!.pleaseProvideAPassword;
    } else if (AppValidators.minLength(password!, passwordMinLength)) {
      errorMessage = AppLocalizations.of(context)!.shortPasswordMessage(passwordMinLength);
    }
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.privacyPolicyUrl);
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
              decoration:
                  InputDecoration(hintText: AppLocalizations.of(context)!.passwordMinCharacters(passwordMinLength)),
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
            height: 17,
          ),
          CheckboxListTile(
            value: _privacyPolicyConsented,
            onChanged: _changePrivacyPolicyConsented,
            controlAffinity: ListTileControlAffinity.leading,
            title: RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.iReadAndUnderstood,
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                      text: AppLocalizations.of(context)!.thePrivacyPolicy,
                      style: const TextStyle(color: AppColors.primaryColor),
                      recognizer: TapGestureRecognizer()..onTap = _openPrivacyPolicy),
                ],
              ),
            ),
            subtitle: !_privacyPolicyConsented && _formSubmitted
                ? Text(
                    AppLocalizations.of(context)!.pleaseAcceptThePrivacyPolicy,
                    style: const TextStyle(color: AppColors.primaryColor, fontSize: 12),
                  )
                : null,
          ),
          const SizedBox(
            height: 17,
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
