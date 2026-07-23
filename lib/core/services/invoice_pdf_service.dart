import 'dart:typed_data';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../helper/arabic_text_helper.dart';

class InvoicePdfService {
  /// =========================
  /// 🌐 WEB → Bytes
  /// =========================
  static Future<Uint8List> generateInvoiceBytes({
    required String invoiceNumber,
    required String clientName,
    required String phone,
    required String address,
    List<Map<String, dynamic>>? items,
    required double total,
    required double subtotal,
    DateTime? invoiceDate,
    DateTime? dueDate,
  }) async {
    final pdf = pw.Document();

    final logoBytes =
    await rootBundle.load('assets/images/logo_without_back.png');
    final logo = pw.MemoryImage(logoBytes.buffer.asUint8List());

    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Regular.ttf'),
    );
    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Bold.ttf'),
    );


    pdf.addPage(
      _buildPage(
        logo: logo,
        invoiceNumber: invoiceNumber,
        clientName: clientName,
        phone: phone,
        address: address,
        items: items,
        total: total,
        regularFont: regularFont,
        boldFont: boldFont,
        invoiceDate: invoiceDate,
        dueDate: dueDate,
        subtotal: subtotal,
      ),
    );

    return pdf.save();
  }

  /// =========================
  /// 📱 MOBILE → File
  /// =========================
  static Future<File> generateInvoiceFile({
    required String invoiceNumber,
    required String clientName,
    required String phone,
    required String address,
    List<Map<String, dynamic>>? items,
    required double total,
    required double subtotal,
    DateTime? invoiceDate,
    DateTime? dueDate,

  }) async {
    final pdf = pw.Document();

    final logoBytes =
    await rootBundle.load('assets/images/logo_without_back.png');
    final logo = pw.MemoryImage(logoBytes.buffer.asUint8List());

    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Regular.ttf'),
    );
    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Bold.ttf'),
    );

    pdf.addPage(
      _buildPage(
        logo: logo,
        invoiceNumber: invoiceNumber,
        clientName: clientName,
        phone: phone,
        address: address,
        items: items,
        total: total,
        regularFont: regularFont,
        boldFont: boldFont,
        invoiceDate: invoiceDate,
        dueDate: dueDate,
        subtotal:  subtotal,
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/invoice_$invoiceNumber.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// =========================
  /// 📄 PAGE
  /// =========================
  static pw.Page _buildPage({
    required pw.ImageProvider logo,
    required String invoiceNumber,
    required String clientName,
    required String phone,
    required String address,
    List<Map<String, dynamic>>? items,
    required double total,
    required double subtotal,
    required pw.Font regularFont,
    required pw.Font boldFont,
    required DateTime? invoiceDate,
    required DateTime? dueDate,

  }) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        final fixedClientName = ArabicTextHelper.fix(clientName);
        final fixedAddress = ArabicTextHelper.fix(address);

        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: pw.Image(logo, width: 70)),
            pw.SizedBox(height: 12),

            pw.Center(
              child: pw.Text(
                'Meyar Al-Itqan',
                style: pw.TextStyle(
                  font: boldFont,
                  fontSize: 18,
                ),
              ),
            ),
            pw.Text(
              'Maintenance & Interior Design',
              style: pw.TextStyle(font: regularFont),
            ),

            pw.Divider(),

            pw.Text(
              'Email: meyar.alitqan@gmail.com | Phone: 07 8131 9003',
              style: pw.TextStyle(font: regularFont),
            ),
            pw.SizedBox(height: 24),

            pw.Text(
              'Tax Number (TIN): 18740456',
              style: pw.TextStyle(font: boldFont),
            ),
            pw.SizedBox(height: 24),
            pw.Text(
              'Invoice',
              style: pw.TextStyle(font: boldFont, fontSize: 14,),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Invoice No: $invoiceNumber',
              style: pw.TextStyle(font: regularFont),
            ),
            // pw.Text(
            //   'Invoice Date: ${DateFormat('yyyy-MM-dd').format(invoiceDate?? DateTime.now())}',
            //   style: pw.TextStyle(font: regularFont),
            // ),
            pw.Text(
              'Due Date: ${DateFormat('yyyy-MM-dd').format(dueDate ?? DateTime.now().add(const Duration(days: 7)))}',
              style: pw.TextStyle(font: regularFont),
            ),
            pw.SizedBox(height: 12),

            pw.Text(
              'Bill To:',
              style: pw.TextStyle(
                font: boldFont,
                fontSize: 14,
              ),
            ),
            pw.Text(
              'Client Name: $fixedClientName',
              style: pw.TextStyle(font: regularFont),
            ),



            pw.Text(
              'Phone: $phone',
              style: pw.TextStyle(font: regularFont),
            ),
            pw.Text(
              'Address: $fixedAddress',
              style: pw.TextStyle(font: regularFont),
            ),
            pw.SizedBox(height: 16),

            if (items != null && items.isNotEmpty)
              pw.Table.fromTextArray(
                headerStyle: pw.TextStyle(font: boldFont),
                cellStyle: pw.TextStyle(font: regularFont),
                headers: ['#', 'Description', 'Qty', 'Price', 'Total'],
                data: List.generate(items.length, (index) {
                  final item = items[index];
                  final qty = (item['qty'] as num).toDouble();
                  final price = (item['price'] as num).toDouble();

                  return [
                    '${index + 1}',
                    ArabicTextHelper.fix(item['name']),
                    qty.toString(),
                    price.toStringAsFixed(2),
                    (qty * price).toStringAsFixed(2),
                  ];
                }),
              ),


            pw.SizedBox(height: 12),
            pw.Text(
              'Subtotal: ${subtotal.toStringAsFixed(2)} JOD',
              style: pw.TextStyle(font: boldFont),
            ),


            pw.Text(
              'Total: ${total.toStringAsFixed(2)} JOD',
              style: pw.TextStyle(font: boldFont),
            ),
            pw.SizedBox(height: 24),

            pw.Text(
              'Notes:',
              style: pw.TextStyle(font: boldFont),
            ),
            pw.SizedBox(height: 8),
            // pw.Text('• No tax applied',
            //     style: pw.TextStyle(font: regularFont)),
            pw.Text('• Invoice valid for 7 days',
                style: pw.TextStyle(font: regularFont)),
            pw.Text('• Payment due upon receipt',
                style: pw.TextStyle(font: regularFont)),

            pw.SizedBox(height: 40),

            pw.Text(
              'Authorized Signature: ____________________',
              style: pw.TextStyle(font: regularFont),
            ),
            pw.SizedBox(height: 12),
            pw.Text(
              'Company Stamp',
              style: pw.TextStyle(font: regularFont),
            ),
          ],
        );
      },
    );
  }
}
