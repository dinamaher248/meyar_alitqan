import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/components/custom_text_field.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/add_review_view_model/add_review_view_model.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/add_review_view_model/add_review_view_model_states.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

class ShowReviewBottomSheetContent extends StatefulWidget {
  final String fromUserId;
  final String toUserId;
  final String fromRole;
  final String toRole;
  final String orderId;

  const ShowReviewBottomSheetContent({
    super.key,
    required this.fromUserId,
    required this.toUserId,
    required this.fromRole,
    required this.toRole,
    required this.orderId,
  });

  @override
  State<ShowReviewBottomSheetContent> createState() =>
      _ShowReviewBottomSheetContentState();
}

class _ShowReviewBottomSheetContentState
    extends State<ShowReviewBottomSheetContent> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<AddReviewViewModel>(),
      child: BlocConsumer<AddReviewViewModel, AddReviewViewModelStates>(
        listener: (context, state) {
          if (state is AddReviewSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم التقييم بنجاح ⭐', style:
                  TextStyle(
                     color: Colors.green , fontSize: 16
                  ),),
              ),
            );

            Navigator.pop(context);
          }
          if (state is AddReviewError) {
            String message = state.error;

            if (message.contains("duplicate key")) {
              message = "لقد قمت بتقييم هذا الفني من قبل";
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message,style:
              TextStyle(
                  color: Colors.white , fontSize: 16
              ),)),
            );
            Navigator.pop(context);

          }
        },
        builder: (context, state) {
          final isLoading = state is AddReviewLoading;

          return Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  SizedBox(height: RS.size(context, 16)),

                  Center(
                    child: Image.asset(
                      AssetsManager.waiting2,
                      height: RS.size(context, 160),
                    ),
                  ),

                  SizedBox(height: RS.size(context, 12)),

                  Text(
                    t.reviewTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: RS.size(context, 6)),

                  Center(
                    child: Text(
                      t.reviewSubtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  SizedBox(height: RS.size(context, 16)),

                  Center(
                    child: RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: RS.size(context, 32),
                      unratedColor: Colors.grey.shade300,
                      itemBuilder: (_, __) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        setState(() => _rating = rating);
                      },
                    ),
                  ),

                  SizedBox(height: RS.size(context, 16)),

                  Text(
                    t.reviewWriteLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: RS.size(context, 8)),

                  CustomTextFormField(
                    textEditingController: _commentController,
                    maxLines: 3,
                    hintText: t.reviewHint,
                  ),

                  SizedBox(height: RS.size(context, 20)),

                  CustomButton(
                    text: isLoading ? t.loading : t.reviewSubmit,
                    onPressed: isLoading || _rating == 0
                        ? null
                        : () {
                            context.read<AddReviewViewModel>().addReview(
                              reviewEntity: ReviewEntity(
                                orderId: widget.orderId,
                                fromUserId: widget.fromUserId,
                                toUserId: widget.toUserId,
                                rating: _rating.toInt(),
                                comment: _commentController.text.trim(),
                                fromRole: widget.fromRole,
                                toRole: widget.toRole,
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
    );
  }
}
