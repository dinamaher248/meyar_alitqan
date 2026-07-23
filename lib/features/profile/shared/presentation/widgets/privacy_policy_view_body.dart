import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/get_terms_and_condiations_view_model/get_terms_and_condiations_view_model.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/get_terms_and_condiations_view_model/get_terms_and_condiations_view_model_states.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetTermsAndCondiationsViewModel,
      GetTermsAndCondiationsViewModelStates
    >(
      builder: (context, state) {
        return SafeArea(
          child: Column(children: [Expanded(child: _Body(state))]),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final state;
  const _Body(this.state);

  @override
  Widget build(BuildContext context) {
    if (state is GetTermsAndCondiationsViewModelLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is GetTermsAndCondiationsViewModelError) {
      return Center(
        child: Text(state.message, style: const TextStyle(color: Colors.red)),
      );
    }

    if (state is GetTermsAndCondiationsViewModelSuccess) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Text(
                state.appDocumentsEntity.content,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: RS.font(context, 13),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
