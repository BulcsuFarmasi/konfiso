import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';

final loadingPageStateNotifierProvider = StateNotifierProvider(
    (Ref ref) => LoadingPageStateNotifier(ref.read(loadingRepositoryProvider)));

class LoadingPageStateNotifier extends StateNotifier<LoadingState> {
  final LoadingRepository _loadingRepository;

  LoadingPageStateNotifier(this._loadingRepository) : super(LoadingState());

  Future<bool> autoSignIn() {
    return _loadingRepository.autoSignIn();
  }
}

class LoadingState {}
