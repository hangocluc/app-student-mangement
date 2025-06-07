import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../theme/app_typography.dart';
import '../../utils/common_utils.dart';
import '../app_icon/app_asset_image.dart';

class AppExpansionTitle extends StatefulWidget {
  final String title;
  final String? content;

  const AppExpansionTitle({
    super.key,
    required this.title,
    this.content,
  });

  @override
  State<AppExpansionTitle> createState() => _AppExpansionTitleState();
}

class _AppExpansionTitleState extends State<AppExpansionTitle> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.white,
        border: Border.all(
            width: 1,
            color: _isExpanded
                ? AppColors.primary.primary500
                : AppColors.other.ColorF8F9FA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: _isExpanded
            ? [
                BoxShadow(
                  color: AppColors.other.ColorB5E3C3,
                  offset: const Offset(0, 0),
                  blurRadius: 0,
                  spreadRadius: 3,
                ),
              ]
            : [],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.title,
            style: AppTypography().bodyMediumMedium.copyWith(
                  color: AppColors.theBlack.theBlack500,
                ),
          ),
          trailing: Transform.rotate(
            angle: _isExpanded ? 3.14159 : -1.5708,
            child: AppAssetImage(
              path: appIcon.icChevronDown.path,
              height: 24,
              width: 24,
              color: AppColors.primary.primary500,
            ),
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: widget.content != null
              ? [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: AppColors.theBlack.theBlack50, width: 2),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Html(
                            data: widget.content ?? '',
                            shrinkWrap: true,
                            style: {
                              "p": Style(
                                fontFamily: NotoSansJP,
                                fontSize: FontSize(14.0),
                                // color: bodyTextColor,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.justify,
                                lineHeight: const LineHeight(16 / 12),
                              ),
                              "a": Style(
                                fontFamily: NotoSansJP,
                                fontSize: FontSize(14.0),
                                textDecoration: TextDecoration.none,
                              ),
                            },
                            onLinkTap: (url, attributes, element) {
                              openLink(context, url);
                            },
                          ),

                          // Text(
                          //   widget.content!,
                          //   style: AppTypography().bodyXSmallMedium.copyWith(
                          //         color: AppColors.theBlack.theBlack700,
                          //       ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}
