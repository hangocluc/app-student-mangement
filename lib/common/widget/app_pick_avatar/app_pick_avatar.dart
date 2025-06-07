import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../utils/common_utils.dart';
import '../app_icon/app_asset_image.dart';

class AppPickAvatar extends StatefulWidget {
  final ValueNotifier<String> avatar;
  final String pathDefault;
  final double? sizeImageH;
  final double? sizeImageW;
  final String? pathIcon;
  final Function(XFile? file) callBack;

  const AppPickAvatar(
      {super.key,
      required this.avatar,
      required this.pathDefault,
      required this.callBack,
      this.sizeImageH,
      this.sizeImageW,
      this.pathIcon});

  @override
  State<AppPickAvatar> createState() => _AppPickAvatarState();
}

class _AppPickAvatarState extends State<AppPickAvatar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        permissionPhotoHandle((file) {
          widget.avatar.value = file?.path ?? '';
          widget.callBack(file);
        }, context);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ValueListenableBuilder<String>(
            builder: (context, value, child) {
              return Container(
                height: widget.sizeImageH ?? 128.h,
                width: widget.sizeImageW ?? 128.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.theBlack.theBlack900),
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: _getImageProvider(widget.avatar.value),
                      fit: BoxFit.cover,
                    )),
              );
            },
            valueListenable: widget.avatar,
          ),
          Positioned(
              bottom: 0,
              right: widget.sizeImageW == 64.w ? 0 : 8,
              child: AppAssetImage(
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
                path: widget.pathIcon ?? appIcon.icEditCircle.path,
              ))
        ],
      ),
    );
  }

  ImageProvider _getImageProvider(String path) {
    try {
      if (path.startsWith('http://') || path.startsWith('https://')) {
        return CachedNetworkImageProvider(path);
      } else if (File(path).existsSync()) {
        return FileImage(File(path));
      } else {
        return CachedNetworkImageProvider(widget.pathDefault);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
