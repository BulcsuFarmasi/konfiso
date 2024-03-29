import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state_notifier.dart';
import 'package:konfiso/shared/capabiliities/email_validation_capability.dart';

class ForgottenPasswordForm extends ConsumerStatefulWidget {
  const ForgottenPasswordForm({this.email, super.key});

  final String? email;

  @override
  ConsumerState<ForgottenPasswordForm> createState() => _ForgottenPasswordFormState();
}

class _ForgottenPasswordFormState extends ConsumerState<ForgottenPasswordForm> with EmailValidationCapability {
  final _formKey = GlobalKey<FormState>();

  String? _email;

  @override
  void initState() {
    super.initState();
    _email = widget.email;
  }

  void _saveEmail(String? newEmail) {
    _email = newEmail;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    ref.read(forgottenPasswordPageStateNotifierProvider.notifier).sendEmail(_email!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.emailAddress),
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onSaved: _saveEmail,
              initialValue: _email,
            ),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
              onPressed: _submitForm,
              child: Text(AppLocalizations.of(context)!.sendEmail),
            ),
          ],
        ));
  }
}
