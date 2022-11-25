import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state_notifier.dart';
import 'package:konfiso/shared/capabiliities/email_form_capability.dart';

class ForgottenPasswordForm extends ConsumerStatefulWidget {
  const ForgottenPasswordForm({super.key});

  @override
  ConsumerState<ForgottenPasswordForm> createState() =>
      _ForgottenPasswordFormState();
}

class _ForgottenPasswordFormState extends ConsumerState<ForgottenPasswordForm>
    with EmailValidationCapability {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    ref.read(forgottenPasswordPageStateNotifierProvider.notifier).sendEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.emailAddress),
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Send Email'),
            ),
          ],
        ));
  }
}
