
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CustomDesignUpdated_Screen.dart';
import 'CustomDesignUploaded.dart';

class CustomOrderListed extends StatefulWidget {
  @override
  _CustomOrderListedState createState() => _CustomOrderListedState();
}

class _CustomOrderListedState extends State<CustomOrderListed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text(
            "Custom Designs",
            style: klabelStyle,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(CustomOrderUploadedScreen());
                },
                icon: Icon(
                  Icons.add,
                  color: kbuttonColor,
                ))
          ],
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
      body: Obx(()=> (customDesignController.activeCustomDesigns.length) > 0?
      ListView.builder(
        itemBuilder: (context,i) {
          return
            Container(
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
                          child: Text('Design Id:',style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),)
                      ),
                      Text(customDesignController.activeCustomDesigns[i].designId,style: TextStyle(
                          fontSize: 16
                      ),
                      ),
                      SizedBox(width: 50),
                      IconButton(onPressed: (){
                      showCustomDesignDeleteAlert(customDesignController.activeCustomDesigns[i].designId,
                      );

                      },
                        icon: Icon(Icons.delete),color: Colors.redAccent,)
                    ],
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        customDesignController.activeCustomDesigns[i].designTitle,
                      ),
                      subtitle: Text(
                        customDesignController.activeCustomDesigns[i].designDescription,
                      ),
                      leading: Image(
                        image: NetworkImage(customDesignController.activeCustomDesigns[i].designImage,),
                        width: 50,
                      )
                  ),
                  Divider(),
                  ListTile(
                    leading: Text('Custom Design Status', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                    trailing: Text(
                      customDesignController.activeCustomDesigns[i].designStatus,
                      style: TextStyle(
                        fontSize: 16,
                        color: customDesignController.activeCustomDesigns[i].designStatus=='accepted' ?kbuttonColor:Colors.redAccent
                      ),
                    ),
                  ),
                  Visibility(
                    visible: customDesignController.activeCustomDesigns[i].designStatus=='accepted' ? true:false,
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          leading: Text('Custom Design Price', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          trailing: Text(
                            customDesignController.activeCustomDesigns[i].designPrice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                            leading: Text('Manufacturing Time', style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),),
                            trailing: customDesignController.activeCustomDesigns[i].manufacturingTime==null? Text(''):
                            Text(
                                customDesignController.activeCustomDesigns[i].manufacturingTime,
                                style: TextStyle(
                                  fontSize: 16,
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomRoundedButton2(
                            title: 'Place Order',
                            clickFuction: () {
                              if(customDesignController.activeCustomDesigns[i].designStatus=='accepted'){
                                customDesignOrderController.designId = customDesignController.activeCustomDesigns[i].designId;
                                customDesignController.selectedDesign(customDesignController.activeCustomDesigns[i],customDesignController.activeCustomDesigns[i].designPrice);
                              }
                              else{
                                Get.snackbar("Not Accepted", "Your Design is not accepted by the admin please wait for it.");
                              }

                            },
                            color: kbuttonColor,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: kbuttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                              child: InkWell(
                                onTap: (){
                                  Get.to(CustomDesignUpdateScreen(customDesignModel: customDesignController.activeCustomDesigns[i],));
                                },
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )),
                        )
                      ],
                    ),
                  )

                ],
              ),
            );
        },
        itemCount: customDesignController.activeCustomDesigns.length,
      ):Container(
        height: 200,
        child: Center(
          child: Text('No design has been found.',style: TextStyle(fontSize: 16),),
        ),
      )
      ),
    );
  }
}
