import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
 final String message;
  ProgressDialog({this.message,});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(8),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kbuttonColor),
              ),
              SizedBox(width: 10,),
              Text(message,style:TextStyle(
                fontSize: 14
              )
                )
            ],
          )
          // Row(
          //   children: [
          //     CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kbuttonColor),),
          //     SizedBox(width: 10,),
          //   ],
          // ),
        ),
      ),
    );
  }
}
