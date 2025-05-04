import '../../domain/repositories/edit_profile_repository.dart';
import '../datasources/edit_profile_remote_datasource.dart';

class Edit_profileRepositoryImpl implements Edit_profileRepository {
  final Edit_profileRemoteDataSource remoteDataSource;

  Edit_profileRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}
