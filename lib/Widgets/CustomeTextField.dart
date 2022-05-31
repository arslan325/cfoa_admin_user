import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController textEditController;
  Function validator;
  IconData prefixIcon;
  bool obscureText;
  IconButton suffixIcon;
  TextInputType keyboardType;
  var inputFormatter;
  String hintText;
  String url;
  int maxLine;
  int minLine;
  int maxLength;
   CustomTextField({
     this.textEditController,
     this.keyboardType,
     this.url,
     this.obscureText,
     this.hintText,
    this.validator,
     this.inputFormatter,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLine,
    this.minLine,
    this.maxLength
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditController,
      keyboardType:keyboardType,
      obscureText:obscureText==null?false:obscureText,
      inputFormatters: inputFormatter == null ? null : [inputFormatter],
      validator: validator,
      minLines: minLine,
      maxLines: maxLine,
      maxLength: maxLength,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: url != null ? Container(
            margin: EdgeInsets.all(10),
            child: SvgPicture.asset(
              url,
              color: kbuttonColor,
              width: 2),
          ):prefixIcon != null?
           Icon(prefixIcon,color: kbuttonColor,):null,
          suffixIcon:suffixIcon == null ? null : suffixIcon,
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(8)
          )
      ),
    );
  }
}

class SimpleTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

