import 'dart:async';

import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'common/constants/src/app_constants.dart';
import 'common/generate/assets.gen.dart';
import 'common/utils/common_utils.dart';
import 'common/widget/app_loading_overlay/app_loading_overlay.dart';
import 'core/navigator/navigator_service.dart';
import 'features/app.dart';
import 'features/app/app_env/env.dart';
import 'features/app/app_env/network_env.dart';
import 'features/app/dependencies/dependencies.dart';

final GetIt sl = GetIt.instance;

const appIcon = Assets.icons;
Alice? alice;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initFirebase();
  await enableFirebaseAnalytics();
  registerNavigator(sl);
  await setupEnv();
  setupAlice();
  await registerDependencies(sl);
  configLoading();
  runApp(const MyApp());
}

String envConfig(String flavor) {
  switch (flavor) {
    case AppConstants.STAGING:
      return AppConstants.ENV_STAGING_PATH;
    case AppConstants.PROD:
      return AppConstants.ENV_PROD_PATH;
    default:
      return AppConstants.ENV_DEV_PATH;
  }
}

Future<void> setupEnv() async {
  const flavor = String.fromEnvironment(
    AppConstants.FLAVOR,
    defaultValue: AppConstants.STAGING,
  );
  await dotenv.load(fileName: envConfig(flavor));
  final env = EnvNetwork.envNetworkFromConfigure();
  sl.registerLazySingleton(
    () => Env(
      envNetwork: env,
      isProduction: flavor == AppConstants.PROD,
    ),
  );
  await Future.delayed(const Duration(seconds: 2));
  Logger().d("Env initial $flavor : ${env.apiServer}");
}

setupAlice() {
  final isProd = sl<Env>().isProduction;
  alice = Alice(
    showShareButton: true,
    showInspectorOnShake: !isProd,
    showNotification: false,
    navigatorKey: sl<NavigationService>().navigatorKey,
  );
}

GlobalKey<NavigatorState>? getNavigatorKeyByEnv() {
  final isProd = sl<Env>().isProduction;
  if (isProd) {
    return sl<NavigationService>().navigatorKey;
  } else {
    return alice?.getNavigatorKey();
  }
}
