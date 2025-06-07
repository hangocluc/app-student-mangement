import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import 'components/button_confirm_select.dart';
import 'components/header_dropdown.dart';
import 'components/scroll_model.dart';
import 'custom_text_field.dart';

class CustomScrollSelection extends StatefulWidget {
  final String title;
  final ScrollModel scrollModel;
  final Function(int value) onChange;
  final int? selectedValue;
  final String titleBottomSheet;
  final TextEditingController? controller;
  final ValueNotifier<String?>? errorText;
  final String? suffixIcon;
  final FocusNode? node;
  final bool? enable;
  final bool? isRequired;
  final String? hintText;
  final bool? isShowIcTitle;
  final Widget? tooltipWidget;
  final Widget? widgetSubTitle;

  const CustomScrollSelection({
    super.key,
    required this.title,
    required this.scrollModel,
    required this.onChange,
    this.selectedValue,
    this.controller,
    this.errorText,
    required this.titleBottomSheet,
    this.suffixIcon,
    this.node,
    this.isRequired,
    this.hintText,
    this.isShowIcTitle = false,
    this.enable,
    this.tooltipWidget,
    this.widgetSubTitle,
  });

  @override
  State<CustomScrollSelection> createState() => _CustomScrollSelectionState();
}

class _CustomScrollSelectionState extends State<CustomScrollSelection> {
  late TextEditingController _controller;
  int? selectedValue;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    selectedValue = widget.selectedValue;
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
      node: widget.node,
      isDropDown: true,
      controller: _controller,
      errorText: widget.errorText,
      enable: widget.enable,
      hintText: widget.hintText,
      isRequired: widget.isRequired,
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
    if (!(widget.enable ?? true)) {
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomScrollSelectionContent(
          title: widget.title,
          scrollModel: widget.scrollModel,
          onChange: (int value) {
            selectedValue = value;
            widget.onChange(value);
            setState(() {});
            _controller.text = widget.scrollModel.getDisplayNoUnit(value);
          },
          titleBottomSheet: widget.titleBottomSheet,
          selectedValue: selectedValue,
        );
      },
    );
  }
}

class CustomScrollSelectionContent extends StatefulWidget {
  final String title;
  final ScrollModel scrollModel;
  final Function(int value) onChange;
  final int? selectedValue;
  final String titleBottomSheet;

  const CustomScrollSelectionContent({
    super.key,
    required this.title,
    required this.scrollModel,
    required this.onChange,
    this.selectedValue,
    required this.titleBottomSheet,
  });

  @override
  State<CustomScrollSelectionContent> createState() =>
      _CustomScrollSelectionContentState();
}

class _CustomScrollSelectionContentState
    extends State<CustomScrollSelectionContent> {
  late int selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedValue ?? widget.scrollModel.initValue();
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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.spacing3),
                height: 292.h,
                child: CupertinoPicker.builder(
                  squeeze: 1,
                  diameterRatio: 6,
                  useMagnifier: true,
                  itemExtent: 52.h,
                  backgroundColor: AppColors.white.white,
                  scrollController: FixedExtentScrollController(
                      initialItem:
                          selectedValue - widget.scrollModel.getMinValue()),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedValue = value + widget.scrollModel.getMinValue();
                    });
                  },
                  selectionOverlay: IgnorePointer(
                    ignoring: true,
                    child: Align(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width - 32,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.spacing3),
                          color: AppColors.primary.primary100.withOpacity(0.5),
                          border:
                              Border.all(color: AppColors.primary.primary50),
                        ),
                      ),
                    ),
                  ),
                  childCount: widget.scrollModel.getMaxValue() -
                      widget.scrollModel.getMinValue(),
                  itemBuilder: (context, index) {
                    final itemValue = index + widget.scrollModel.getMinValue();
                    final isSelected = itemValue == selectedValue;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.scrollModel.getDisplayNoUnit(
                              index + widget.scrollModel.getMinValue()),
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
                            // '%',
                            widget.scrollModel is CommonScrollModel
                                ? (widget.scrollModel as CommonScrollModel)
                                    .getUnit()
                                : '%',
                            style: AppTypography().bodyLargeRegular.copyWith(
                                  color: AppColors.theBlack.theBlack500,
                                ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            ButtonConfirmSelect(
              onTap: () {
                widget.onChange(selectedValue);
                Navigator.pop(context);
              },
              title: 'Choose',
            )
          ],
        ),
      ),
    );
  }
}
