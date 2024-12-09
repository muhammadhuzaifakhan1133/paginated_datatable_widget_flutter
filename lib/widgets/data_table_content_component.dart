import 'package:flutter/material.dart';

class DataTableContentComponent1 extends StatelessWidget {
  final double width;
  final String contentText;
  final String? toolTipText;
  final String? profileImgPath;
  final bool isShowProfile;
  final bool? isRightBorder;
  final bool? isBottomBorder;
  final TextStyle? myTextStyle;

  const DataTableContentComponent1(
      {super.key,
      required this.width,
      required this.contentText,
      this.toolTipText,
      this.profileImgPath,
      this.isShowProfile = false,
      this.myTextStyle,
      this.isRightBorder,
      this.isBottomBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: double.maxFinite,
      width: width,
      // padding: const EdgeInsets.only(left: 30.0),
      // decoration: BoxDecoration(
      // border: Border(
      //     left: BorderSide(color: AppColors.blackShade2Color),
      //     bottom: isBottomBorder == true
      //         ? BorderSide(color: AppColors.blackShade2Color)
      //         : BorderSide(color: Colors.transparent),
      //     right: isRightBorder == true
      //         ? BorderSide(color: AppColors.blackShade2Color)
      //         : BorderSide(color: Colors.transparent))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isShowProfile) ...[
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                      image: AssetImage(profileImgPath.toString()))),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          Flexible(
            child: Tooltip(
              message: toolTipText,
              // textStyle: AppTextstyles.l300white12,
              triggerMode: TooltipTriggerMode.tap,
              showDuration: const Duration(milliseconds: 2000),
              padding: const EdgeInsets.all(8),
              child: Text(
                contentText,
                style: myTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
