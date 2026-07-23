import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';

abstract class DeleteAccountRemoteDataSource {
  Future<Either<Failures, void>> deleteAccount( );
}
