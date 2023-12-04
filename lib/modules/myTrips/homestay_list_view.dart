import 'package:flutter/material.dart';

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HomestayListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListView(
    {Key? key,
    this.isShowDate=false,
    required this.callback,
    required this.hotelData,
    required this.animationController,
    required this.animation})
    : super(key: key);

  @override
  Widget build(BuildContext context){
    return ListCellAnimationView(
      animation:animation,
      animationController: animationController,
      child: Padding(
        padding: EdgeInsets
      )
    )
  }


  }
  )
}
