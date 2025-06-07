import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler {
  static Future<bool> checkAndRequestPermission(
    BuildContext context,
    Permission permission,
  ) async {
    var status = await permission.status;
    Logger().i('===> Permission ${permission.toString()} status: $status');

    if (status.isGranted) {
      return true;
    }

    var result = await permission.request();

    if (result.isGranted) {
      return true;
    }

    if (result.isDenied || result.isRestricted) {
      if (await _retryCheckPermission(permission)) {
        return true;
      }
    }

    if (result.isPermanentlyDenied && context.mounted) {
      await _showSettingsDialog(context);
    }

    return false;
  }

  static Future<bool> _retryCheckPermission(Permission permission) async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      var status = await permission.status;
      if (status.isGranted) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> requestStoragePermission(BuildContext context) async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();

    if (Platform.isIOS) {
      List<Permission> permissions = [Permission.photos, Permission.videos];

      bool alreadyGranted = await _checkPermissionGranted(permissions);
      if (alreadyGranted) return true;

      Map<Permission, PermissionStatus> statuses = await permissions.request();
      bool allGranted = statuses.values.every((status) => status.isGranted);
      Logger().i('===> iOS Permission status: $statuses');

      if (!allGranted) {
        if (statuses.values.any((status) => status.isPermanentlyDenied)) {
          if (context.mounted) {
            await _showSettingsDialog(context);
          }
        }
        return false;
      }
      return true;
    }

    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    final int androidVersion = int.parse(androidInfo.version.release);

    List<Permission> permissions = androidVersion >= 13
        ? [Permission.photos, Permission.videos]
        : [Permission.storage];

    bool alreadyGranted = await _checkPermissionGranted(permissions);
    if (alreadyGranted) return true;

    Map<Permission, PermissionStatus> statuses = await permissions.request();
    bool allGranted = statuses.values.every((status) => status.isGranted);
    Logger().i('===> Android Permission status: $statuses');

    if (!allGranted) {
      if (statuses.values.any((status) => status.isPermanentlyDenied)) {
        if (context.mounted) {
          await _showSettingsDialog(context);
        }
      }
      return false;
    }
    return true;
  }

  static Future<bool> _checkPermissionGranted(
      List<Permission> permissions) async {
    for (var permission in permissions) {
      if (await permission.isGranted) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    final int androidVersion = int.parse(androidInfo.version.release);
    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.photos,
        //..... as needed
      ].request();

      havePermission =
          request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      await openAppSettings();
    }

    return havePermission;
  }

  static Future<void> _showSettingsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('pemisson'),
          content: Text(
            'request permisson',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancle'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
