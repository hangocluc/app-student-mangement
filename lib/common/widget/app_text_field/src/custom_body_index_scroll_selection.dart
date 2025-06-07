import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import 'components/body_index_model.dart';
import 'components/button_confirm_select.dart';
import 'components/header_dropdown.dart';
import 'components/scroll_model.dart';
import 'custom_text_field.dart';

class CustomBodyIndexScrollSelection extends StatefulWidget {
  final String title;
  final Function(BodyIndexModel bodyIndex) onChange;
  final BodyIndexModel? selectedValue;
  final String titleBottomSheet;
  final TextEditingController? controller;
  final ValueNotifier<String?>? errorText;
  final String? suffixIcon;
  final FocusNode? node;
  final bool? enable;
  final bool? isRequired;
  final String? hintText;
  final CommonScrollModel bodyIndexInteger;
  final CommonScrollModel bodyIndexDecimal;
  final bool isShowIcTitle;
  final Widget? tooltipWidget;
  final Widget? widgetSubTitle;
  final bool showInitValue;

  const CustomBodyIndexScrollSelection({
    super.key,
    required this.title,
    required this.onChange,
    this.selectedValue,
    this.controller,
    this.errorText,
    required this.titleBottomSheet,
    this.suffixIcon,
    this.node,
    this.hintText,
    this.enable,
    this.isRequired,
    required this.bodyIndexDecimal,
    required this.bodyIndexInteger,
    this.isShowIcTitle = false,
    this.tooltipWidget,
    this.widgetSubTitle,
    this.showInitValue = true,
  });

  @override
  State<CustomBodyIndexScrollSelection> createState() =>
      _CustomBodyIndexScrollSelectionState();
}

class _CustomBodyIndexScrollSelectionState
    extends State<CustomBodyIndexScrollSelection> {
  late TextEditingController _controller;
  BodyIndexModel? selectedValue;
  BodyIndexModel? initValue;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    if (widget.selectedValue != null) {
      _controller.text = widget.showInitValue
          ? widget.selectedValue?.toStringBodyIndex() ?? ''
          : '';
      selectedValue = widget.selectedValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomTextField(
      title: widget.title,
      suffixIcon: widget.suffixIcon ?? appIcon.icChevronDown.path,
      readOnly: true,
      enable: widget.enable,
      node: widget.node,
      isDropDown: true,
      isShowIcTitle: widget.isShowIcTitle,
      controller: _controller,
      errorText: widget.errorText,
      isRequired: widget.isRequired,
      hintText: widget.hintText,
      tooltipWidget: widget.tooltipWidget,
      widgetSubTitle: widget.widgetSubTitle,
      onTap: () {
        _onSelect();
      },
      onTapSuffixIcon: () {
        _onSelect();
      },
    );
  }

  _onSelect() {
    if (widget.enable ?? true) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return CustomBodyIndexScrollSelectionContent(
            title: widget.title,
            onChange: (BodyIndexModel value) {
              selectedValue = value;
              widget.onChange(value);
              setState(() {});
              _controller.text = selectedValue?.toStringBodyIndex() ?? '';
            },
            titleBottomSheet: widget.titleBottomSheet,
            selectedValue: selectedValue,
            bodyIndexInteger: widget.bodyIndexInteger,
            bodyIndexDecimal: widget.bodyIndexDecimal,
          );
        },
      );
    }
  }
}

class CustomBodyIndexScrollSelectionContent extends StatefulWidget {
  final String title;
  final Function(BodyIndexModel time) onChange;
  final BodyIndexModel? selectedValue;
  final String titleBottomSheet;
  final CommonScrollModel bodyIndexInteger;
  final CommonScrollModel bodyIndexDecimal;

  const CustomBodyIndexScrollSelectionContent({
    super.key,
    required this.title,
    required this.onChange,
    this.selectedValue,
    required this.titleBottomSheet,
    required this.bodyIndexInteger,
    required this.bodyIndexDecimal,
  });

  @override
  State<CustomBodyIndexScrollSelectionContent> createState() =>
      _CustomBodyIndexScrollSelectionContentState();
}

