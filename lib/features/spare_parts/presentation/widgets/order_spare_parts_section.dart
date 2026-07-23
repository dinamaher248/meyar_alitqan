import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/components/app_loader.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/components/custom_text_field.dart';
import 'package:meayar_alitqan/core/validators/validate_inputs.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/widgets/divider_section.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model_states.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model_states.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
class AddSparePartBottomSheet extends StatefulWidget {
  final String orderId;
  final String technicianId;

  const AddSparePartBottomSheet({
    super.key,
    required this.orderId,
    required this.technicianId,
  });

  @override
  State<AddSparePartBottomSheet> createState() =>
      _AddSparePartBottomSheetState();
}

class _AddSparePartBottomSheetState
    extends State<AddSparePartBottomSheet> {

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController desc;
  late final TextEditingController qty;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    desc = TextEditingController();
    qty = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    desc.dispose();
    qty.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
 
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: BlocConsumer<AddSparePartViewModel,
            AddSparePartViewModelStates>(
          listener: (context, state) {
            if (state is AddSparePartViewModelSuccess) {
              Navigator.pop(context);
              context.read<GetSparePartViewModel>().getSparePart(
               widget.orderId
              );
            }
          },
          builder: (context, state) {
            final loading =
            state is AddSparePartViewModelLoading;

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.addSparePart,
                      style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                       fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),

                    CustomTextFormField(
                      hintText: t.sparePartName,
                      textEditingController: name,
                      validator: (v) =>
                      v == null || v.isEmpty
                          ? t.sparePartNameValidation
                          : null,
                    ),

                    const SizedBox(height: 8),

                    CustomTextFormField(
                      hintText: t.description,
                      textEditingController: desc,
                    ),

                    const SizedBox(height: 8),

                    CustomTextFormField(
                      hintText: t.quantity,
                      keyboardType: TextInputType.number,
                      textEditingController: qty,
                      validator: (v) =>
                      v == null || v.isEmpty
                          ? t.quantityValidation
                          : null,
                    ),

                    const SizedBox(height: 16),

                    CustomButton(
                      text:
                      loading ? t.loading : t.addSparePart,
                      onPressed: loading
                          ? null
                          : () {
                        if (!_formKey.currentState!
                            .validate()) return;

                        context
                            .read<AddSparePartViewModel>()
                            .addSparePart(
                          SparePartEntity(
                            id: '',
                            orderId: widget.orderId,
                            technicianId:
                            widget.technicianId,
                            partName:
                            name.text.trim(),
                            partDescription:
                            desc.text.isEmpty
                                ? null
                                : desc.text.trim(),
                            quantity: int.tryParse(
                                qty.text),
                            estimatedPrice: 0,
                            approvedPrice: null,
                            status: 'pending',
                            adminNote: null,
                            adminId: null,
                            createdAt:
                            DateTime.now(),
                            updatedAt:
                            DateTime.now(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
