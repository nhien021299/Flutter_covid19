import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;
  final Color bgColor;

  CustomAppBar({
    @required this.child,
    this.height ,
    this.bgColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: bgColor,
      alignment: Alignment.bottomCenter,
      child: child,
    );
  }
}