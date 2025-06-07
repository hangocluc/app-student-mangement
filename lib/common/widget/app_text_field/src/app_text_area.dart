import 'package:flutter/material.dart';
import '../../../generate/assets.gen.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../app_icon/app_asset_image.dart';

const maxLine = 3;
const maxLength = 500;

class AppTextArea extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final FocusNode? node;
  final String? hinText;
  final ValueNotifier<String?>? errorText;
  final int? maxLength;
  final int? maxLine;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final Function(String? value)? onChange;
  final bool? isRequired;
  final TextStyle? titleStyle;

  const AppTextArea(
      {super.key,
      required this.title,
      this.controller,
      this.node,
      this.errorText,
      this.maxLength,
      this.maxLine,
      this.hinText,
      this.borderColor,
      this.hintStyle,
      this.onChange,
      this.titleStyle,
      this.isRequired});

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
  late FocusNode _node;
  ValueNotifier<bool> focusValue = ValueNotifier(false);
  ValueNotifier<String?> error = ValueNotifier(null);

  @override
  void initState() {
    initDataAndController();
    super.initState();
  }

  void initDataAndController() {
    if (widget.node == null) {
      _node = FocusNode();
    } else {
      _node = widget.node!;
    }
    _node.addListener(
      () {
        if (_node.hasFocus) {
          focusValue.value = true;
        } else {
          focusValue.value = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.spacing2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: widget.title,
                  style: widget.titleStyle ??
                      AppTypography().bodySmallRegular.copyWith(
                            color: AppColors.theBlack.theBlack900,
                          ),
                  children: [
                    ...widget.isRequired == true
                        ? [
                            TextSpan(
                              text: '*',
                              style: AppTypography().bodySmallRegular.copyWith(
                                    color: AppColors.red.red500,
                                  ),
                            )
                          ]
                        : [],
                  ],
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: focusValue,
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white.white,
                  boxShadow: focusValue.value
                      ? const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 0,
                              spreadRadius: 3,
                              color: Color(0xFFFDD9DF))
                        ]
                      : [],
                  borderRadius: BorderRadius.circular(AppSpacing.spacing4),
                  border: Border.all(
                      color:
                          widget.borderColor ?? AppColors.theBlack.theBlack500),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ValueListenableBuilder<String?>(
                          valueListenable:
                              widget.errorText ?? ValueNotifier(''),
                          builder: (context, errorMessage, child) {
                            return TextField(
                              controller: widget.controller,
                              focusNode: _node,
                              maxLines: widget.maxLine ?? maxLine,
                              maxLength: widget.maxLength ?? maxLength,
                              onChanged: (value) {
                                if (widget.onChange != null) {
                                  widget.onChange!(value);
                                }
                              },
                              style: AppTypography().bodyMediumRegular.copyWith(
                                    color: AppColors.theBlack.theBlack500,
                                  ),
                              decoration: InputDecoration(
                                counterStyle: AppTypography()
                                    .bodySmallRegular
                                    .copyWith(
                                        color: AppColors.theBlack.theBlack500,
                                        fontSize: 12),
                                hintText: widget.hinText,
                                hintStyle: widget.hintStyle,
                                contentPadding:
                                    const EdgeInsets.all(AppSpacing.spacing3),
                                fillColor: AppColors.white.white,
                                border: InputBorder.none,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              );
            }),
        ValueListenableBuilder<String?>(
          valueListenable: widget.errorText ?? ValueNotifier(''),
          builder: (context, value, child) {
            return Visibility(
              visible: value != null && value.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    AppAssetImage.icon16(path: Assets.icons.icWarnningBg.path),
                    const SizedBox(
                      width: AppSpacing.spacing2,
                    ),
                    Expanded(
                      child: Text("$value",
                          style: AppTypography().bodySmallRegular.copyWith(
                                color: AppColors.red.red500,
                              )),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
