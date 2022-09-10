import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/shared/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Column(children: [
            const Text(
              'K',
              style: TextStyle(
                  fontSize: 100,
                  fontFamily: 'Arial MT Rounded',
                  color: Color(AppColors.primaryColor),
                  fontWeight: FontWeight.w700),
            ),
            TextFormField(),
            TextFormField(),
            ElevatedButton(
                onPressed: () {}, child: Text(Intl.message('Signup'))),
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
          ]),
        ),
      ),
    );
  }
}
