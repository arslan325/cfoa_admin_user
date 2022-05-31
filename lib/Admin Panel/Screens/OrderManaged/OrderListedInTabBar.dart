import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CompletedOrderScreen.dart';
import 'AllOrderListedScreen.dart';

class TabBarOrderListed extends StatefulWidget {
  @override
  _TabBarOrderListedState createState() => _TabBarOrderListedState();
}

class _TabBarOrderListedState extends State<TabBarOrderListed> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Customer Orders",
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
          bottom: TabBar(
            indicatorColor: kbuttonColor,
            labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
            onTap: (index) {

            },
            tabs: [
              Tab(text: 'All Orders'),
              Tab(text: 'Completed Orders'),
            ],
          ),
        ),
          body: TabBarView(
            children: [
              AllOrdersListed(),
              CompletedOrders(),
            ],
          ),
        ),
    );
  }
}
