import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/auth_repositories/delete_account_repo/delete_account_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/delete_account_remote_data_source/delete_account_remote_data_source.dart';

@Injectable(as: DeleteAccountRepo)
class DeleteAccountRepoImpl implements DeleteAccountRepo {
  final DeleteAccountRemoteDataSource deleteAccountRemoteDataSource;

  DeleteAccountRepoImpl({required this.deleteAccountRemoteDataSource});

  @override
  Future<Either<Failures, void>> deleteAccount() {
    return deleteAccountRemoteDataSource.deleteAccount();
  }
}
