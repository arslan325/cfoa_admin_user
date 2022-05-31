import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomDesignDetail.dart';
class AllCustomDesignListed extends StatefulWidget {
  @override
  _AllCustomDesignListedState createState() => _AllCustomDesignListedState();
}

class _AllCustomDesignListedState extends State<AllCustomDesignListed> {
  @override
  Widget build(BuildContext context) {
    print(customDesignController.allDesigns.length);
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Custom Designs",
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
      body: Obx(()=> (customDesignController.allDesigns.length) > 0 ? ListView.builder(
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
                      Text(customDesignController.allDesigns[i].designId,style: TextStyle(
                          fontSize: 16
                      ),
                      ),
                      SizedBox(width: 50),
                      Visibility(
                        visible: (customDesignController.allDesigns[i].designStatus == 'accepted') ? false :true,
                        child: IconButton(onPressed: (){
                          showCustomDesignDeleteAlert(customDesignController.allDesigns[i].designId);
                        },
                          icon: Icon(Icons.delete),color: Colors.redAccent,),
                      )
                    ],
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        customDesignController.allDesigns[i].designTitle,
                      ),
                      leading: Image(
                        image: NetworkImage(customDesignController.allDesigns[i].designImage,),
                        width: 70,
                      )
                  ),
                  Divider(),
                  ListTile(
                    leading: Text('Custom Design Status', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                    trailing: Text(
                        customDesignController.allDesigns[i].designStatus,
                      style: TextStyle(
                          fontSize: 16,
                          color: customDesignController.allDesigns[i].designStatus=='accepted' ? kbuttonColor :Colors.redAccent
                      ),
                    ),
                  ),
                  Visibility(
                    visible: customDesignController.allDesigns[i].designStatus=='accepted' ? true:false,
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          leading: Text('Custom Design Price', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          trailing: Text(
                            customDesignController.allDesigns[i].designPrice.toString(),
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
                          trailing: customDesignController.allDesigns[i].manufacturingTime==null? Text(''):
                          Text(
                            customDesignController.allDesigns[i].manufacturingTime,
                            style: TextStyle(
                                fontSize: 16,
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: CustomRoundedButton(title: 'Update Design details',
                          clickFuction: () {
                            Get.to(CustomDesignDetailScreen(customDesignModel: customDesignController.allDesigns[i],));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
        },
        itemCount: customDesignController.allDesigns.length,
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
