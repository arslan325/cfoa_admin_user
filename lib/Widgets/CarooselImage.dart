import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(height:170,
          autoPlay: true,
          aspectRatio: 2.0,
          autoPlayAnimationDuration: Duration(seconds: 2),
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayInterval: Duration(seconds: 3),
          //scrollDirection: Axis.vertical,
        ),
        items: [
          MyImageView("images/image1.jpg"),
          MyImageView("images/image2.jpg"),
          MyImageView("images/image1.jpg"),
          MyImageView("images/image2.jpg"),
          MyImageView("images/image1.jpg"),
          MyImageView("images/image2.jpg"),
        ]
    );
  }

}

class MyImageView extends StatelessWidget {
  String imgPath;
  MyImageView(this.imgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 600,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
          ),
        )
    );
  }
}
