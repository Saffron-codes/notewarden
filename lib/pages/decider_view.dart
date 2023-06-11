import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_warden/pages/collections_view.dart';
import 'package:note_warden/pages/select_collections_view.dart';
import 'package:note_warden/providers/images_provider.dart';
import 'package:provider/provider.dart';

class DeciderView extends StatelessWidget {
  const DeciderView({Key? key}) : super(key: key);

  static const platform = MethodChannel("com.notewarden/share");

  Future<dynamic> checkImage() async {
    var imagePath = await platform.invokeMethod('handleImage');
    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkImage(), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data != null){
            Provider.of<ImagesProvider>(context,listen: false).changeImagePath(snapshot.data);
            return const SelectCollectionsView();
          }
          else{
            return CollectionsView();
          }
        }
        return const Scaffold(body: Center(child: FlutterLogo(size: 80,)));
      },
    );
  }
}
