import 'package:firebase_storage/firebase_storage.dart';

class ImageHelper {

  
  StorageReference storageReference;
  String url;

  _uploadImageData() async {

    // print('******* mera wala upload \n\n');
    // try{
    //   storageReference =
    //     FirebaseStorage.instance.ref().child('image/myExample');
    // final StorageUploadTask uploadTask = storageReference.putFile(pickedImage);
    // final StorageTaskSnapshot downloadUrl = await (uploadTask.onComplete);
    // url = (await downloadUrl.ref.getDownloadURL());
    // }catch(error ){
    //   print(error.toString() + "**************************");
    // }
    // print(url.toString() + "************\n\n\n\n");
  }

}