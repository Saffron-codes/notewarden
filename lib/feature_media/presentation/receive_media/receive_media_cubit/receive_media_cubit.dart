import 'package:bloc/bloc.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ReceiveMediaCubit extends Cubit<List<SharedMediaFile>> {
  ReceiveMediaCubit() : super([]);

  void addMediaFiles(List<SharedMediaFile> files) {
    emit(files);
  }
}
