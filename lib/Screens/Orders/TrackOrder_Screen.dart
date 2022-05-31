import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/OrderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  final String orderStatus;
  const TrackOrderScreen({this.orderId,this.orderStatus});
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Track Order",
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
          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Order Id :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      widget.orderId,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              TimelineTile(
                alignment: TimelineAlign.start,
                isFirst: true,
                beforeLineStyle:  LineStyle(
                  color: widget.orderStatus == 'pending'?kbuttonColor:Colors.grey,
                  thickness: 6,
                ),
                indicatorStyle: IndicatorStyle(
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: Icons.thumb_up,
                  ),
                  width: 35,
                  color: widget.orderStatus == 'pending'?kbuttonColor:Colors.grey,
                  indicatorXY: 0.3,
                  padding: EdgeInsets.all(8),
                ),
                endChild: Opacity(
                  opacity: widget.orderStatus == 'pending'? 1:0.3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/order_processed.svg', height: 50, width: 50,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Order Pending",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Your order is received but in pending stage",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.start,
                isFirst: true,
                beforeLineStyle:  LineStyle(
                  color: widget.orderStatus == 'In Progress'?kbuttonColor:Colors.grey,
                  thickness: 6,
                ),
                indicatorStyle: IndicatorStyle(
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: Icons.thumb_up,
                  ),
                  width: 35,
                  color: widget.orderStatus == 'In Progress'?kbuttonColor:Colors.grey,
                  indicatorXY: 0.3,
                  padding: EdgeInsets.all(8),
                ),
               // In Progress', 'Shipped' , 'On The Way
                endChild: Opacity(
                  opacity: widget.orderStatus == 'In Progress'? 1:0.3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/order_confirmed.svg', height: 50, width: 50,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Order In Progress",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "order has been confirmed and in progress",
                          style: TextStyle(

                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.start,
                isFirst: true,
                beforeLineStyle:  LineStyle(
                  color: widget.orderStatus == 'Shipped'?kbuttonColor:Colors.grey,
                  thickness: 6,
                ),
                indicatorStyle: IndicatorStyle(
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: Icons.thumb_up,
                  ),
                  width: 35,
                  color: widget.orderStatus == 'Shipped'?kbuttonColor:Colors.grey,
                  indicatorXY: 0.3,
                  padding: EdgeInsets.all(8),
                ),
                endChild: Opacity(
                  opacity: widget.orderStatus == 'Shipped'? 1:0.3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/order_shipped.svg', height: 50, width: 50,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Order Shipped",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "order has been shipped",
                          style: TextStyle(

                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.start,
                isFirst: true,
                beforeLineStyle:  LineStyle(
                  color: widget.orderStatus == 'On The Way'?kbuttonColor:Colors.grey,
                  thickness: 6,
                ),
                indicatorStyle: IndicatorStyle(
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: Icons.thumb_up,
                  ),
                  width: 35,
                  color: widget.orderStatus == 'On The Way'?kbuttonColor:Colors.grey,
                  indicatorXY: 0.3,
                  padding: EdgeInsets.all(8),
                ),
                // In Progress', 'Shipped' , 'On The Way
                endChild: Opacity(
                  opacity: widget.orderStatus == 'On The Way'? 1:0.3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/on_the_way.svg', height: 50, width: 50,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "On The Way",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "order is on the way",
                          style: TextStyle(

                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.start,
                isLast: true,
                isFirst: true,
                beforeLineStyle:  LineStyle(
                  color: widget.orderStatus == 'received'?kbuttonColor:Colors.grey,
                  thickness: 6,
                ),
                indicatorStyle: IndicatorStyle(
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: Icons.thumb_up,
                  ),
                  width: 35,
                  color: widget.orderStatus == 'received'?kbuttonColor:Colors.grey,
                  indicatorXY: 0.3,
                  padding: EdgeInsets.all(8),
                ),
                // In Progress', 'Shipped' , 'On The Way
                endChild: Opacity(
                  opacity: widget.orderStatus == 'received'? 1:0.3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SvgPicture.asset('images/delivered.svg', height: 50, width: 50,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Received",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "order received successfully",
                          style: TextStyle(

                              fontSize: 12,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

