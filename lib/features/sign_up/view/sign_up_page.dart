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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Form(
          child: Column(children: [
            const SizedBox(
              height: 168,
            ),
            const Text(
              'K',
              style: TextStyle(
                  fontSize: 100,
                  fontFamily: 'Arial MT Rounded',
                  color: Color(AppColors.primaryColor),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 64,
            ),
            TextFormField(
              decoration:
                  InputDecoration(hintText: Intl.message('Email address')),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  InputDecoration(hintText: Intl.message('Password')),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
              InputDecoration(hintText: Intl.message('Password again')),
            ),
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(
                onPressed: () {}, child: Text(Intl.message('Signup'))),
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
          ]),
        ),
      ),
    );
  }
}
