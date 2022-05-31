import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:cfoa_fyp/Models/Product_Model.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdatedProduct extends StatefulWidget {
 final ProductModel products;
 const UpdatedProduct({this.products});
  @override
  _UpdatedProductState createState() => _UpdatedProductState();
}

class _UpdatedProductState extends State<UpdatedProduct> {
  CategoryModel cate ;
  TextEditingController _productTitleTextEditController = new TextEditingController();
  TextEditingController _productPriceTextEditController = new TextEditingController();
  TextEditingController _productDescriptionTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedLocation = widget.products.categoryName;
    });
    _productTitleTextEditController.text = widget.products.prodTitle;
    _productPriceTextEditController.text = widget.products.prodPrice.toString();
    _productDescriptionTextEditController.text = widget.products.prodDetail;
    imagePickerController.disposeImage();
  }
  String _selectedLocation ;
  @override
  Widget build(BuildContext context) {
    print(widget.products.prodId);
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
              "Update Product",
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
                      child: imagePickerController.imageFile.value == null ? Image.network(widget.products.prodImage)
                          : Image(
                        image: FileImage(File(imagePickerController.imageFile.value)),
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
                                  child: new Text(location.cateTitle),
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
                                      border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: height*0.025,),
                        CustomRoundedButton(title: 'Update product',
                          clickFuction: (){
                            if(imagePickerController.imageFile.value == null && _formKey.currentState.validate()){
                              productController.updateProduct(
                                widget.products.prodId,
                                _productTitleTextEditController.text.trim(),
                                _selectedLocation,
                                widget.products.prodImage,
                                _productDescriptionTextEditController.text.trim(),
                                double.parse(_productPriceTextEditController.text.trim()),
                              );
                            }
                            else if(_formKey.currentState.validate()){
                              showLoading();
                              imagePickerController.uploadImageToFirebase('Product Images',_productTitleTextEditController.text).whenComplete(() {
                                setState(() {
                                  productController.updateProduct(
                                    widget.products.prodId,
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