class _CustomBodyIndexScrollSelectionContentState
    extends State<CustomBodyIndexScrollSelectionContent> {
  late BodyIndexModel selectedValue;

  @override
  void initState() {
    selectedValue =
        widget.selectedValue ?? BodyIndexModel(integerPart: 0, decimal: 0);
    super.initState();
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
            HeaderDropdown(
              title: widget.titleBottomSheet,
            ),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.spacing3),
                      height: 292.h,
                      child: CupertinoPicker.builder(
                        squeeze: 1,
                        diameterRatio: 6,
                        useMagnifier: true,
                        itemExtent: 52.h,
                        backgroundColor: AppColors.white.white,
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedValue.integerPart -
                              widget.bodyIndexInteger.getMinValue(),
                        ),
                        onSelectedItemChanged: (index) {
                          final selectValue =
                              index + widget.bodyIndexInteger.getMinValue();

                          setState(() {
                            selectedValue = selectedValue.copyWith(
                                integerPart: selectValue);
                          });
                        },
                        selectionOverlay: IgnorePointer(
                          ignoring: true,
                          child: Align(
                            child: Container(
                              margin: EdgeInsets.only(left: 16.w),
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSpacing.spacing3),
                                  bottomLeft:
                                      Radius.circular(AppSpacing.spacing3),
                                ),
                                color: AppColors.primary.primary100
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        childCount: widget.bodyIndexInteger.getMaxValue() -
                            widget.bodyIndexInteger.getMinValue(),
                        itemBuilder: (context, index) {
                          final itemValue =
                              index + widget.bodyIndexInteger.getMinValue();
                          final isSelected =
                              itemValue == selectedValue.integerPart;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.bodyIndexInteger
                                    .getDisplayNoUnit(itemValue),
                                style: AppTypography().heading5.copyWith(
                                      color: isSelected
                                          ? AppColors.secondary.secondary400
                                          : AppColors.theBlack.theBlack500,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.spacing3),
                      height: 292.h,
                      child: CupertinoPicker.builder(
                        squeeze: 1,
                        diameterRatio: 6,
                        useMagnifier: true,
                        itemExtent: 52.h,
                        backgroundColor: AppColors.white.white,
                        scrollController: FixedExtentScrollController(
                            initialItem: selectedValue.decimal),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedValue =
                                selectedValue.copyWith(decimal: value);
                          });
                        },
                        selectionOverlay: IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(right: 16.w),
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight:
                                      Radius.circular(AppSpacing.spacing3),
                                  // Round the top-left corner
                                  bottomRight: Radius.circular(AppSpacing
                                      .spacing3), // Round the bottom-left corner
                                ),
                                color: AppColors.primary.primary100
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        childCount: widget.bodyIndexDecimal.getMaxValue() -
                            widget.bodyIndexDecimal.getMinValue(),
                        itemBuilder: (context, index) {
                          final itemValue =
                              index + widget.bodyIndexDecimal.getMinValue();
                          final isSelected = itemValue == selectedValue.decimal;
                          return Container(
                            margin: const EdgeInsets.only(
                              left: AppSpacing.spacing10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _getValueHasDot(isSelected, index),
                                  style: AppTypography().heading5.copyWith(
                                      color: isSelected
                                          ? AppColors.secondary.secondary400
                                          : AppColors.theBlack.theBlack500,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: AppSpacing.spacing8,
                                ),
                                Visibility(
                                  visible: isSelected,
                                  child: Text(
                                    widget.bodyIndexDecimal.getUnit(),
                                    style: AppTypography()
                                        .bodyLargeRegular
                                        .copyWith(
                                          color: AppColors.theBlack.theBlack500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            ButtonConfirmSelect(
              onTap: () {
                widget.onChange(selectedValue);
                Navigator.pop(context);
              },
              title: 'Choose',
            ),
          ],
        ),
      ),
    );
  }

  _getValueHasDot(bool isSelect, int index) {
    return '${isSelect ? '.' : ''}${widget.bodyIndexDecimal.getDisplayNoUnit(index + widget.bodyIndexDecimal.getMinValue())}';
  }
}
