import 'dart:io';
import 'package:epsapp/Constances/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  FirebaseStorage storage = FirebaseStorage(storageBucket:"gs://eps-app-58971.appspot.com/");
Future <String> UploadStorage(File file) async {
    String uid=Constants.uid;
    var storageref =storage.ref().child("user/profil/${uid}");
    var storageTask = storageref.putFile(file);
    var completTask=await storageTask.onComplete;
    String ImageUrl = await completTask.ref.getDownloadURL();
    return ImageUrl;


  }


}