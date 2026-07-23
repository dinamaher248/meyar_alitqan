import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/core/utils/strings_manager.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          AssetsManager.logo,
          width: RS.size(context, 300),
          height: RS.size(context, 300),
        ),

        const Spacer(),

        Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                     StringsManager.PoweredBy,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: ColorsManager.black,
                      fontSize: RS.font(context, 18),
                    ),
                  ),
                  SizedBox(width: RS.size(context, 6)),
                  Image.asset(
                    AssetsManager.agencyLogo,
                    width: RS.size(context, 70),
                    height: RS.size(context, 70),
                  ),
                ],
              ),
            ),

          ),
        ),
      ],
    );
  }
}
