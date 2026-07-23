import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import 'package:meayar_alitqan/core/services/invoice_pdf_service.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/order_entity/order_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model_states.dart';

import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model_states.dart';

import '../../../../../core/components/confirmation_dialog.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/enums/order_status.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../l10n/app_localizations.dart';

import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model_states.dart';
import '../../../customer/presentation/widgets/divider_section.dart';
import '../../../shared/presentation/widgets/cancel_order_button.dart';
import 'media_list.dart';

class OrderDetailsViewBody extends StatefulWidget {
  const OrderDetailsViewBody({super.key, required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  State<OrderDetailsViewBody> createState() => _OrderDetailsViewBodyState();
}

class _OrderDetailsViewBodyState extends State<OrderDetailsViewBody> {
  late final TextEditingController _detailsController;
  late final TextEditingController _locationController;
  late final TextEditingController _scheduleDateController;

  InvoiceEntity? _invoice;

  /// 🔑 dialog control
  BuildContext? _dialogContext;
  bool _dialogOpened = false;

  @override
  void initState() {
    super.initState();

    _detailsController =
        TextEditingController(text: widget.orderEntity.description);
    _locationController =
        TextEditingController(text: widget.orderEntity.location);
    _scheduleDateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd')
          .format(widget.orderEntity.scheduledDate ?? DateTime.now()),
    );
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _locationController.dispose();
    _scheduleDateController.dispose();
    super.dispose();
  }

  /// ✅ safe dialog close
  void _closeDialogIfOpen() {
    if (_dialogOpened &&
        _dialogContext != null &&
        Navigator.of(_dialogContext!).canPop()) {
      debugPrint('🟢 Closing dialog ONLY');
      Navigator.of(_dialogContext!).pop();
      _dialogOpened = false;
      _dialogContext = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocListener<GetInvoiceViewModel, GetInvoiceViewModelStates>(
      listener: (context, state) {
        debugPrint('🟡 Invoice State => ${state.runtimeType}');


        if (state is GetInvoiceViewModelLoading) {
          if (_dialogOpened) return;

          debugPrint('⏳ Opening invoice dialog');
          _dialogOpened = true;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogCtx) {
              _dialogContext = dialogCtx;
              return const Center(child: CircularProgressIndicator());
            },
          );
        }


        if (state is GetInvoiceViewModelError) {
          debugPrint('❌ Invoice Error => ${state.failure.message}');
          _closeDialogIfOpen();

          if (state.failure.message == "Invoice not found") {
            _invoice = null;
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.message)),
          );
        }


        if (state is GetInvoiceViewModelSuccess) {
          debugPrint('✅ Invoice Success');
          debugPrint('📄 Invoice Number => ${state.invoice.invoiceNumber}');
          debugPrint('📄 Items => ${state.invoice.items.length}');

          _closeDialogIfOpen();

          setState(() {
            _invoice = state.invoice;
          });
        }
      },

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Center(
              child: Text(
                "${t.serviceNumber} #${widget.orderEntity.id.substring(0, 6)}",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: RS.font(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _SectionTitle(title: t.serviceDetails),
            const SizedBox(height: 10),
            CustomTextFormField(
              hintText: "",
              textEditingController: _detailsController,
              isEnable: false,
              maxLines: 7,
            ),

            const DividerSection(),

            _SectionTitle(title: t.scheduleDate),
            const SizedBox(height: 10),
            CustomTextFormField(
              hintText: "",
              textEditingController: _scheduleDateController,
              isEnable: false,
            ),

            const DividerSection(),

            _SectionTitle(title: t.uploadedPhotos),
            const SizedBox(height: 10),
            MediaList(urls: widget.orderEntity.images),

            const DividerSection(),

            _SectionTitle(title: t.uploadedVideos),
            const SizedBox(height: 10),
            MediaList(
              urls: widget.orderEntity.videos,
              isVideo: true,
            ),

            const DividerSection(),

            _SectionTitle(title: t.location),
            const SizedBox(height: 10),
            CustomTextFormField(
              hintText: "",
              textEditingController: _locationController,
              isEnable: false,
              maxLines: 2,
            ),

            BlocBuilder<GetSparePartViewModel, GetSparePartViewModelStates>(
              builder: (context, state) {
                if (state is GetSparePartViewModelLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is GetSparePartViewModelSuccess &&
                    state.spareParts.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DividerSection(),
                      Text(
                        AppLocalizations.of(context)!.spareParts,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      ...state.spareParts.map(
                            (part) => Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.secondaryColor.withOpacity(
                              0.5,
                            ),

                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(
                              part.partName,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                fontSize: RS.font(context, 14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 16),
            const DividerSection(),

            CustomButton(
            text: t.printInvoice,
            onPressed: _invoice == null
                ? null
                : () async {
              if (kIsWeb) {

                await Printing.layoutPdf(
                  onLayout: (format) async {
                    return InvoicePdfService.generateInvoiceBytes(
                      subtotal:   _invoice!.subtotal,
                      address:  _invoice!.clientAddress  ?? '',
                       dueDate: _invoice!.issuedAt,

                      invoiceNumber: _invoice!.invoiceNumber,
                      clientName: _invoice!.clientName,
                      phone: _invoice!.clientPhone ?? '',
                      total: _invoice!.total,
                      items: _invoice!.items.map((e) {
                        return {
                          'name': e.description,
                          'qty': e.quantity,
                          'price': e.unitPrice,
                        };
                      }).toList(),
                    );
                  },
                );
              } else {

                final file = await InvoicePdfService.generateInvoiceFile(
                      subtotal:  _invoice!.subtotal,
                  dueDate:  _invoice!.issuedAt,
                  invoiceNumber: _invoice!.invoiceNumber,
                  clientName: _invoice!.clientName,
                  address:  _invoice!.clientAddress  ?? '',
                  phone: _invoice!.clientPhone ?? '',
                  total: _invoice!.total,
                  items: _invoice!.items.map((e) {
                    return {
                      'name': e.description,
                      'qty': e.quantity,
                      'price': e.unitPrice,
                    };
                  }).toList(),
                );

                await Printing.sharePdf(
                  bytes: await file.readAsBytes(),
                  filename: 'invoice_${_invoice!.invoiceNumber}.pdf',
                );
              }
            },
          ),

            const SizedBox(height: 16),


            if (widget.orderEntity.status != OrderStatus.canceled &&
                widget.orderEntity.status != OrderStatus.completed)
              BlocBuilder<CancelOrderViewModel, CancelOrderViewModelStates>(
                builder: (context, state) {
                  if (state is CancelOrderViewModelLoading) {
                    return const CircularProgressIndicator();
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CancelOrderButton(
                      onTap: () {
                        showConfirmationDialog(
                          context: context,
                          title: t.cancelOrder,
                          message: t.areYouSureYouWantToCancelThisOrder,
                          confirmText: t.yes,
                          cancelText: t.no,
                          onConfirm: () {
                            context.read<CancelOrderViewModel>().cancelOrder(
                              widget.orderEntity.id,
                            );
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  t.orderCancelledSuccessfully,
                                   style:  const TextStyle(color: Colors.white, fontSize:  16),

                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),


          const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: RS.font(context, 16),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
