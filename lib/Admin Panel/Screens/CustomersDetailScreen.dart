import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCustomersDetailScreen extends StatefulWidget {
  @override
  _AllCustomersDetailScreenState createState() => _AllCustomersDetailScreenState();
}

class _AllCustomersDetailScreenState extends State<AllCustomersDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Get.back();
            },
          ),
          title: Text(
            "Customers",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body:Obx(()=>(userController.allCustomers.length>0)?
        ListView.builder(
            itemCount: userController.allCustomers.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
              boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(.5), blurRadius: 15)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: kbackgroundColor,
                      radius: 40,
                      backgroundImage: NetworkImage(userController.allCustomers[index].userProfile,),
                      child:userController.allCustomers[index].userProfile == ""?
                      Icon(Icons.person_rounded,
                        color: kbuttonColor,
                        size: 75,
                      ):null
                    ),
                    SizedBox(width: 15,),
                    Padding(
                      padding:EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userController.allCustomers[index].name,
                            style: TextStyle(
                              fontSize: 16,
                             // fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(userController.allCustomers[index].email,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              );
            }):
        Container(
          height: 200,
          child: Center(
              child: Text('No customers data has been found')),
        )
        )

    );
  }
}
