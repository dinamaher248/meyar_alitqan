import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../repositories/auth_repositories/forget_password_repo/forget_password_repo.dart';
@injectable
 class ForgetPasswordUseCase {
   final ForgetPasswordRepo forgetPasswordRepo;
   ForgetPasswordUseCase(this.forgetPasswordRepo);
   Future<Either<Failures, void>> sendResetLink(String email) {
     return forgetPasswordRepo.sendResetLink(email);
   }
 }