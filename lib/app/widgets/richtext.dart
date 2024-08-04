import 'package:flutter/material.dart';
import 'package:otakudev/app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimeInfoText {
  static RichText text(
    String leftText,
    String rightText,
  ) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$leftText: ",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),
          TextSpan(
            text: rightText,
            style: TextStyle(
              fontSize: 14.sp,
              color: darkColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
