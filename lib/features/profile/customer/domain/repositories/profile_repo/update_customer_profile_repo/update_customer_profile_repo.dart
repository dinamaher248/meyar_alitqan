import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';

abstract class UpdateCustomerProfileRepo {
  Future<Either<Failures, void>> updateProfile({
   String? name,
   String? phone,
   String? avatar,
   String? address,
  });
}