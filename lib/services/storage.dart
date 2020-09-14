import 'dart:io';
import 'package:epsapp/Constances/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageService{
  FirebaseStorage storage = FirebaseStorage(storageBucket:"gs://ebs-57023.appspot.com/");
Future <String> UploadProfilPicture(File file) async {
    String uid=Constants.uid;
    var storageref =storage.ref().child("user/profil/${uid}");
    var storageTask = storageref.putFile(file);
    var completTask=await storageTask.onComplete;
    String ImageUrl = await completTask.ref.getDownloadURL();
    return ImageUrl;


  }
  Future <String> UploadPictures(File file) async {
    var fileName = (file.path.split('/').last);
      var storageref =storage.ref().child("chat/"+fileName);
    var storageTask = storageref.putFile(file);
    var completTask=await storageTask.onComplete;
    String ImageUrl = await completTask.ref.getDownloadURL();
    return ImageUrl;


  }

}