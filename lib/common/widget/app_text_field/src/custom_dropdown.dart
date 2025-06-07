import 'package:flutter/material.dart';

import '../../../../main.dart';
import 'components/custom_selection.dart';
import 'components/dropdown_model.dart';
import 'custom_text_field.dart';

class AppCustomDropdown<T extends DropdownModel> extends StatefulWidget {
  final String title;
  final List<T> data;
  final T? selectedData;
  final String titleBottomSheet;
  final String? hintText;
  final bool? isRequired;
  final Function(DropdownModel? value) onChange;
  final TextEditingController? controller;
  final ValueNotifier<String?>? errorText;
  final String? suffixIcon;
  final FocusNode? node;
  final bool? enable;
  final String? descriptionDropdown;

  const AppCustomDropdown({
    super.key,
    required this.title,
    required this.data,
    this.selectedData,
    required this.onChange,
    required this.titleBottomSheet,
    this.isRequired,
    this.controller,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.node,
    this.enable,
    this.descriptionDropdown,
  });

  @override
  State<AppCustomDropdown> createState() => _AppCustomDropdownState<T>();
}

class _AppCustomDropdownState<T extends DropdownModel>
    extends State<AppCustomDropdown> {
  late TextEditingController _controller;

  DropdownModel? selectedData;

  @override
  void initState() {
    selectedData = widget.selectedData;
    _controller = widget.controller ?? TextEditingController();
    _controller.text = selectedData?.getItemDisplay() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomTextField(
      title: widget.title,
      suffixIcon: widget.suffixIcon ?? appIcon.icChevronDown.path,
      readOnly: true,
      node: widget.node,
      controller: _controller,
      hintText: widget.hintText,
      isRequired: widget.isRequired,
      errorText: widget.errorText,
      enable: widget.enable,
      onTap: () {
        _onSelect(context);
      },
      onTapSuffixIcon: () {
        _onSelect(context);
      },
      isDropDown: true,
    );
  }

  _onSelect(BuildContext context) {
    if (!(widget.enable ?? true)) {
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (contextBuilder) {
        return CustomSelection(
          onSelect: (DropdownModel? value) {
            _controller.text = value?.getItemDisplay() ?? '';
            selectedData = value;
            widget.onChange(value);
            Future.delayed(const Duration(milliseconds: 200)).whenComplete(
              () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            );
          },
          data: widget.data,
          selectedValue: selectedData,
          titleBottomSheet: widget.titleBottomSheet,
          description: widget.descriptionDropdown,
          onChangeValue: (DropdownModel? value) {
            selectedData = value;
          },
        );
      },
    );
  }
}
