import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import 'app_loading.dart';

Widget buildLoading(bool show, {Color? bgColor}) {
  if (show) {
    return GetIt.instance<AppLoadingOverlay>().buildLoading(bgColor: bgColor);
  }

  return const SizedBox();
}

abstract class AppLoadingOverlay {
  Widget buildLoading({Color? bgColor});
}

class AppLoadingOverlayImpl extends AppLoadingOverlay {
  @override
  Widget buildLoading({Color? bgColor}) {
    return _AppLoadingOverlay(backgroundColor: bgColor);
  }
}

class _AppLoadingOverlay extends StatelessWidget {
  const _AppLoadingOverlay({this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.black54,
        body: const AppLoading(height: 48),
      ),
    );
  }
}

void showLoadingOverlay(BuildContext context, {bool dismissAble = true}) async {
  if (!EasyLoading.isShow) {
    EasyLoading.show();
  }
}

void dismissLoadingOverlay(BuildContext context) {
  if (EasyLoading.isShow) {
    Future.delayed(const Duration(milliseconds: 500), () {
      EasyLoading.dismiss();
    });
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorColor = Colors.white
    ..backgroundColor = Colors.transparent
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorWidget = const AppLoading(height: 48)
    ..maskType = EasyLoadingMaskType.black
    ..boxShadow = <BoxShadow>[]
    ..textColor = Colors.white
    ..maskColor = Colors.transparent
    ..dismissOnTap = false;
}
