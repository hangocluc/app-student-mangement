import 'package:base_bloc_cubit/features/presentation/cubits/demo_cubit/demo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/l10n/generate/app_localizations.dart';
import '../common/widget/app_overlay/overlay_widget.dart';
import '../core/navigator/app_route_tracking.dart';
import '../main.dart';
import 'app/routes/src/generate_route.dart';
import 'app/routes/src/routes_name.dart';
import 'presentation/cubits/demo_cubit/demo_state.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<BlocProvider> _appBlocProviders() {
    return [
      BlocProvider<DemoCubit>(create: (context) => sl.get<DemoCubit>()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MultiBlocProvider(
          providers: _appBlocProviders(),
          child: BlocBuilder<DemoCubit, DemoState>(
            builder: (context, state) {
              return GetMaterialApp(
                builder: (context, child) {
                  child = OverlayWidget.init()(context, child);
                  child = EasyLoading.init()(context, child);
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.noScaling),
                    child: child,
                  );
                },
                debugShowCheckedModeBanner: false,
                themeMode: (state is ThemeStateSuccess)
                    ? state.themeMode
                    : ThemeMode.dark,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                initialRoute: RouteName.root,
                navigatorObservers: [AppRouterTracking()],
                navigatorKey: getNavigatorKeyByEnv(),
                onGenerateRoute: GenerateRoute.generateRoute,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: const Locale('en'),
              );
            },
          ),
        ),
      ),
    );
  }
}
