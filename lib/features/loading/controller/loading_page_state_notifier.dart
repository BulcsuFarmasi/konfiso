import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/loading/controller/loading_state.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';

final loadingPageStateNotifierProvider = StateNotifierProvider(
    (Ref ref) => LoadingPageStateNotifier(ref.read(loadingRepositoryProvider)));

class LoadingPageStateNotifier extends StateNotifier<LoadingPageState> {
  final LoadingRepository _loadingRepository;

  LoadingPageStateNotifier(this._loadingRepository, {LoadingPageState initialState = const LoadingPageState()}) : super(initialState);

  Future<bool> autoSignIn() {
    return _loadingRepository.autoSignIn();
  }
}


