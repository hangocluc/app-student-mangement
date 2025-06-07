import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../app_button/app_button.dart';
import '../../app_icon/app_asset_image.dart';
import 'custom_text_field.dart';

class CustomNumberSelection extends StatefulWidget {
  final String title;
  final Function(int value) onChange;
  final int? selectedValue;
  final String titleBottomSheet;
  final TextEditingController? controller;
  final ValueNotifier<String?>? errorText;
  final String? suffixIcon;
  final FocusNode? node;
  final bool? enable;
  final String? unit;
  final int min;
  final int? max;
  final bool? isRequired;
  final String? hintText;
  final bool? isShowIcTitle;

  const CustomNumberSelection(
      {super.key,
      required this.title,
      required this.onChange,
      this.selectedValue,
      this.controller,
      this.errorText,
      required this.titleBottomSheet,
      this.suffixIcon,
      this.node,
      this.enable,
      this.unit,
      this.isRequired,
      required this.min,
      this.max,
      this.isShowIcTitle = false,
      this.hintText});

  @override
  State<CustomNumberSelection> createState() => _CustomNumberSelectionState();
}

class _CustomNumberSelectionState extends State<CustomNumberSelection> {
  late TextEditingController _controller;
  int? selectedValue;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    if (selectedValue != null) {
      _controller.text = selectedValue.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomTextField(
      isShowIcTitle: widget.isShowIcTitle,
      title: widget.title,
      suffixIcon: widget.suffixIcon ?? appIcon.icChevronDown.path,
      readOnly: true,
      isDropDown: true,
      node: widget.node,
      controller: _controller,
      errorText: widget.errorText,
      enable: widget.enable,
      isRequired: widget.isRequired,
      hintText: widget.hintText,
      onTap: () {
        _onSelect();
      },
      onTapSuffixIcon: () {
        _onSelect();
      },
    );
  }

  _onSelect() {
    if (!(widget.enable ?? true)) {
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomNumberSelectionContent(
          title: widget.title,
          onChange: (int value) {
            selectedValue = value;
            widget.onChange(value);
            setState(() {});
            _controller.text = value.toString();
          },
          titleBottomSheet: widget.titleBottomSheet,
          selectedValue: selectedValue,
          min: widget.min,
          max: widget.max,
          unit: widget.unit,
        );
      },
    );
  }
}

class CustomNumberSelectionContent extends StatefulWidget {
  final String title;
  final Function(int value) onChange;
  final int? selectedValue;
  final String titleBottomSheet;
  final String? unit;
  final int min;
  final int? max;

  const CustomNumberSelectionContent(
      {super.key,
      required this.title,
      required this.onChange,
      this.selectedValue,
      required this.titleBottomSheet,
      this.unit,
      required this.min,
      required this.max});

  @override
  State<CustomNumberSelectionContent> createState() =>
      _CustomNumberSelectionContentState();
}

class _CustomNumberSelectionContentState
    extends State<CustomNumberSelectionContent> {
  late int selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedValue ?? 1000;
    super.initState();
  }

  final step = 50;

  void increase() {
    if (widget.max != null) {
      if (selectedValue + step > widget.max!) {
        return;
      } else {
        setState(() {
          selectedValue += step;
        });
      }
    } else {
      setState(() {
        selectedValue += step;
      });
    }
  }

  void decrease() {
    if (selectedValue - step < widget.min) {
      return;
    } else {
      setState(() {
        selectedValue -= step;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white.white,
          borderRadius: const BorderRadius.only(
              topLeft: AppRadius.radius6, topRight: AppRadius.radius6),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing4,
                  vertical: AppSpacing.spacing6),
              decoration: BoxDecoration(
                color: AppColors.white.white,
                borderRadius: const BorderRadius.only(
                    topLeft: AppRadius.radius6, topRight: AppRadius.radius6),
                border: Border(
                  bottom: BorderSide(
                    width: 1.h,
                    color: AppColors.theBlack.theBlack50,
                  ),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography()
                          .bodyMediumSemiBold
                          .copyWith(color: AppColors.theBlack.theBlack900),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.spacing2),
                        child: AppAssetImage(path: appIcon.icClose.path),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.spacing4),
              height: 160.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      decrease();
                    },
                    child: Container(
                      height: 44.w,
                      width: 44.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary.primary400,
                        borderRadius:
                            const BorderRadius.all(AppRadius.radiusMax),
                      ),
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: AppAssetImage(
                          path: appIcon.icAddSquare.path,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          "$selectedValue",
                          style: AppTypography().heading3.copyWith(
                                color: AppColors.primary.primary500,
                              ),
                        ),
                        Text(
                          widget.unit ?? '',
                          style: AppTypography().bodyMediumMedium.copyWith(
                                color: AppColors.secondary.secondary950,
                              ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      increase();
                    },
                    child: Container(
                      height: 44.w,
                      width: 44.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary.primary400,
                        borderRadius:
                            const BorderRadius.all(AppRadius.radiusMax),
                      ),
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: AppAssetImage(
                          path: appIcon.icAddSquare.path,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
              height: 44.h,
              radius: AppRadius.radius3.x,
              buttonColor: AppColors.white.white,
              borderColor: AppColors.primary.primary400,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.spacing3,
                horizontal: AppSpacing.spacing5,
              ),
              margin: const EdgeInsets.only(
                top: AppSpacing.spacing3,
                bottom: AppSpacing.spacing4,
                left: AppSpacing.spacing4,
                right: AppSpacing.spacing4,
              ),
              onTap: () {
                widget.onChange(selectedValue);
                Navigator.pop(context);
              },
              title: 'Done',
              titleStyle: AppTypography().bodyXSmallSemiBold.copyWith(
                    color: AppColors.primary.primary400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
