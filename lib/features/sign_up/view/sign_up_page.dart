import 'package:flutter/material.dart';
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
          child: Column(
            children: [
              const Text(
                'K',
                style: TextStyle(
                    fontSize: 100,
                    color: Color(AppColors.primaryColor),
                    fontWeight: FontWeight.w700),
              ),
              TextFormField(),
              TextFormField(),

            ],
          ),
        ),
      ),
    );
  }
}
