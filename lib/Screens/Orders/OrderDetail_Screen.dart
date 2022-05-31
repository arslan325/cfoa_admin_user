import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/OrderModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class OrderDetails extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetails({this.orderModel});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Order Detail",
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
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.5), blurRadius: 15)
              ]),
          child: Wrap(
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Text('Order Id:',style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16
            ),)
          ),
          Text(widget.orderModel.orderId,style: TextStyle(
              fontSize: 16
          ),
          ),
            SizedBox(width: 25),
            Visibility(
              visible: (widget.orderModel.orderStatus == 'pending' && widget.orderModel.paymentStatus == 'pending') ? true :false,
              child: IconButton(onPressed: (){
                showOrderDeleteAlert(widget.orderModel.orderId);

              },
                  icon: Icon(Icons.delete),color: Colors.redAccent,),
            )
          ],
        ),
              Divider(),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Icon(Icons.person_rounded,
                      color: kbuttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.orderModel.shippingAddress.first['Name'],style: TextStyle(
                      fontSize: 16
                  ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Icon(Icons.phone,
                      color: kbuttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.orderModel.shippingAddress.first['Phone Number'],style: TextStyle(
                      fontSize: 16
                  ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "ITEMS:",
                      style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Text(widget.orderModel.cart.length.toString(),style: TextStyle(
                      fontSize: 16
                  ),),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                        color: kbuttonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                            'Rs. ' + widget.orderModel.totalAmount.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
              Divider(),
              Column(
                  children: widget.orderModel.cart
                      .map((item) => ListTile(
                      title: Text(
                        item['Product Title'],
                      ),
                      trailing: Text(
                        "Rs ${item['cost']}" ?? "",
                      ),
                      leading: Image(
                        image: NetworkImage(item['Product Image'],),
                        width: 50,
                      )
                  ))
                      .toList()),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text("Shipping Address",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
                )
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Icon(Icons.location_on_outlined,
                      color: kbuttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(widget.orderModel.shippingAddress.first['Address'],style: TextStyle(
                        fontSize: 16
                    ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Icon(Icons.location_city,
                      color: kbuttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.orderModel.shippingAddress.first['City Name'],style: TextStyle(
                      fontSize: 16
                  ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SvgPicture.asset(
                  'images/mail.svg',
                  color: kbuttonColor,
                  width: 25),
            ),
            SizedBox(
              width: 15,
            ),
            Text(widget.orderModel.shippingAddress.first['Zip Code'].toString(),style: TextStyle(
                fontSize: 16
            ),
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Text('Province',style: TextStyle(
                      color: kbuttonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                    ),)
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.orderModel.shippingAddress.first['Province'].toString(),style: TextStyle(
                      fontSize: 16
                  ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
              Divider(),
              ListTile(
                leading: Text('Payment Via:',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),
                trailing: Text(widget.orderModel.paymentMethod,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Text('Payment Status:',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),
                trailing: Text(widget.orderModel.paymentStatus,
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.orderModel.paymentStatus == 'succeeded'? kbuttonColor: Colors.redAccent
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Text('Order Status:',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),
                trailing: Text(widget.orderModel.orderStatus,
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.orderModel.orderStatus == 'received'? kbuttonColor: Colors.redAccent
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Text('Order on:',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),
                trailing: Text(DateFormat.yMMMMEEEEd().format(widget.orderModel.orderOn.toDate()),
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
              Divider(),
              Visibility(
                visible:  widget.orderModel.orderStatus == 'received'? false: true,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: CustomRoundedButton(title: 'Confirm Pickup',
                    clickFuction: (){
                    orderController.updateOrder({
                      'Order Status' : 'received',
                      'Payment Status' : 'succeeded',
                    }, widget.orderModel,'').whenComplete(() {
                      Get.back();
                    });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
