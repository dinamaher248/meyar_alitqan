import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_serives_by_sub_view_model/get_serives_by_sub_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_serives_by_sub_view_model/get_serives_by_sub_view_model_states.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_service_card.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_service_card_shimmer.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';

class SubServicesList extends StatefulWidget {
  const SubServicesList({super.key,required this.onServiceSelected});
  final void Function(String serviceId,String title)? onServiceSelected;

  @override
  State<SubServicesList> createState() => _SubCategoriesListState();
}

class _SubCategoriesListState extends State<SubServicesList> {
  int selectedIndex = -1;
  String? selectedServiceId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetSerivesBySubViewModel,
      GetSerivesBySubViewModelStates
    >(
      builder: (context, state) {
        if (state is GetSerivesBySubViewModelStatesLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const SubServiceCardShimmer(),
              );
            },
          );
        }

        if (state is GetSerivesBySubViewModelStatesSuccess) {
          if (state.categories.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,

              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image.asset(
                    AssetsManager.waiting,
                    fit: BoxFit.cover,
                    height: RS.size(context, 200),
                  ),
                  SizedBox(height: RS.size(context, 16)),
                  Text(
                    AppLocalizations.of(context)!.noServices,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final item = state.categories[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SubServiceItemCard(
                  title: item.name,
                  image: item.icon ?? '',
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedServiceId = item.id;
                    });

                    widget.onServiceSelected?.call(item.id,item.name);
                  },

                ),
              );
            },
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const SubServiceCardShimmer(),
              );
            },
          );
        }
      },
    );
  }
}
