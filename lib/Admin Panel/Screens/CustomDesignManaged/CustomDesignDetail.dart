import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CustomDesignModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDesignDetailScreen extends StatefulWidget {
  final CustomDesignModel customDesignModel;
 const CustomDesignDetailScreen({this.customDesignModel});
  @override
  _CustomDesignDetailScreenState createState() => _CustomDesignDetailScreenState();
}

class _CustomDesignDetailScreenState extends State<CustomDesignDetailScreen> {
  String _selectedLocation ;
  List<String> days =[];
  void initState() {
    super.initState();
    for(var i=1;i<=30;i++){
      days.add('$i Days');
    }

  }
  TextEditingController _customDesignPriceTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Design Detail",
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
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          child: Text('Design Id:',style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),)
                      ),
                      Text(widget.customDesignModel.designId,style: TextStyle(
                          fontSize: 16
                      ),
                      ),
                    ],
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        widget.customDesignModel.designTitle,
                      ),
                      subtitle: Text(
                        widget.customDesignModel.designDescription,
                      ),
                      leading: Image(
                        image: NetworkImage(widget.customDesignModel.designImage,),
                        width: 50,
                      )
                  ),
                  Divider(),
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                          child:Container(
                            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text('Choose manufacturing days'), // Not necessary for Option 1
                                      value:_selectedLocation,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedLocation = newValue;
                                        });
                                      },
                                      items: days.map((location) {
                                        return DropdownMenuItem(
                                          child: Text(location),
                                          value: location,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.030,),
                                TextFormField(
                                  controller: _customDesignPriceTextEditController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please enter design price';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Design Price*',
                                      border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      )
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: CustomRoundedButton(title: 'Confirm Design',
                      clickFuction: () {
                        if(_selectedLocation == null){
                          authentication.displayToast('please select manufacturing days');
                        }
                       else if(_formKey.currentState.validate()){
                         showLoading();
                          customDesignController.updateCustomDesignStatus({
                            'Design Status':'accepted',
                            'Manufacturing Time':_selectedLocation,
                            'Design Price':double.parse(_customDesignPriceTextEditController.text)
                          },
                              widget.customDesignModel,
                          ).whenComplete(() => {
                                dismissibleLoading(),
                                Get.back(),
                          });
                        }
                        //Get.to(OrderDetails(orderModel: orderController.activeOrders[i],));
                        //Get.to(TrackOrderScreen(orderModel: orderController.activeOrders[i],));
                      },
                    ),
                  ),
                ],
              ),
            )
      )
    );
  }
}
