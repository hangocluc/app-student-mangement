import 'package:base_bloc_cubit/core/extension/extention.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/demo_cubit/demo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widget/app_switch/app_switch_sync.dart';

class ThemeScreenState extends StatefulWidget {
  const ThemeScreenState({super.key});

  @override
  State<ThemeScreenState> createState() => _ThemeScreenStateState();
}

class _ThemeScreenStateState extends State<ThemeScreenState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppSwitchComponentSync(
              initValue: context.read<DemoCubit>().statusTheme,
              iconPath: '',
              title: context.l10n.lblTheme,
              onChange: (value) {
                context.read<DemoCubit>().setTheme();
              })
        ],
      ),
    );
  }
}
