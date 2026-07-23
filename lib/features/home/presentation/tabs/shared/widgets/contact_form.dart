import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/components/custom_text_field.dart';
import 'package:meayar_alitqan/core/services/whatsapp_service.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/core/utils/strings_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
 

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final message = '''
${StringsManager.contactNameHint}: ${_nameController.text}
${StringsManager.contactEmail}: ${_emailController.text}

${StringsManager.contactMessageHint}:
${_messageController.text}
''';

    WhatsAppService.openChat(
      phone: StringsManager.phoneNumber,
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                CustomTextFormField(
                  textEditingController: _nameController,
                  hintText:  AppLocalizations.of(context)!.contact_name_hint,
                  validator: (v) =>
                      v == null || v.isEmpty ?  AppLocalizations.of(context)!.requiredField : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  textEditingController: _emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return  AppLocalizations.of(context)!.requiredField;
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                      return      AppLocalizations.of(context)!.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  textEditingController: _messageController,
                  hintText:  AppLocalizations.of(context)!.contact_message_hint,
                  maxLines: 5,
                  validator: (v) =>
                      v == null || v.isEmpty ?  AppLocalizations.of(context)!.requiredField : null,
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => _submit(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.contact_send_button,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
