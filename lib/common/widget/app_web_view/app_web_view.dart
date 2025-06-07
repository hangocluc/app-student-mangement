import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../utils/common_utils.dart';
import '../app_appbar/app_appbar.dart';

class WebViewArgs {
  final String url;

  const WebViewArgs({
    this.url = '',
  });
}

class WebViewScreen extends StatefulWidget {
  final WebViewArgs args;

  const WebViewScreen({super.key, required this.args});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            log('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
            await _controller.runJavaScript(
                'window.parent.addEventListener("message", (event) => {MbWebView.postMessage(JSON.stringify(event.data));}, false);');
          },
          onWebResourceError: (WebResourceError error) {
            log('onWebResourceError : ${error.errorCode}');
          },
        ),
      );

    _controller.loadRequest(Uri.parse(widget.args.url));

    // #docregion platform_features
    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _controller),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Stack(),
        ],
      ),
    );
  }

  _buildAppBar() {
    return CustomAppBar(
      title: '',
    );
  }

  void _clearTokenFromLocalStorage({bool isPop = true}) async {
    await _controller.clearCache();
    await _controller.clearLocalStorage();
    await deleteCacheAppWebViewDir();
    await deleteCacheWebViewDir();
  }

  @override
  void deactivate() async {
    _clearTokenFromLocalStorage(isPop: false);
    super.deactivate();
  }
}
