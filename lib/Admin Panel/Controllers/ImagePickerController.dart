import 'dart:io';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerController extends GetxController{
  static ImagePickerController instance = Get.find();
  var imageFile = ''.obs;
  String url = '';
  UploadTask task;
  Future pickImage() async {
    final pickedFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery
    );
    if(pickedFile==null) return;
     imageFile.value = pickedFile.path;
  }

  Future uploadImageToFirebase(String foldName , String fileName) async {
    if(imageFile == null) return;
    final destination ='$foldName/$fileName.jpg';
    task = uploadFile(destination, File(imageFile.value));
    if(task==null) return;
    final snapshot = await task.whenComplete(()  {
    });
    final urlDownload = await snapshot.ref.getDownloadURL();
    url = urlDownload;
    SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.imageUrl, url);
  }

  static UploadTask uploadFile(String destination,File file){
    try{
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch(e){
      return null;
    }
  }

  void disposeImage(){
    imageFile.value = null;
  }


}