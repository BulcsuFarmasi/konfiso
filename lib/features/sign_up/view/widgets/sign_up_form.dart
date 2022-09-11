import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/sign_up/controller/sign_up_state_notifier.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  final passwordController = TextEditingController();

  void _submitForm() {
    final formIsValid = _formKey.currentState!.validate();
    if (formIsValid) {
      _formKey.currentState!.save();
    }
    final notifier = ref.read(signUpStateNotifierProvider.notifier);
    notifier.signUp(_email!, _password!);
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
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
            validator: (String? value) {
              String? errorMessage;
              if (AppValidators.required(value)) {
                errorMessage = Intl.message('Please write an email address');
              } else if (AppValidators.email(value)) {
                errorMessage =
                    Intl.message('Please put in a valid email address');
              }
              return errorMessage;
            },
            onSaved: (String? value) {
              _email = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: Intl.message('Password')),
            controller: passwordController,
            obscureText: true,
            validator: (String? value) {
              String? errorMessage;
              const minLength = 6;
              if (AppValidators.required(value)) {
                errorMessage = Intl.message('Please write a password');
              } else if (AppValidators.minLength(value, minLength)) {
                errorMessage =
                    Intl.message('Please write at least $minLength characters');
              }
              return errorMessage;
            },
            onSaved: (String? value) {
              _password = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration:
                InputDecoration(hintText: Intl.message('Password again')),
            obscureText: true,
            validator: (String? value) {
              String? errorMessage;
              if (AppValidators.passwordMatch(passwordController.text, value)) {
                errorMessage = Intl.message('Please write identical passwords');
              }
              return errorMessage;
            },
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
              Text(Intl.message('If you have an account, '),
                  style: const TextStyle(
                      color: AppColors.greyColor, fontSize: 14)),
              GestureDetector(
                onTap: () {
                  print('login');
                },
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
