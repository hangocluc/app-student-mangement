import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../widget/app_toast/app_toast.dart';
import 'permission_handler_utils.dart';
import 'snack_bar_utils.dart';

// class ShareUtils {
//   static void share(String permalink) {
//     Share.share(permalink);
//   }
//
//   static void shareFiles(File paths,
//       {List<String>? mimeTypes,
//       String? subject,
//       String? text,
//       Rect? sharePositionOrigin}) {
//     Share.shareXFiles(
//       [XFile(paths.path)],
//       text: text,
//     );
//   }
//
//   static Future<void> captureImageAndShare(
//     BuildContext context,
//     ScreenshotController screenshotController,
//     GlobalKey repaintKey,
//     Widget widget,
//     String text,
//   ) async {
//     if (Platform.isAndroid) {
//       final hasPermission = await AppPermissionHandler.storagePermission();
//       if (!hasPermission && context.mounted) {
//         showToastError(context, language.lblNoPermission);
//         return;
//       }
//     }
//
//     try {
//       final picData = await screenshotController.captureFromWidget(widget,
//           delay: const Duration(milliseconds: 100));
//
//       final tempDirectory = await getTemporaryDirectory();
//       final timestamp = DateTime.now().millisecondsSinceEpoch;
//       final savedPath = '${tempDirectory.path}/image_$timestamp.png';
//
//       File imageFile = File(savedPath);
//       await imageFile.writeAsBytes(picData);
//
//       // Share the image using Share.shareXFiles
//       await Share.shareXFiles(
//         [XFile(savedPath)],
//         text: text,
//       );
//     } catch (error) {
//       if (context.mounted) {
//         showToastError(context, ' $error');
//       }
//     }
//   }
// }

class ShareUtils {
  static void share(String permalink) {
    Share.share(permalink);
  }

  static void shareFiles(BuildContext context, File file, Uint8List picData,
      {String? text}) {
    _showCustomShareSheet(context, file, text, picData);
  }

  static Future<void> captureImageAndShare(
    BuildContext context,
    ScreenshotController screenshotController,
    Widget widget,
    String text,
  ) async {
    if (Platform.isAndroid) {
      final hasPermission = await AppPermissionHandler.storagePermission();
      if (!hasPermission && context.mounted) {
        showToastError(context, 'No Permisson');
        return;
      }
    }

    try {
      final picData = await screenshotController.captureFromWidget(
        widget,
        delay: const Duration(milliseconds: 100),
      );

      final tempDirectory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final savedPath = '${tempDirectory.path}/image_$timestamp.png';

      File imageFile = File(savedPath);

      await imageFile.writeAsBytes(picData);

      if (context.mounted) {
        _showCustomShareSheet(context, imageFile, text, picData);
      }
    } catch (error) {
      if (context.mounted) {
        showToastError(context, ' $error');
      }
    }
  }

  static void _showCustomShareSheet(
      BuildContext context, File file, String? text, Uint8List picData) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildShareOption(
              icon: Icons.copy,
              text: 'Copy',
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: file.path));
                if (context.mounted) {
                  showSnackBarSuccess(
                    context,
                    title: 'Copy Success',
                  );
                  Navigator.pop(context);
                }
              },
            ),
            _buildShareOption(
              icon: Icons.download,
              text: 'Save',
              onTap: () async {
                saveUint8ListAsImage(picData);

                showSnackBarSuccess(
                  context,
                  title: 'Save Success',
                );
                Navigator.pop(context);
              },
            ),
            _buildShareOption(
              icon: Icons.share,
              text: 'Share',
              onTap: () {
                Share.shareXFiles([XFile(file.path)], text: text);

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Widget _buildShareOption(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}

Future<File> saveUint8ListAsImage(Uint8List picData) async {
  final directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/saved_image.png';
  File file = File(filePath);
  await file.writeAsBytes(picData);

  return file;
}
