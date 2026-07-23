import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';

import '../../../repositories/auth_repositories/delete_account_repo/delete_account_repo.dart';
@injectable
class DeleteAccountUseCase {
  final DeleteAccountRepo deleteAccountRepo;

  DeleteAccountUseCase(this.deleteAccountRepo);

  Future<Either<Failures, void>> deleteAccount() {
    return deleteAccountRepo.deleteAccount();
  }
}
