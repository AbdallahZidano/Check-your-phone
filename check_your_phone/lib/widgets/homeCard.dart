import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/colorHelper.dart';
import '../helper/navigatorHelper.dart';

Widget buildHomeCard(
    BuildContext context, String image, String name, Widget screen) {
  return InkWell(
    onTap: () {
      goTo(context, screen);
    },
    child: Container(
      decoration: BoxDecoration(
        color: ColorsHelper.darkGrey,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            child: Image.asset(
              'assets/images/' + image,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          )
        ],
      ),
    ),
  );
}
