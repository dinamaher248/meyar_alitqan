import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';

import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';

void showLocationsSheet(
  BuildContext context,
  List<ServiceAreaEntity> locations,
) {
  showModalBottomSheet(
    backgroundColor: Colors.white,

    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: locations.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, index) {
          return ListTile(
            leading: Icon(Icons.place,size: 14,),
            title: Text(
              locations[index].name  ,
              style: TextStyle(fontSize: RS.font(context, 16),fontWeight: FontWeight.bold),
            ),
            onTap: () {
              context.read<CreateOrderViewModel>().locationAreaController.text =
                  locations[index].name  ;

              Navigator.pop(context);
            },
          );
        },
      );
    },
  );
}
