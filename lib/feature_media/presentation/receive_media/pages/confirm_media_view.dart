import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/feature_media/presentation/media_list/media_bloc/media_bloc.dart';
import 'package:note_warden/feature_media/presentation/receive_media/receive_media_cubit/receive_media_cubit.dart';
import 'package:note_warden/feature_media/presentation/receive_media/widgets/media_grid_view.dart';
import 'package:note_warden/feature_media/presentation/receive_media/widgets/media_preview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ConfirmMediaView extends StatefulWidget {
  const ConfirmMediaView({super.key});

  @override
  State<ConfirmMediaView> createState() => _ConfirmMediaViewState();
}

class _ConfirmMediaViewState extends State<ConfirmMediaView> {
  static const platform = MethodChannel("com.notewarden");

  Future<void> requestPermission() async {
    var apiLevel = await platform.invokeMethod('getApiLevel');
    if (apiLevel >= 33) {
      await Permission.manageExternalStorage.request();
    } else {
      await Permission.storage.request();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;
    return BlocBuilder<ReceiveMediaCubit, List<SharedMediaFile>>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Confirm your Files"),
          ),
          body: state.length > 1
              ? MediaGridView(files: state)
              : MediaPreview(
                  path: state[0].path,
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              requestPermission();
              List<String> filePaths = [];
              for (var file in state) {
                filePaths.add(file.path);
              }
              BlocProvider.of<MediaBloc>(context).add(
                  AddMediaEvent(collection.name, collection.id, filePaths));
              Navigator.pushReplacementNamed(context, "/collection");
            },
            child: Icon(Icons.done),
          ),
        );
      },
    );
  }
}
