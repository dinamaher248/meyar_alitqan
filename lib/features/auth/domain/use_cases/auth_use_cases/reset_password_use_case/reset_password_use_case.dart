import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../repositories/auth_repositories/reset_password_repo/reset_password_repo.dart';
@injectable
 class ResetPasswordUseCase {
   final ResetPasswordRepo resetPasswordRepo;
   ResetPasswordUseCase(this.resetPasswordRepo);
   Future<Either<Failures, void>> resetPassword({
     required String newPassword,
   }) {
     return resetPasswordRepo.resetPassword(newPassword: newPassword);
   }
 }