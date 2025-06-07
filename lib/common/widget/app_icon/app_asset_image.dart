import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppAssetImage extends StatelessWidget {
  final String path;
  final String? package;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const AppAssetImage(
      {super.key,
      required this.path,
      this.package,
      this.width,
      this.height,
      this.color,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return path.contains('.png')
        ? Image.asset(path,
            width: width, height: height, fit: fit ?? BoxFit.fitWidth)
        : SvgPicture.asset(
            path,
            width: width,
            height: height,
            fit: fit ?? BoxFit.none,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            theme: SvgTheme(currentColor: color ?? const Color(0xFF000000)),
          );
  }

  factory AppAssetImage.icon16({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 16,
        height: 16,
        color: color,
      );

  factory AppAssetImage.icon18({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 18,
        height: 18,
        color: color,
      );

  factory AppAssetImage.icon20({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 20,
        height: 20,
        color: color,
      );

  factory AppAssetImage.icon24({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 24,
        height: 24,
        color: color,
      );

  factory AppAssetImage.icon32({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 32,
        height: 32,
        color: color,
      );

  factory AppAssetImage.icon36({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 36,
        height: 36,
        color: color,
      );

  factory AppAssetImage.icon40({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 40,
        height: 40,
        color: color,
      );

  factory AppAssetImage.icon44({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 44,
        height: 44,
        color: color,
      );

  factory AppAssetImage.icon48({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 48,
        height: 48,
        color: color,
      );

  factory AppAssetImage.icon56({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 56,
        height: 56,
        color: color,
      );

  factory AppAssetImage.icon64({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 64,
        height: 64,
        color: color,
      );

  factory AppAssetImage.icon80({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 80,
        height: 80,
        color: color,
      );

  factory AppAssetImage.icon120({required String path, Color? color}) =>
      AppAssetImage(
        path: path,
        width: 120,
        height: 120,
        color: color,
      );
}
