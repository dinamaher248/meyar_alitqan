import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/auth/presentation/widgets/login_header.dart';
import 'package:meayar_alitqan/features/auth/presentation/widgets/role_card.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';

class RoleSelectionViewBody extends StatefulWidget {
  const RoleSelectionViewBody({super.key});

  @override
  State<RoleSelectionViewBody> createState() => _RoleSelectionViewBodyState();
}

class _RoleSelectionViewBodyState extends State<RoleSelectionViewBody> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        const AuthHeader(),

        Image.asset(AssetsManager.logo, height: RS.size(context, 110)),

        SizedBox(height: RS.size(context, 150)),

        /// ===== White Rounded Card =====
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: RS.size(context, 28)),

                    Text(
                      loc.selectRoleTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: RS.font(context, 18),
                        color: ColorsManager.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: RS.size(context, 8)),

                    Text(
                      loc.selectRoleDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: RS.font(context, 14),
                        color: ColorsManager.secondaryTextDarkColor,
                      ),
                    ),

                    SizedBox(height: RS.size(context, 32)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoleCard(
                          icon: AssetsManager.customer,
                          title: loc.customer,
                          isSelected: selectedRole == 'customer',
                          onTap: () {
                            setState(() {
                              selectedRole = 'customer';
                            });
                          },
                        ),
                        SizedBox(width: RS.size(context, 24)),

                        RoleCard(
                          icon: AssetsManager.technician,
                          title: loc.technician,
                          isSelected: selectedRole == 'technician',
                          onTap: () {
                            setState(() {
                              selectedRole = 'technician';
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: RS.size(context, 40)),

                    CustomButton(
                      text: AppLocalizations.of(context)!.confirm,
                      onPressed: selectedRole == null
                          ? null
                          : () {
                              Navigator.pushNamed(
                                context,
                                RoutesManager.login,
                                arguments: selectedRole,
                              );
                            },
                    ),

                    SizedBox(height: RS.size(context, 24)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
