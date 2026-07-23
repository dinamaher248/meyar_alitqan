import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failures, void>> sendResetLink(String email);
}