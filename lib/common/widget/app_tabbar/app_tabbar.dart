import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/app_typography.dart';

class AppTabBar extends StatefulWidget {
  final bool? tabBarVisible;
  final Widget widgetLeft;
  final Widget widgetRight;
  final String titleLeft;
  final String titleRight;

  final BorderRadius? borderRadius;
  final Function(int)? switchTabCallBack;
  final Color? tabBarBackgroundColor;
  final Color? tabBarColor;
  final Color? selectedTabColor;
  final Color? unSelectedTabColor;
  final int tabIndex;
  final EdgeInsets? paddingTitleTab;
  final List<BoxShadow>? boxShadow;
  final TextStyle? styleSelectTitle;
  final TextStyle? styleUnSelectTitle;
  final EdgeInsetsGeometry? paddingTabContainer;
  final EdgeInsetsGeometry? marginTabBar;

  const AppTabBar(
      {super.key,
      this.switchTabCallBack,
      required this.widgetLeft,
      required this.widgetRight,
      required this.titleLeft,
      required this.titleRight,
      this.borderRadius,
      this.tabBarVisible,
      this.tabIndex = 0,
      this.tabBarBackgroundColor,
      this.tabBarColor,
      this.selectedTabColor,
      this.unSelectedTabColor,
      this.paddingTitleTab,
      this.boxShadow,
      this.styleSelectTitle,
      this.styleUnSelectTitle,
      this.paddingTabContainer,
      this.marginTabBar});

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  late int tabIndex;

  @override
  void initState() {
    super.initState();
    tabIndex = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: widget.tabBarVisible ?? true,
          child: Container(
            margin: widget.marginTabBar,
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
                color: widget.tabBarColor ?? AppColors.other.ColorF8F9FA,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: widget.boxShadow ?? []),
            child: Row(
              children: [
                _buildTabButton(context, widget.titleLeft, 0),
                const SizedBox(
                  width: 4,
                ),
                _buildTabButton(context, widget.titleRight, 1),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: widget.paddingTabContainer,
            child: IndexedStack(
              index: tabIndex,
              children: [
                SingleChildScrollView(
                  child: widget.widgetLeft,
                ),
                SingleChildScrollView(
                  child: widget.widgetRight,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildTabButton(BuildContext context, String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            tabIndex = index;
            widget.switchTabCallBack?.call(tabIndex);
          });
        },
        child: Container(
          padding: widget.paddingTitleTab ??
              EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: index == tabIndex
                  ? widget.selectedTabColor ?? AppColors.white.white
                  : widget.unSelectedTabColor ?? AppColors.other.ColorF8F9FA,
              borderRadius: BorderRadius.circular(8),
              boxShadow: index == tabIndex
                  ? [
                      const BoxShadow(
                        color: Color(0x1C273114),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ]
                  : []),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: tabIndex == index
                ? widget.styleSelectTitle ??
                    AppTypography().bodySmallMedium.copyWith(
                          color: AppColors.theBlack.theBlack900,
                        )
                : widget.styleUnSelectTitle ??
                    AppTypography().bodySmallMedium.copyWith(
                          color: AppColors.theBlack.theBlack600,
                        ),
          ),
        ),
      ),
    );
  }
}
