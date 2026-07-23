// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:meayar_alitqan/features/services/presentation/widgets/service_details.dart';
//
// import '../../../../core/helper/responsive_size.dart';
// import '../../../../core/utils/assets_manager.dart';
// import '../../../../core/utils/colors_manager.dart';
// import '../../domain/entities/category_entity/category_entity.dart';
//
// class MainCategoryServiceItem extends StatelessWidget {
//   final String title;
//   final String ? numberOfPeople;
//   final String ?  averageRating;
//   final String image;
//   final CategoryEntity category;
//   final Function() onTap;
//
//   const MainCategoryServiceItem({
//     super.key,
//     required this.category,
//     required this.title,
//       this.numberOfPeople,
//       this.averageRating,
//     required this.image,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(RS.size(context, 8)),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(
//             horizontal: RS.size(context, 12),
//             vertical: RS.size(context, 16),
//           ),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: ColorsManager.grey,
//               width: RS.size(context, 3),
//             ),
//             borderRadius: BorderRadius.circular(RS.radius(context, 10)),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//
//             children: [
//               _ServiceIcon(image: image),
//               SizedBox(width: RS.size(context, 16)),
//               Expanded(
//                 child: ServiceDetails(
//                   title: category.name,
//                   numberOfPeople: numberOfPeople ?? "",
//                   averageRating: averageRating ?? "",
//                 ),
//               ),
//               _ArrowButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _ServiceIcon extends StatelessWidget {
//   final String image;
//
//   const _ServiceIcon({required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ColorsManager.primaryColor.withOpacity(0.2),
//         shape: BoxShape.circle,
//       ),
//       padding: EdgeInsets.all(RS.size(context, 10)),
//       child: CachedNetworkImage(
//         placeholder: (context, url) => const Center(
//           child: CircularProgressIndicator(),
//         ),
//         errorWidget: (context, url, error) =>   Icon(Icons.home_repair_service),
//         imageUrl: image,
//         width: RS.size(context, 30),
//         height: RS.size(context, 30),
//       ),
//     );
//   }
// }
// class _ArrowButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final isRTL =
//         Directionality.of(context) == TextDirection.rtl;
//
//     return Container(
//       margin: EdgeInsetsDirectional.only(
//         start: RS.size(context, 8),
//       ),
//       decoration: BoxDecoration(
//         color: ColorsManager.primaryColor.withOpacity(0.2),
//         shape: BoxShape.circle,
//       ),
//       padding: EdgeInsets.all(RS.size(context, 8)),
//       child: Transform.rotate(
//         angle: isRTL ? 3.1416 : 0,
//         child: SvgPicture.asset(
//           AssetsManager.angleRight,
//           width: RS.size(context, 18),
//           height: RS.size(context, 18),
//         ),
//       ),
//     );
//   }
// }
