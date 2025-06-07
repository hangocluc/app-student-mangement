import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../app_icon/app_asset_image.dart';
import 'src/calendar_constants.dart';

class AppCalendar extends StatefulWidget {
  final Function(DateTime) onSelectDate;
  final Function(DateTime, DateTime, DateTime)? onNextMonth;
  final DateTime? initialDate;
  final Decoration? modeTitleCalendarStyle;
  final EdgeInsets? modeTitleCalendarMargin;
  final double? itemRatio;
  final Color? selectedColor;
  final Color? textSelectedColor;
  final Color? textHintColor;
  final List<DateTime>? eventDate;
  final List<DateTime>? infoDate;
  final bool? highlightCurrentDate;
  final double? height;
  final double? itemCrossAxisSpacing;
  final double? itemMainAxisSpacing;

  const AppCalendar(
      {super.key,
      required this.onSelectDate,
      this.initialDate,
      this.modeTitleCalendarStyle,
      this.modeTitleCalendarMargin,
      this.itemRatio,
      this.selectedColor,
      this.textSelectedColor,
      this.textHintColor,
      this.eventDate,
      this.onNextMonth,
      this.infoDate,
      this.highlightCurrentDate,
      this.height,
      this.itemCrossAxisSpacing,
      this.itemMainAxisSpacing});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  late DateTime _focusDate;
  late DateTime _selectedDate;
  CalendarMode _calendarMode = CalendarMode.DAY;
  final List<DateTime> _currentDayOfMonthList = [];
  int numberOfDisplayDay = CalendarConstants.minDayInMonth;
  @override
  void initState() {
    _setInitFocusDate();
    _setCurrentDayOfMonthDate();
    super.initState();
  }

  void _setInitFocusDate() {
    if (widget.initialDate != null) {
      _focusDate = widget.initialDate!;
    } else {
      _focusDate = DateTime.now().toUtc();
    }
    _selectedDate = _focusDate;
  }

  void _setCurrentDayOfMonthDate() {
    _currentDayOfMonthList.clear();
    final startDayOfWeek =
        DateTime.utc(_focusDate.year, _focusDate.month, 1).weekday;
    final numberDayOfMonth =
        DateTime.utc(_focusDate.year, _focusDate.month + 1, 0).day;

    if (numberDayOfMonth == CalendarConstants.minDayInMonth &&
        startDayOfWeek == CalendarConstants.startDayInWeek) {
      numberOfDisplayDay = 4;
    } else {
      numberOfDisplayDay = ((startDayOfWeek + numberDayOfMonth) / 7).ceil();
    }
    final startDate = DateTime.utc(_focusDate.year, _focusDate.month, 1)
        .subtract(
            Duration(days: startDayOfWeek % CalendarConstants.startDayInWeek));
    for (int count = 0;
        count < (numberOfDisplayDay * CalendarConstants.dayOfWeek);
        count++) {
      _currentDayOfMonthList.add(startDate.add(Duration(days: count)));
    }
  }

  void _setFocusDate(DateTime value) {
    setState(() {
      _focusDate = value;
    });
  }

  void _setSelectedDate(DateTime value) {
    if (value.isAfter(_focusDate) && value.month != _focusDate.month) {
      _onViewNextMonth();
    }
    if (value.isBefore(_focusDate) && value.month != _focusDate.month) {
      _onViewPreMonth();
    }
    setState(() {
      _selectedDate = value;
    });
    widget.onSelectDate(_selectedDate);
    if (widget.onNextMonth != null) {
      widget.onNextMonth!(
          _selectedDate,
          DateTime.utc(_selectedDate.year, _selectedDate.month, 1),
          DateTime.utc(_selectedDate.year, _selectedDate.month + 1, 0));
    }
  }

  void _changeCalendarMode(CalendarMode mode) {
    setState(() {
      _calendarMode = mode;
    });
  }

  void _onViewPreMonth() {
    _setFocusDate(DateTime.utc(_focusDate.year, _focusDate.month - 1, 1));
    _setCurrentDayOfMonthDate();
    setState(() {});
  }

  void _onViewNextMonth() {
    _setFocusDate(DateTime.utc(_focusDate.year, _focusDate.month + 1, 1));
    _setCurrentDayOfMonthDate();
    setState(() {});
  }

