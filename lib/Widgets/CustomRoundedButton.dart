import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
class CustomRoundedButton extends StatelessWidget {
  final String title;
  final Function clickFuction;
  const CustomRoundedButton({this.title,this.clickFuction});
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: width*0.9,
      child: MaterialButton(
        elevation: 1,
        color: kbuttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: clickFuction,
        child:
        Align(
          alignment: Alignment.center,
          child: Text(title, style: kbuttonStyle,),
        ),
      ),
    );
  }
}
class CustomRoundedButton2 extends StatelessWidget {
  final String title;
  final Function clickFuction;
  final Color color;
  const CustomRoundedButton2({this.title,this.clickFuction,this.color});
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      child: MaterialButton(
        elevation: 1,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: clickFuction,
        child:
        Align(
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),),
        ),
      ),
    );
  }
}