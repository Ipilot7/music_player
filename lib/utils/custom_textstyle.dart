import 'package:flutter/material.dart';
import 'package:solid/utils/colors.dart';


//Стиль Кнопки !

ButtonStyle buttonStyle(
    {Color? color,
    Color? shadowColor,
    double? elevation,
    EdgeInsets? padding,
    double? borderRadius,
    Size? size,
    BorderSide? side}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(color),
    shadowColor: MaterialStateProperty.all(shadowColor),
    elevation: MaterialStateProperty.all(elevation),
    padding: MaterialStateProperty.all(padding),
    minimumSize: MaterialStateProperty.all(size),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          side: side ?? BorderSide.none),
    ),
  );
}

// Стиль Текста !

TextStyle kTextstyle(
    {Color? color,
    double? size = 14,
    FontWeight fontWeight = FontWeight.w500,
    double? height,
    double? letterSpasing}) {
  return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpasing,
      height: height);
}
