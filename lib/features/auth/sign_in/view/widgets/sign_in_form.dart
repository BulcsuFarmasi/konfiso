import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

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

  void _saveEmail(String? email) {
    _email = email;
  }

  void _savePassword(String? password) {
    _password = password;
  }

  void _submitForm() {
    final formIsValid = _formKey.currentState!.validate();
    if (formIsValid) {
      _formKey.currentState!.save();
    }
    final notifier = ref.read(signInPageNotiferProvider.notifier);
    notifier.signIn(_email!, _password!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration:
                InputDecoration(hintText: Intl.message('Email address')),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: _saveEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: Intl.message('Password')),
            textInputAction: TextInputAction.next,
            obscureText: true,
            onSaved: _savePassword,
          ),
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
              Text(
                Intl.message("If you don't have an account, "),
                style:
                    const TextStyle(color: AppColors.greyColor, fontSize: 14),
              ),
              GestureDetector(
                onTap: _navigateToSignUp,
                child: Text(Intl.message('sign up'),
                    style: const TextStyle(color: AppColors.greyDarkerColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
