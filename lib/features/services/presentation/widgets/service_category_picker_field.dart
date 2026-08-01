import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../domain/entities/category_entity/category_entity.dart';
import '../manager/get_main_categories_view_model/get_main_categories_view_model.dart';
import '../manager/get_main_categories_view_model/get_main_categories_view_model_states.dart';

class ServiceCategoryPickerField extends StatefulWidget {
  const ServiceCategoryPickerField({
    super.key,
    required this.label,
    this.initialCategoryId,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final String? initialCategoryId;
  final ValueChanged<CategoryEntity> onChanged;
  final String? Function(CategoryEntity?)? validator;

  @override
  State<ServiceCategoryPickerField> createState() =>
      _ServiceCategoryPickerFieldState();
}

class _ServiceCategoryPickerFieldState
    extends State<ServiceCategoryPickerField> {
  CategoryEntity? _selected;

  @override
  void initState() {
    super.initState();
    /// يستدعي التصنيفات لو لسه مش متحمّلة (متكرر مش مشكلة بسبب الـ cache
    /// الموجود جوه GetMainCategoriesViewModel نفسه)
    context.read<GetMainCategoriesViewModel>().getMainCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.w500,
            color: ColorsManager.primaryTextDarkColor,
          ),
        ),
        SizedBox(height: RS.size(context, 8)),

        BlocBuilder<GetMainCategoriesViewModel, GetMainCategoriesViewModelStates>(
          builder: (context, state) {
            if (state is GetMainCategoriesViewModelStatesLoading) {
              return _buildLoadingField(context);
            }

            if (state is GetMainCategoriesViewModelStatesError) {
              return Text(
                state.message,
                style: TextStyle(
                  fontSize: RS.font(context, 13),
                  color: Colors.red,
                ),
              );
            }

            if (state is GetMainCategoriesViewModelStatesSuccess) {
              final categories =
                  state.categories.where((c) => c.isMain).toList();

              if (_selected == null && widget.initialCategoryId != null) {
                final match = categories
                    .where((c) => c.id == widget.initialCategoryId)
                    .toList();
                if (match.isNotEmpty) _selected = match.first;
              }

              return DropdownButtonFormField<CategoryEntity>(
                initialValue: _selected,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorsManager.primaryColor,
                ),
                style: TextStyle(
                  fontSize: RS.font(context, 14),
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.primaryTextDarkColor,
                ),
                validator: widget.validator != null
                    ? (_) => widget.validator!(_selected)
                    : null,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: RS.size(context, 12),
                    horizontal: RS.size(context, 12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                    borderSide: BorderSide(
                      color: ColorsManager.primaryColor,
                      width: 1.6,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<CategoryEntity>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selected = value);
                  widget.onChanged(value);
                },
              );
            }

            return _buildLoadingField(context);
          },
        ),
      ],
    );
  }

  Widget _buildLoadingField(BuildContext context) {
    return Container(
      height: RS.size(context, 48),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}