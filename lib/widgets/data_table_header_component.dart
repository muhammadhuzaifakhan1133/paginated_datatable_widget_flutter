import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class DataTableHeaderComponent extends StatelessWidget {
  final String headerTitle;
  final String? iconPath;
  final double? width;
  final bool? isCenter;
  final bool? isTopRightRound;
  final bool? isRightRound;

  final bool? isLeftRound;

  final bool? isTopLeftRound;

  const DataTableHeaderComponent({
    super.key,
    required this.headerTitle,
    this.iconPath,
    this.width,
    this.isCenter = false,
    this.isTopRightRound = false,
    this.isTopLeftRound = false,
    this.isRightRound,
    this.isLeftRound,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 40,
          width: width,
          decoration: BoxDecoration(
              // color: AppColors.darkSkyBlueColor.withOpacity(0.2),
              color: AppColors.purpleColor.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topLeft: isLeftRound == true
                    ? const Radius.circular(4)
                    : Radius.zero,
                topRight: isRightRound == true
                    ? const Radius.circular(4)
                    : Radius.zero,
                bottomLeft: isLeftRound == true
                    ? const Radius.circular(4)
                    : Radius.zero,
                bottomRight: isRightRound == true
                    ? const Radius.circular(4)
                    : Radius.zero,
              )),
          child: Center(
            child: Row(
              mainAxisAlignment: (isCenter == true)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  headerTitle,
                  style: TextStyle(fontSize: 14, color: AppColors.whiteColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
