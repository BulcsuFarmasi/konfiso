import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpSuccessful extends StatelessWidget {
  const SignUpSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 168,
        ),
        const EntryLogo(),
        const SizedBox(
          height: 64,
        ),
        Text(
          Intl.message('Successful registration!'),
          style: const TextStyle(color: AppColors.greyColor, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          Intl.message('Now you can login here'),
          style:
              const TextStyle(color: AppColors.greyDarkerColor, fontSize: 20),
        ),
      ],
    );
  }
}
