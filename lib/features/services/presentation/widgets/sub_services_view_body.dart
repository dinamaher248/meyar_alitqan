import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_services_list.dart';
import '../../../../config/routes/routes_manager.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/di/di.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/get_serives_by_sub_view_model/get_serives_by_sub_view_model.dart';

class SubServicesViewBody extends StatelessWidget {
  SubServicesViewBody({
    super.key,
    required this.categoryId,
    required this.mainCategoryId,
  });

  final String categoryId;
  final String mainCategoryId;
  String? selectedSubServiceId;
  String ? selectedSubServiceTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlocProvider(
                      create: (context) =>
                          getIt<GetSerivesBySubViewModel>()
                            ..getServicesBySub(categoryId),
                      child: SubServicesList(
                        onServiceSelected: (id,title) {
                          selectedSubServiceId = id;
                          selectedSubServiceTitle = title;


                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: RS.size(context, 24)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              text: AppLocalizations.of(context)!.completeData,
              onPressed: () {
                if (selectedSubServiceId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a service',style:  TextStyle(
                      fontSize: RS.size(context, 16),
                    )),
                    )
                  );

                  return;
                }

                Navigator.pushNamed(
                  context,
                  RoutesManager.serviceRequestDetailsView,
                  arguments: ServiceRequestDetailsArgs(
                    mainCategoryId: mainCategoryId,
                    categoryId: categoryId,
                    subserviceId: selectedSubServiceId!,
                    title: selectedSubServiceTitle ?? "",
                  ),
                );
              },
            ),
          ),
          SizedBox(height: RS.size(context, 24)),
        ],
      ),
    );
  }
}

class ServiceRequestDetailsArgs {
  final String mainCategoryId;
  final String categoryId;
  final String subserviceId;
  final String title ;

  ServiceRequestDetailsArgs({
    required this.mainCategoryId,
    required this.categoryId,
    required this.subserviceId,
    required this.title

  });
}
