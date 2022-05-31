import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/SplashScreen.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'OrderPlacedSuccessfully.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _visible = false;
  String selectedRadio = 'Cash On Delivery';
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
        title: Text(
          "Payment Method",
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image(
                  image: AssetImage('images/free_shipping.png'),
                  height: 200,
                ),
                Divider(thickness: 1,),
                Obx(()=>
                  ListTile(
                    leading: Text("Total Amount :",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    trailing:cartController.totalCartPrice.value != 0.0? Text(cartController.totalCartPrice.toString()+' Rs',
                      style: TextStyle(
                          fontSize: 18,
                          color: kbuttonColor,
                          fontWeight: FontWeight.w600
                      ),
                    ):Text(customDesignController.totalPrice.toString()+' Rs',
                      style: TextStyle(
                          fontSize: 18,
                          color: kbuttonColor,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1,),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select your payment method',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: Radio(
                        value: 'Cash On Delivery',
                        groupValue: selectedRadio,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          changeValue(val);
                        },
                      ),
                      title: Text('Cash On Delivery'),
                      trailing: Image(
                        image: AssetImage('images/cash-on-delivery.png'),
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: selectedRadio == 'Cash On Delivery' ? true : false,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: CustomRoundedButton(
                          title: 'Place Order',
                          clickFuction: () {
                            if(cartController.totalCartPrice.value ==0.0){
                              customDesignOrderController.placeCustomOrder(paymentMethod: selectedRadio,paymentStatus: 'pending');
                            }
                            else{
                              orderController.placeOrder(paymentMethod: selectedRadio,paymentStatus: 'pending');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: Radio(
                        value: 'Online Payment Via Card',
                        groupValue: selectedRadio,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          changeValue(val);
                        },
                      ),
                      title: Text('Online Payment'),
                      trailing: Image(
                        image: AssetImage('images/debit-card.png'),
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: selectedRadio == 'Online Payment Via Card' ? true : false,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: CustomRoundedButton(
                          title: 'Place Order',
                          clickFuction: () {
                            if(cartController.totalCartPrice.value == 0.0){
                              customDesignOrderController.createPaymentMethodForCustomOrder(selectedRadio);
                            }
                            else{
                              orderController.createPaymentMethod(selectedRadio);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
