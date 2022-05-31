import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ProductUploadedScreen extends StatefulWidget {
  @override
  _ProductUploadedScreenState createState() => _ProductUploadedScreenState();
}

class _ProductUploadedScreenState extends State<ProductUploadedScreen> {
  TextEditingController _productTitleTextEditController = new TextEditingController();
  TextEditingController _productPriceTextEditController = new TextEditingController();
  TextEditingController _productDescriptionTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedLocation ;
  @override
  void initState() {
    super.initState();
    imagePickerController.disposeImage();
  }
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop:() async{
        imagePickerController.disposeImage();
        return true;
      },
      child: Obx(()=>
         Scaffold(
          backgroundColor: kbackgroundColor,
          appBar: AppBar(
            backgroundColor: kbackgroundColor,
            elevation: 0.5,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: kbuttonColor,
              ),
              onPressed: () {
                imagePickerController.disposeImage();
                Get.back();
              },
            ),
            title: Text(
              "Add New Product",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height*0.020,),
                  InkWell(
                    onTap: (){
                      imagePickerController.pickImage();
                    },
                    child: Container(
                      height: height*.27,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)
                      ),
                      child: imagePickerController.imageFile.value == null ? Icon(
                        Icons.add_a_photo,
                        size: 100,
                        color: kbuttonColor,
                      ) : Image(
                        image: FileImage(File(imagePickerController.imageFile.value)),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text('Please Choose a Category'), // Not necessary for Option 1
                              value:_selectedLocation,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue;
                                });
                              },
                              items: categoryController.categories.map((location) {
                                return DropdownMenuItem(
                                  child: Text(location.cateTitle),
                                  value: location.cateTitle,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.050,),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _productTitleTextEditController,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Please enter product title';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Product Title*',
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kbuttonColor,
                                      ),
                                        borderRadius: BorderRadius.circular(8)
                                    )
                                ),
                              ),
                              SizedBox(height: height*0.025,),
                              TextFormField(
                                controller: _productPriceTextEditController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Please enter product price';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Product Price*',
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)
                                    )
                                ),
                              ),
                              SizedBox(height: height*0.025,),
                              TextFormField(
                                maxLength: 500,
                                minLines: 1,
                                maxLines: 10,
                                controller: _productDescriptionTextEditController,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Please enter product description';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Product Description*',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)
                                ),
                              ),
                              )
                            ],
                          )
                        ),
                        SizedBox(height: height*0.025,),
                        CustomRoundedButton(title: 'Add product',
                          clickFuction: (){
                          if(imagePickerController.imageFile.value == null){
                            authentication.displayToast('Please select image from gallery');
                          }
                           else if(_selectedLocation == null){
                              authentication.displayToast('please choose category');
                            }
                            else if(_formKey.currentState.validate()){
                              showLoading();
                              imagePickerController.uploadImageToFirebase('Product Images',_productTitleTextEditController.text).whenComplete(() {
                                setState(() {
                                  productController.addProduct(
                                    DateTime.now().millisecondsSinceEpoch.toString(),
                                    _productTitleTextEditController.text.trim(),
                                    _selectedLocation,
                                   SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
                                    _productDescriptionTextEditController.text.trim(),
                                    double.parse(_productPriceTextEditController.text.trim()),
                                  );
                                  _productDescriptionTextEditController.clear();
                                  _productTitleTextEditController.clear();
                                  _productPriceTextEditController.clear();
                                  imagePickerController.disposeImage();
                                  _selectedLocation = null;
                                  dismissibleLoading();
                                });
                              });
                            }
                          },
                        ),
                        SizedBox(height: height*0.025,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
