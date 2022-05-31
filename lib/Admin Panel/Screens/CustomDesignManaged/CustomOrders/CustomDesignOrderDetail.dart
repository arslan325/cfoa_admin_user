import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CustomDesignOrderModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomOrderDetailScreen extends StatefulWidget {
  final CustomDesignOrder customDesignOrder;
 const CustomOrderDetailScreen({this.customDesignOrder});
  @override
  _CustomOrderDetailScreenState createState() => _CustomOrderDetailScreenState();
}

class _CustomOrderDetailScreenState extends State<CustomOrderDetailScreen> {
  static List<String> customOrderStatus = <String>[
    'In Progress', 'Shipped' , 'On The Way',
  ];
  String _selectedLocation =customOrderStatus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Custom Order Details",
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Custom Order Id:',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                      Text(widget.customDesignOrder.customOrderId,style: TextStyle(
                          fontSize: 16
                      ),
                      ),
                    ],
                  ),
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
                    Text(widget.customDesignOrder.shippingAddress.first['Name'],style: TextStyle(
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
                    Text(widget.customDesignOrder.shippingAddress.first['Phone Number'],style: TextStyle(
                        fontSize: 16
                    ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
                ListTile(
                  title: Text(
                    widget.customDesignOrder.designItem.first['Design Title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  subtitle: Text(
                    widget.customDesignOrder.designItem.first['Design Description'],
                  ),
                  leading: Image(
                    image: NetworkImage(widget.customDesignOrder.designItem.first['Design Image'],),
                    width: 70,
                  ),
                  trailing: Text(
                    widget.customDesignOrder.totalAmount,
                    style: TextStyle(
                        fontSize: 16,
                        color: kbuttonColor
                    ),
                  ),
                ),
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
                      child: Text(widget.customDesignOrder.shippingAddress.first['Address'],style: TextStyle(
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
                    Text(widget.customDesignOrder.shippingAddress.first['City Name'],style: TextStyle(
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
                    Text(widget.customDesignOrder.shippingAddress.first['Zip Code'].toString(),style: TextStyle(
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
                    Text(widget.customDesignOrder.shippingAddress.first['Province'].toString(),style: TextStyle(
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
                  trailing: Text(widget.customDesignOrder.paymentMethod,
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
                  trailing: Text(widget.customDesignOrder.paymentStatus,
                    style: TextStyle(
                        fontSize: 16,
                        color: widget.customDesignOrder.paymentStatus == 'succeeded'? kbuttonColor: Colors.redAccent
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text('Custom Order Status:',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  trailing: Text(widget.customDesignOrder.customOrderStatus,
                    style: TextStyle(
                        fontSize: 16,
                        color: widget.customDesignOrder.customOrderStatus == 'received'? kbuttonColor: Colors.redAccent
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text('Order on:',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  trailing: Text(DateFormat.yMMMMEEEEd().format(widget.customDesignOrder.orderOn.toDate()),
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.all(20),
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text('Change Order Status'),
                      value:_selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      },
                      items: customOrderStatus.map((location) {
                        return DropdownMenuItem(
                          child: Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Divider(),
                Visibility(
                  visible:  widget.customDesignOrder.customOrderStatus == 'received'? false: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: CustomRoundedButton(title: 'Update Status',
                      clickFuction: (){
                        customDesignOrderController.updateCustomOrderData({
                          'Custom Order Status' : _selectedLocation,
                        }, widget.customDesignOrder,
                            _selectedLocation
                        ).whenComplete(() {
                          Get.back();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
