
import 'package:base_bloc_cubit/common/widget/app_switch/app_switch_sync.dart';
import 'package:base_bloc_cubit/core/extension/src/context_extension.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/demo_cubit/demo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/theme/app_color.dart';
import 'theme.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  // final appCubit = sl.get<DemoCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('alo'),
      ),
      body: Container(
        color: AppColors.pink.pink50,
        child: Column(
          children: [
            AppSwitchComponentSync(
                iconPath: '',
                title: context.l10n.appTitle,
                onChange: (value) {
                  if (value) {
                    context.read<DemoCubit>().changeLanguage('ja');
                  } else {
                    context.read<DemoCubit>().changeLanguage('en');
                  }
                }),

            //change theme
            const ThemeScreenState()
          ],
        ),
      ),
    );
  }
}
