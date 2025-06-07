import 'dart:developer';

import 'package:base_bloc_cubit/features/presentation/cubits/demo_cubit/demo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/app_shared_preferences/app_shared_preferences.dart';
import '../../../../common/app_shared_preferences/app_shared_preferences_key.dart';
import '../../../domain/usecases/src/demo_usecase.dart';

class DemoCubit extends Cubit<DemoState> {
  final DemoUsecase usecase;
  final AppSharedPreferences sharedPreferences;
  DemoCubit({required this.usecase, required this.sharedPreferences})
      : super(DemoStateInitial()) {
    loadTheme();
  }
  Locale currentLocale = const Locale('en');
  ThemeMode currentTheme = ThemeMode.dark;
  void changeLanguage(String languageCode) {
    final newLocale = Locale(languageCode);
    currentLocale = newLocale;
    emit(LanguageStateSuccess(locale: newLocale));
  }

  Locale get locale => currentLocale;
  ThemeMode get theme => currentTheme;
  bool get statusTheme => currentTheme == ThemeMode.dark ? true : false;
  void loadTheme() {
    final getCurrentTheme =
        sharedPreferences.get(AppSharedPreferencesKey.theme);
    if (getCurrentTheme == ThemeMode.dark.name) {
      emit(ThemeStateSuccess(themeMode: ThemeMode.dark));
    } else {
      emit(ThemeStateSuccess(themeMode: ThemeMode.light));
    }
  }

  void setTheme() {
    final currentTheme = sharedPreferences.get(AppSharedPreferencesKey.theme);
    log('aaaaaaaaa${currentTheme}');
    if (currentTheme == ThemeMode.dark.name) {
      sharedPreferences.setString(
          AppSharedPreferencesKey.theme, ThemeMode.light.name);
      emit(ThemeStateSuccess(themeMode: ThemeMode.light));
    } else {
      sharedPreferences.setString(
          AppSharedPreferencesKey.theme, ThemeMode.dark.name);
      emit(ThemeStateSuccess(themeMode: ThemeMode.dark));
    }
  }

  // Future<void> detailNotice(String id) async {
  //   try {
  //     emit(DetailNotificationStateLoading());
  //     final response = await usecase.call(id);
  //     response.fold((l) {
  //       emit(DetailNotificationStateFailure(message: l.errorMessage));
  //     }, (r) {
  //       emit(DetailNotificationStateSuccess(
  //           data: DetailNoticeMapper().mapFromEntityToModel(r)));
  //     });
  //   } catch (error) {
  //     emit(DetailNotificationStateFailure(message: error.toString()));
  //   }
  // }

  // Future<void> readNotice({
  //   required String id,
  // }) async {
  //   try {
  //     final response = await notiUsecase.readNotice(id);
  //     response.fold((l) {
  //       if (l is DioException) {
  //         final String? message = ApiResponse.getMessageFromException(l);
  //         emit(DetailNotificationStateFailure(message: message ?? ''));
  //       } else {
  //         emit(
  //             DetailNotificationStateFailure(message: messageFromException(l)));
  //       }
  //     }, (r) {
  //       emit(ReadNoticeStateSuccess(data: r));
  //     });
  //   } on Exception catch (error) {
  //     emit(
  //         DetailNotificationStateFailure(message: messageFromException(error)));
  //   }
  // }

  // Future<void> getPointNotice({
  //   required String id,
  // }) async {
  //   try {
  //     final response = await notiUsecase.getPointNotice(id);
  //     response.fold((l) {
  //       if (l is DioException) {
  //         final String? message = ApiResponse.getMessageFromException(l);
  //         emit(DetailNotificationStateFailure(message: message ?? ''));
  //       } else {
  //         emit(
  //             DetailNotificationStateFailure(message: messageFromException(l)));
  //       }
  //     }, (r) {
  //       emit(GetPointNoticeStateSuccess(data: r));
  //     });
  //   } on Exception catch (error) {
  //     emit(
  //         DetailNotificationStateFailure(message: messageFromException(error)));
  //   }
  // }
}
