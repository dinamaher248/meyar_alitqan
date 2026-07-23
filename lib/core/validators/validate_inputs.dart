import 'package:flutter/material.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

bool validateInputs(
  BuildContext context,
  AppLocalizations t,
  TextEditingController name,
  TextEditingController price,
  TextEditingController qty,
) {
  if (name.text.trim().isEmpty) {
    _showError(context, t.sparePartName);
    return false;
  }

  if (price.text.trim().isEmpty) {
    _showError(context, t.price);
    return false;
  }

  if (qty.text.trim().isEmpty) {
    _showError(context, t.quantity);
    return false;
  }

  final parsedPrice = double.tryParse(price.text);
  final parsedQty = int.tryParse(qty.text);

  if (parsedPrice == null || parsedPrice <= 0) {
    _showError(context, t.price);
    return false;
  }

  if (parsedQty == null || parsedQty <= 0) {
    _showError(context, t.quantity);
    return false;
  }

  return true;
}
void _showError(BuildContext context, String field) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("من فضلك أدخل قيمة صحيحة لـ $field"),
      backgroundColor: Colors.red,
    ),
  );
}
