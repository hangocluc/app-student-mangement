import 'package:flutter/cupertino.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/widget/app_overlay/overlay_widget.dart';
import '../../../../common/widget/app_snack_bar/app_snack_bar.dart';
import '../../../../main.dart';

disMissSnackBar() {
  Future.delayed(const Duration(milliseconds: 2000), () {
    OverlayWidget.dismiss(animation: false);
  });
}

_checkSnackBar() {
  if (OverlayWidget.isShow) {
    OverlayWidget.dismiss(animation: false);
  }
}

showSnackBarSuccess(BuildContext context, {String? title}) {
  _checkSnackBar();
  OverlayWidget.show(
    widgetIn: AppSnackBar(
      pathIconLeft: appIcon.icAddSquare.path,
      title: title ?? '',
      bgColor: AppColors.other.Color46B969,
      pathIconRight: appIcon.icClose.path,
    ),
  );
  disMissSnackBar();
}

showSnackBarFail(
  BuildContext context, {
  String? title,
  double? topPadding,
}) {
  _checkSnackBar();

  OverlayWidget.show(
    widgetIn: AppSnackBar(
      pathIconLeft: appIcon.icAddSquare.path,
      title: title ?? '',
      bgColor: AppColors.red.red500,
      pathIconRight: appIcon.icClose.path,
      topPadding: topPadding,
    ),
  );
  disMissSnackBar();
}

showNotice(
  BuildContext context, {
  String? title,
  double? topPadding,
  String? content,
  bool isNavigate = true,
}) {
  _checkSnackBar();
  OverlayWidget.show(
    widgetIn: Container(),
  );
  disMissSnackBar();
}
