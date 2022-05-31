import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/ShippingAddressModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:cfoa_fyp/Widgets/CustomeTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditAddressScreen extends StatefulWidget {
  final ShippingAddressModel addressModel;
  const EditAddressScreen({this.addressModel});
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  void initState() {
    super.initState();
    _nameTextEditingController.text = widget.addressModel.name;
    _phoneNumberTextEditingController.text = widget.addressModel.phoneNo;
    _addressTextEditingController.text = widget.addressModel.address;
    _cityTextEditingController.text = widget.addressModel.cityName;
    _zipCodeTextEditingController.text = widget.addressModel.zipCode.toString();
    _selectedLocation = widget.addressModel.province;
  }
  TextEditingController _nameTextEditingController = new TextEditingController();
  TextEditingController _phoneNumberTextEditingController = new TextEditingController();
  TextEditingController _addressTextEditingController = new TextEditingController();
  TextEditingController _cityTextEditingController = new TextEditingController();
  TextEditingController _zipCodeTextEditingController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static List<String> province = <String>[
    'Punjab', 'Sindh' , 'Balochistan', 'Khyber Pakhtunkhwa'
  ];
  String _selectedLocation ;
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Edit Address",
          style: klabelStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: kbuttonColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: kbackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        textEditController: _nameTextEditingController,
                        hintText: 'Enter your full name',
                        inputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                        prefixIcon: Icons.account_circle_rounded,
                        maxLine: 1,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'please enter your name';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: height*0.020,),
                      CustomTextField(
                        textEditController: _phoneNumberTextEditingController,
                        hintText: '+92000-0000000',
                        keyboardType: TextInputType.phone,
                        inputFormatter: MaskTextInputFormatter(
                            mask: '+92###-#######', filter: {"#": RegExp(r'[0-9]')}),
                        prefixIcon: Icons.phone,
                        maxLine: 1,
                        maxLength: 14,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'please enter your phone number';
                          }
                          else if(_phoneNumberTextEditingController.text.length < 14){
                            return 'please enter your valid phone number';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: height*0.020,),
                      CustomTextField(
                        textEditController: _addressTextEditingController,
                        hintText: 'Enter your address',
                        prefixIcon: Icons.location_on_outlined,
                        maxLine: 1,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'please enter your address';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: height*0.020,),
                      CustomTextField(
                        textEditController: _cityTextEditingController,
                        hintText: 'Enter your city name',
                        inputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                        prefixIcon: Icons.location_city,
                        maxLine: 1,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'please enter your city name';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: height*0.020,),
                      CustomTextField(
                        textEditController: _zipCodeTextEditingController,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        url: 'images/mail.svg',
                        inputFormatter: FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        hintText: 'Enter your zip code',
                        maxLine: 1,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'please enter zip code';
                          }
                          else if(_zipCodeTextEditingController.text.length < 5){
                            return 'please enter a valid zip code';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: height*0.020,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            hint: Text('Select your province'),
                            validator: (value) => value == null ? 'please select your province' : null,
                            value:_selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedLocation = newValue;
                              });
                            },
                            items: province.map((location) {
                              return DropdownMenuItem(
                                child: Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: height*0.020,),
              CustomRoundedButton(title: 'Save',
                clickFuction: (){
                  if(_formKey.currentState.validate())
                  {
                    ShippingAddressModel addressModel = new ShippingAddressModel(
                        id: widget.addressModel.id,
                        name: _nameTextEditingController.text,
                        phoneNo: _phoneNumberTextEditingController.text,
                        address: _addressTextEditingController.text,
                        cityName: _cityTextEditingController.text,
                        zipCode: int.parse(_zipCodeTextEditingController.text),
                        province: _selectedLocation
                    );
                    addressModel.updateShippingAddress(widget.addressModel);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
