import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import 'components/button_confirm_select.dart';
import 'components/date_model.dart';
import 'components/header_dropdown.dart';
import 'components/scroll_model.dart';
import 'custom_text_field.dart';

class CustomDateScrollSelection extends StatefulWidget {
  final String title;
  final Function(DateModel date) onChange;
  final DateModel? selectedValue;
  final String titleBottomSheet;
  final TextEditingController? controller;
  final ValueNotifier<String?>? errorText;
  final String? suffixIcon;
  final FocusNode? node;
  final bool? enable;
  final bool? isRequired;
  final String? hintText;
  final bool isShowIcTitle;
  final Widget? tooltipWidget;
  final DateTime? dateLimit;

  const CustomDateScrollSelection(
      {super.key,
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
      this.tooltipWidget,
      this.dateLimit,
      this.isShowIcTitle = false});

  @override
  State<CustomDateScrollSelection> createState() =>
      _CustomDateScrollSelectionState();
}

class _CustomDateScrollSelectionState extends State<CustomDateScrollSelection> {
  late TextEditingController _controller;
  DateModel? selectedValue;
  final dateTimeNow = DateTime.now();

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.selectedValue?.toStringDate() ?? '';
    selectedValue = widget.selectedValue?.dateTimeInit(
        year: widget.dateLimit?.year,
        month: widget.dateLimit?.month,
        day: widget.dateLimit?.day);

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
      controller: _controller,
      errorText: widget.errorText,
      isRequired: widget.isRequired,
      hintText: widget.hintText,
      onTap: () {
        _onSelect();
      },
      onTapSuffixIcon: () {
        _onSelect();
      },
      isShowIcTitle: widget.isShowIcTitle,
      tooltipWidget: widget.tooltipWidget,
    );
  }

  _onSelect() {
    if (widget.enable ?? true) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return CustomDateScrollSelectionContent(
            title: widget.title,
            onChange: (DateModel value) {
              selectedValue = value;
              widget.onChange(value);
              setState(() {});
              _controller.text = selectedValue?.toStringDate() ?? '';
            },
            titleBottomSheet: widget.titleBottomSheet,
            selectedValue: selectedValue,
          );
        },
      );
    }
  }
}

class CustomDateScrollSelectionContent extends StatefulWidget {
  final String title;
  final Function(DateModel date) onChange;
  final DateModel? selectedValue;
  final String titleBottomSheet;

  const CustomDateScrollSelectionContent({
    super.key,
    required this.title,
    required this.onChange,
    this.selectedValue,
    required this.titleBottomSheet,
  });

  @override
  State<CustomDateScrollSelectionContent> createState() =>
      _CustomDateScrollSelectionContentState();
}

class _CustomDateScrollSelectionContentState
    extends State<CustomDateScrollSelectionContent> {
  late DateModel selectedValue;
  final dateTimeNow = DateTime.now();

  @override
  void initState() {
    selectedValue = widget.selectedValue ??
        DateModel(
          year: dateTimeNow.year,
          month: dateTimeNow.month,
          day: dateTimeNow.day,
        );
    _updateScrollModels();
    super.initState();
  }

  void _updateScrollModels() {
    final now = DateTime.now();
    yearScrollModel.setMaxValue(now.year);

    if (selectedValue.year == now.year) {
      monthScrollModel.setMaxValue(now.month);

      if (selectedValue.month > now.month) {
        selectedValue = selectedValue.copyWith(month: now.month, day: 1);
      }

      if (selectedValue.month == now.month) {
        dayScrollModel.setMaxValue(now.day);

        if (selectedValue.day > now.day) {
          selectedValue = selectedValue.copyWith(day: now.day);
        }
      } else {
        int maxDay =
            DateTime(selectedValue.year, selectedValue.month + 1, 0).day;
        dayScrollModel.setMaxValue(maxDay);

        if (selectedValue.day > maxDay) {
          selectedValue = selectedValue.copyWith(day: maxDay);
        }
      }
    } else {
      monthScrollModel.setMaxValue(12);
      int maxDay = DateTime(selectedValue.year, selectedValue.month + 1, 0).day;
      dayScrollModel.setMaxValue(maxDay);

      if (selectedValue.day > maxDay) {
        selectedValue = selectedValue.copyWith(day: maxDay);
      }
    }
  }

  void _onYearChanged(int year) {
    setState(() {
      selectedValue = selectedValue.copyWith(year: year);
      _updateScrollModels();
    });
  }

  void _onMonthChanged(int month) {
    setState(() {
      selectedValue = selectedValue.copyWith(month: month);
      _updateScrollModels();
    });
  }

  void _onDayChanged(int day) {
    setState(() {
      selectedValue = selectedValue.copyWith(day: day);
      _updateScrollModels();
    });
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
                          initialItem: selectedValue.year -
                              yearScrollModel.getMinValue(),
                        ),
                        onSelectedItemChanged: (index) {
                          _onYearChanged(index + yearScrollModel.getMinValue());
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
                        childCount: yearScrollModel.getMaxValue() -
                            yearScrollModel.getMinValue() +
                            1,
                        itemBuilder: (context, index) {
                          final itemValue =
                              index + yearScrollModel.getMinValue();
                          final isSelected = itemValue == selectedValue.year;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                yearScrollModel.getDisplayWithUnit(itemValue),
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
                          initialItem: selectedValue.month -
                              monthScrollModel.getMinValue(),
                        ),
                        onSelectedItemChanged: (index) {
                          _onMonthChanged(
                              index + monthScrollModel.getMinValue());
                        },
                        selectionOverlay: IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: AppColors.primary.primary100
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        childCount: monthScrollModel.getMaxValue() -
                            monthScrollModel.getMinValue() +
                            1,
                        itemBuilder: (context, index) {
                          final itemValue =
                              index + monthScrollModel.getMinValue();
                          final isSelected = itemValue == selectedValue.month;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                monthScrollModel.getDisplayWithUnit(itemValue),
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
                        vertical: AppSpacing.spacing3,
                      ),
                      height: 292.h,
                      child: CupertinoPicker.builder(
                        squeeze: 1,
                        diameterRatio: 6,
                        useMagnifier: true,
                        itemExtent: 52.h,
                        backgroundColor: AppColors.white.white,
                        scrollController: FixedExtentScrollController(
                          initialItem:
                              selectedValue.day - dayScrollModel.getMinValue(),
                        ),
                        onSelectedItemChanged: (index) {
                          _onDayChanged(index + dayScrollModel.getMinValue());
                        },
                        selectionOverlay: IgnorePointer(
                          ignoring: true,
                          child: Align(
                            child: Container(
                              margin: EdgeInsets.only(right: 16.w),
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight:
                                      Radius.circular(AppSpacing.spacing3),
                                  bottomRight:
                                      Radius.circular(AppSpacing.spacing3),
                                ),
                                color: AppColors.primary.primary100
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        childCount: dayScrollModel.getMaxValue() -
                            dayScrollModel.getMinValue() +
                            1,
                        itemBuilder: (context, index) {
                          final itemValue =
                              index + dayScrollModel.getMinValue();
                          final isSelected = itemValue == selectedValue.day;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                dayScrollModel.getDisplayWithUnit(itemValue),
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
}
