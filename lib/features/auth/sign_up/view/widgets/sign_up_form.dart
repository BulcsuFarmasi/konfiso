import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  static const emailKey = Key('signUpEmail');
  static const passwordKey = Key('signUpPassword');
  static const otherPasswordKey = Key('signUpOtherPassword');

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
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

  String? _validateEmail(String? email) {
    String? errorMessage;
    if (AppValidators.required(email)) {
      errorMessage = Intl.message('Please write an email address');
    } else if (AppValidators.email(email!)) {
      errorMessage = Intl.message('Please put in a valid email address');
    }
    return errorMessage;
  }

  String? _validateOtherPassword(String? value) {
    String? errorMessage;
    if (AppValidators.passwordMatch(passwordController.text, value)) {
      errorMessage = Intl.message('Please write identical passwords');
    }
    return errorMessage;
  }

  String? _validatePassword(String? password) {
    String? errorMessage;
    const minLength = 6;
    if (AppValidators.required(password)) {
      errorMessage = Intl.message('Please write a password');
    } else if (AppValidators.minLength(password!, minLength)) {
      errorMessage =
          Intl.message('Please write at least $minLength characters');
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
            decoration:
                InputDecoration(hintText: Intl.message('Email address')),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
            onSaved: _saveEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            key: SignUpForm.passwordKey,
            decoration: InputDecoration(hintText: Intl.message('Password')),
            controller: passwordController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: _validatePassword,
            onSaved: _savePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              key: SignUpForm.otherPasswordKey,
              decoration:
                  InputDecoration(hintText: Intl.message('Password again')),
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: _validateOtherPassword),
          const SizedBox(
            height: 34,
          ),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(120, 41),
            ),
            child: Text(
              Intl.message('Signup'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Intl.message('If you have an account, '),
                  style: const TextStyle(
                      color: AppColors.greyColor, fontSize: 14)),
              GestureDetector(
                onTap: _navigateToSignIn,
                child: Text(Intl.message('log in'),
                    style: const TextStyle(color: AppColors.greyDarkerColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
