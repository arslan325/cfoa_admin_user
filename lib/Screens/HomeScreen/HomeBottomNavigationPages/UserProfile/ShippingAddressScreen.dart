import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'EditAddressScreen.dart';

class ShippingAddressScreen extends StatefulWidget {
  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Shipping Address",
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
      body: Obx(()=> (userController.authentication.value.userShippingAddress.length) > 0 ?
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: ListView.builder(
            itemCount: userController.authentication.value.userShippingAddress.length,
            itemBuilder: (context , index){
              return Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person,color: kbuttonColor,),
                                    SizedBox(width: 15,),
                                    Text(userController.authentication.value.userShippingAddress[index].name,
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.phone,color: kbuttonColor,),
                                    SizedBox(width: 15,),
                                    Text(userController.authentication.value.userShippingAddress[index].phoneNo,
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: kbuttonColor,),
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: Text(userController.authentication.value.userShippingAddress[index].address,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
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
                        SizedBox(height: 10,),
                        CustomRoundedButton(title: 'Edit Address',
                            clickFuction: (){
                             // addressModel.removeAddress(userController.authentication.value.userShippingAddress[index]);
                            Get.to(EditAddressScreen(addressModel: userController.authentication.value.userShippingAddress[index],));
                            }
                        )
                      ]
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
