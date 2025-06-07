import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../app_loading_overlay/app_loading.dart';

Widget buildLoadMoreFooter() {
  return CustomFooter(
    builder: (context, mode) {
      return SizedBox(
        height: 30.0,
        width: double.infinity,
        child: (mode == LoadStatus.loading)
            ? const Center(child: AppLoading())
            : const SizedBox(),
      );
    },
  );
}
