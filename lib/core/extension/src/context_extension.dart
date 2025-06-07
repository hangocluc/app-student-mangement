import 'package:flutter/material.dart';

import '../../../common/l10n/generate/app_localizations.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  // Screen width
  double get width => MediaQuery.sizeOf(this).width;

  // Status bar height
  double get statusBar => MediaQuery.viewPaddingOf(this).top;

  // Bottom padding height
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  // Keyboard show bottom padding height
  double get keyboardBottomPadding => MediaQuery.of(this).viewInsets.bottom;

  Offset get offset {
    RenderBox box = findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }

  Size get size {
    RenderBox box = findRenderObject() as RenderBox;
    return box.size;
  }

  AppLocalizations get l10n => AppLocalizations.of(this);
}