  void _onViewPreYear() {
    _setFocusDate(DateTime.utc(_focusDate.year - 1, 1, 1));
    _setCurrentDayOfMonthDate();
    setState(() {});
  }

  void _onViewNextYear() {
    _setFocusDate(DateTime.utc(_focusDate.year + 1, 1, 1));
    _setCurrentDayOfMonthDate();
    setState(() {});
  }

  void _onSelectMonth(int year, int month) {
    _setFocusDate(DateTime.utc(year, month));
    _setCurrentDayOfMonthDate();
    _changeCalendarMode(CalendarMode.DAY);
    setState(() {});
  }

  void _onStartEndMonth() {
    if (widget.onNextMonth != null && _calendarMode == CalendarMode.DAY) {
      widget.onNextMonth!(
          _focusDate,
          DateTime.utc(_focusDate.year, _focusDate.month, 1),
          DateTime.utc(_focusDate.year, _focusDate.month + 1, 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ??
          310.h +
              (numberOfDisplayDay > 5 ? 20.h : 0) +
              ((widget.modeTitleCalendarMargin?.top ?? 0) +
                  (widget.modeTitleCalendarMargin?.bottom ?? 0)),
      width: ScreenUtil().screenWidth,
      color: AppColors.white.white,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Container(
              decoration: widget.modeTitleCalendarStyle,
              margin: widget.modeTitleCalendarMargin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _calendarMode == CalendarMode.DAY
                          ? _onViewPreMonth()
                          : _onViewPreYear();
                      _onStartEndMonth();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.spacing3,
                          horizontal: AppSpacing.spacing2),
                      child: AppAssetImage(
                        path: appIcon.icChevronLeft.path,
                        height: 24.w,
                        width: 24.w,
                        color: AppColors.theBlack.theBlack500,
                      ),
                    ),
                  ),
                  _buildTileTime(),
                  GestureDetector(
                    onTap: () {
                      _calendarMode == CalendarMode.DAY
                          ? _onViewNextMonth()
                          : _onViewNextYear();
                      _onStartEndMonth();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.spacing3,
                          horizontal: AppSpacing.spacing2),
                      child: AppAssetImage(
                        path: appIcon.icChevronRight.path,
                        height: 24.w,
                        width: 24.w,
                        color: AppColors.theBlack.theBlack500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.spacing3),
            child: _calendarMode == CalendarMode.DAY
                ? _buildDayInMonth()
                : _buildMonthInYear(),
          ))
        ],
      ),
    );
  }

  _buildTileTime() {
    if (_calendarMode == CalendarMode.DAY) {
      return GestureDetector(
        onTap: () {
          _changeCalendarMode(CalendarMode.MONTH);
        },
        child: Row(
          children: [
            Text(
              "${_focusDate.year}/${_focusDate.month}",
              style: AppTypography().bodyMediumSemiBold.copyWith(
                    color: AppColors.other.Color0E0E0F,
                  ),
            ),
            AppAssetImage(
              path: appIcon.icChevronDown.path,
              height: 16,
              width: 16,
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _changeCalendarMode(CalendarMode.DAY);
        },
        child: Text(
          _focusDate.year.toString(),
          style: AppTypography().bodyMediumSemiBold.copyWith(
                color: AppColors.other.Color0E0E0F,
              ),
        ),
      );
    }
  }

  _buildDayInMonth() {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              CalendarConstants.dayJapan.length,
              (index) {
                return Container(
                  width: (ScreenUtil().screenWidth - AppSpacing.spacing3 * 2) /
                      CalendarConstants.dayOfWeek,
                  alignment: Alignment.center,
                  child: Text(
                    CalendarConstants.dayJapan.elementAt(index),
                  ),
                );
              },
            )),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: widget.itemRatio ?? 50 / 42,
                crossAxisSpacing: widget.itemCrossAxisSpacing ?? 0,
                mainAxisSpacing: widget.itemMainAxisSpacing ?? 0),
            itemCount: _currentDayOfMonthList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _setSelectedDate(_currentDayOfMonthList.elementAt(index));
                },
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      width:
                          (ScreenUtil().screenWidth - AppSpacing.spacing3 * 2) /
                              CalendarConstants.dayOfWeek,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _getDaySelectColor(
                            _currentDayOfMonthList.elementAt(index)),
                        borderRadius: const BorderRadius.all(AppRadius.radius2),
                      ),
                      child: Text(
                        _currentDayOfMonthList.elementAt(index).day.toString(),
                        style: _getDayTextStyle(
                            _currentDayOfMonthList.elementAt(index)),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Row(
                        children: [
                          Visibility(
                            visible: _visibleHealthInfo(
                                _currentDayOfMonthList.elementAt(index)),
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              height: 6.w,
                              width: 6.w,
                              decoration: BoxDecoration(
                                  color: AppColors.primary.primary400,
                                  borderRadius: const BorderRadius.all(
                                      AppRadius.radiusMax)),
                            ),
                          ),
                          Visibility(
                            visible: _visibleEvent(
                                _currentDayOfMonthList.elementAt(index)),
                            child: Container(
                              height: 6.w,
                              width: 6.w,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: AppColors.red.red400,
                                  borderRadius: const BorderRadius.all(
                                      AppRadius.radiusMax)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildMonthInYear() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 117 / 63),
      itemCount: CalendarConstants.monthJapan.length,
      itemBuilder: (context, index) {
        final dateForMonth = DateTime.utc(
          _focusDate.year,
          CalendarConstants.monthJapan.values.elementAt(index),
        );
        return GestureDetector(
          onTap: () {
            _onSelectMonth(_focusDate.year,
                CalendarConstants.monthJapan.values.elementAt(index));
          },
          child: Container(
            decoration: BoxDecoration(
              color: _getMonthSelectedColor(dateForMonth),
              borderRadius: const BorderRadius.all(AppRadius.radius2),
            ),
            alignment: Alignment.center,
            child: Text(
              CalendarConstants.monthJapan.keys.elementAt(index),
              style: _getMonthTextStyle(dateForMonth),
            ),
          ),
        );
      },
    );
  }

  bool isSameDate(DateTime selectedDate, {DateTime? milestoneDate}) {
    DateTime milestone = milestoneDate ?? DateTime.now();
    return selectedDate.year == milestone.year &&
        selectedDate.month == milestone.month &&
        selectedDate.day == milestone.day;
  }

  _getDayTextStyle(DateTime dateTime) {
    if (isSameDate(dateTime, milestoneDate: _selectedDate)) {
      return AppTypography().bodyMediumSemiBold.copyWith(
            color: widget.textSelectedColor ?? AppColors.white.white,
          );
    } else if (dateTime.month == _focusDate.month) {
      return AppTypography().bodyMediumRegular.copyWith(
            color: AppColors.theBlack.theBlack900,
          );
    } else {
      return AppTypography().bodyMediumRegular.copyWith(
            color: widget.textHintColor ?? AppColors.other.ColorD6D8E1,
          );
    }
  }

  _getDaySelectColor(DateTime dateTime) {
    if (isSameDate(dateTime, milestoneDate: _selectedDate)) {
      return widget.selectedColor ?? AppColors.primary.primary400;
    }
    return Colors.transparent;
  }

  _getMonthTextStyle(DateTime value) {
    if (value.month == _selectedDate.month &&
        value.year == _selectedDate.year) {
      return AppTypography().bodyMediumSemiBold.copyWith(
            color: widget.textSelectedColor ?? AppColors.white.white,
          );
    } else {
      return AppTypography().bodyMediumRegular.copyWith(
            color: AppColors.theBlack.theBlack900,
          );
    }
  }

  _getMonthSelectedColor(DateTime value) {
    if (value.month == _selectedDate.month &&
        value.year == _selectedDate.year) {
      return widget.selectedColor ?? AppColors.primary.primary400;
    } else {
      return Colors.transparent;
    }
  }

  _visibleEvent(DateTime value) {
    return (widget.eventDate?.isNotEmpty ?? false) &&
        widget.eventDate!
            .where((element) => isSameDate(element, milestoneDate: value))
            .isNotEmpty;
  }

  _visibleHealthInfo(DateTime value) {
    return (widget.infoDate?.isNotEmpty ?? false) &&
        widget.infoDate!
            .where((element) => isSameDate(element, milestoneDate: value))
            .isNotEmpty;
  }
}
