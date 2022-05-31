import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeBottomNavigationPages/UserProfile/EditAddressScreen.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAddress_Screen.dart';
class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  void initState() {
    setState(() {
      if(userController.authentication.value.userShippingAddress.length>0){
        selectedRadio = userController.authentication.value.userShippingAddress.first.id;
      }
      else {
        return null;
      }
    });
    super.initState();
  }
  String selectedRadio = '';
  changeValue(String val) {
    setState(() {
      selectedRadio = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text("Shipping Address",style: klabelStyle,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp,color: kbuttonColor,),
          onPressed: (){
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: kbackgroundColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kbuttonColor,
          onPressed: (){
          Get.to(AddShippingAddress());
          },
          icon: Icon(Icons.add_location),
          label: Text('Add Address',style: TextStyle(
            fontSize: 15
          ),)),
      body: Obx(()=> (userController.authentication.value.userShippingAddress.length) > 0 ?
         Container(
           margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
           child: ListView.builder(
            itemCount: userController.authentication.value.userShippingAddress.length,
              itemBuilder: (context , index){
                return Container(
                  child: Card(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Row(
                            children: [
                              Radio(
                                value: userController.authentication.value.userShippingAddress[index].id,
                                groupValue: selectedRadio,
                                activeColor: Colors.green,
                                onChanged: (val) {
                                  changeValue(val);
                                },
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(userController.authentication.value.userShippingAddress[index].name,
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 15
                                          ),
                                        ),
                                        Visibility(
                                          visible: selectedRadio == userController.authentication.value.userShippingAddress[index].id ? true : false,
                                          child: Container(
                                            height: 30,
                                            child: IconButton(
                                              onPressed: (){
                                                Get.to(EditAddressScreen(addressModel: userController.authentication.value.userShippingAddress[index],));
                                              },
                                              icon: Icon(Icons.edit_outlined,color: kbuttonColor,),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text(userController.authentication.value.userShippingAddress[index].phoneNo,
                                      style: TextStyle(color: kbuttonColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(userController.authentication.value.userShippingAddress[index].address,
                                      style: TextStyle(color: Colors.black45,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                        TextSpan(
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: 'City :  ',
                                                style: TextStyle(
                                                  color: kbuttonColor,
                                                  fontSize: 15
                                                ),
                                              ),
                                              TextSpan(
                                                  text: userController.authentication.value.userShippingAddress[index].cityName,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                    color: Colors.black45,
                                                  )
                                              ),
                                            ]
                                        )
                                    ),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                        TextSpan(
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: 'Province :  ',
                                                style: TextStyle(
                                                    color: kbuttonColor,
                                                    fontSize: 15
                                                ),
                                              ),
                                              TextSpan(
                                                  text: userController.authentication.value.userShippingAddress[index].province,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black45,
                                                  )
                                              ),
                                            ]
                                        )
                                    ),
                                    SizedBox(height: 5,),
                                    Text.rich(
                                        TextSpan(
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: 'Zip Code :  ',
                                                style: TextStyle(
                                                    color: kbuttonColor,
                                                    fontSize: 15
                                                ),
                                              ),
                                              TextSpan(
                                                  text: userController.authentication.value.userShippingAddress[index].zipCode.toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black45,
                                                  )
                                              ),
                                            ]
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Visibility(
                            visible: selectedRadio == userController.authentication.value.userShippingAddress[index].id ? true : false,
                            child: CustomRoundedButton(title: 'Proceed',
                              clickFuction: (){
                              addressModel.selectedAddress(userController.authentication.value.userShippingAddress[index]);
                              }
                              ),
                          )
                        ]


                      ),
                    ),
                  ),
                );
              }
              ),
         ): Container(
        height: 200,
        child: Center(
          child: Text('shipping address is empty.'),
        ),
      )
      ),
      );
  }
}
