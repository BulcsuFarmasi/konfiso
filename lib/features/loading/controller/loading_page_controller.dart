import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';

final loadingPageControllerProvider = Provider(
    (Ref ref) => LoadingPageController(ref.read(loadingRepositoryProvider)));

class LoadingPageController {
  final LoadingRepository _loadingRepository;

  LoadingPageController(this._loadingRepository);

  Future<UserSignInStatus> autoSignIn() {
    return _loadingRepository.autoSignIn();
  }
}
