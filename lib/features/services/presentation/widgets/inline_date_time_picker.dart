import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class InlineDateTimePicker extends StatefulWidget {
  const InlineDateTimePicker({
    super.key,
    required this.selectedDateTime,
    required this.onChanged,
  });

  final DateTime? selectedDateTime;
  final ValueChanged<DateTime> onChanged;

  @override
  State<InlineDateTimePicker> createState() => _InlineDateTimePickerState();
}

class _InlineDateTimePickerState extends State<InlineDateTimePicker> {
  late DateTime _visibleMonth;
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;

  static const List<String> _weekDays = [
    "السبت", "الأحد", "الاثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعه",
  ];

  static const List<TimeOfDay> _timeSlots = [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 15, minute: 0),
    TimeOfDay(hour: 16, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final initial = widget.selectedDateTime ?? now;
    _visibleMonth = DateTime(initial.year, initial.month);
    if (widget.selectedDateTime != null) {
      _selectedDay = DateTime(initial.year, initial.month, initial.day);
      _selectedTime = TimeOfDay(hour: initial.hour, minute: initial.minute);
    }
  }

  void _emitIfComplete() {
    if (_selectedDay != null && _selectedTime != null) {
      widget.onChanged(
        DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
      );
    }
  }

  String _monthName(DateTime date) {
    const months = [
      "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
      "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر",
    ];
    return "${months[date.month - 1]} ${date.year}";
  }

  List<DateTime?> _buildDaysGrid() {
    final firstDayOfMonth = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final daysInMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;

    /// weekday في Dart: Mon=1..Sun=7. عايزين نحول عشان الأسبوع يبدأ بالسبت
    final leadingEmpty = (firstDayOfMonth.weekday % 7 + 1) % 7;

    return [
      ...List.generate(leadingEmpty, (_) => null),
      ...List.generate(daysInMonth, (i) => DateTime(_visibleMonth.year, _visibleMonth.month, i + 1)),
    ];
  }

  bool _isPast(DateTime day) {
    final today = DateTime.now();
    final onlyToday = DateTime(today.year, today.month, today.day);
    return day.isBefore(onlyToday);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? "ص" : "م";
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute$period";
  }

  @override
  Widget build(BuildContext context) {
    final days = _buildDaysGrid();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ===== اختر التاريخ =====
        Text(
          "اختر التاريخ",
          style: TextStyle(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.w600,
            color: ColorsManager.primaryTextDarkColor,
          ),
        ),
        SizedBox(height: RS.size(context, 12)),

        Container(
          padding: EdgeInsets.all(RS.size(context, 12)),
          decoration: BoxDecoration(
            color: ColorsManager.primaryColor.withOpacity(0.04),
            borderRadius: BorderRadius.circular(RS.radius(context, 14)),
          ),
          child: Column(
            children: [
              /// ===== Month Header =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    color: ColorsManager.primaryColor,
                    onPressed: () {
                      setState(() {
                        _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
                      });
                    },
                  ),
                  Text(
                    _monthName(_visibleMonth),
                    style: TextStyle(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    color: ColorsManager.primaryColor,
                    onPressed: () {
                      setState(() {
                        _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
                      });
                    },
                  ),
                ],
              ),

              /// ===== Week days row =====
              Row(
                children: _weekDays
                    .map((d) => Expanded(
                          child: Center(
                            child: Text(
                              d,
                              style: TextStyle(
                                fontSize: RS.font(context, 11),
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.secondaryTextDarkColor,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(height: RS.size(context, 6)),

              /// ===== Days grid =====
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  final day = days[index];
                  if (day == null) return const SizedBox.shrink();

                  final isPast = _isPast(day);
                  final isSelected = _selectedDay != null &&
                      _selectedDay!.year == day.year &&
                      _selectedDay!.month == day.month &&
                      _selectedDay!.day == day.day;

                  return GestureDetector(
                    onTap: isPast
                        ? null
                        : () {
                            setState(() => _selectedDay = day);
                            _emitIfComplete();
                          },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? ColorsManager.primaryColor : null,
                      ),
                      child: Text(
                        "${day.day}",
                        style: TextStyle(
                          fontSize: RS.font(context, 13),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isPast
                              ? Colors.grey.shade400
                              : isSelected
                                  ? Colors.white
                                  : ColorsManager.primaryTextDarkColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        SizedBox(height: RS.size(context, 20)),

        /// ===== اختر الوقت =====
        Text(
          "اختر الوقت",
          style: TextStyle(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.w600,
            color: ColorsManager.primaryTextDarkColor,
          ),
        ),
        SizedBox(height: RS.size(context, 12)),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _timeSlots.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: RS.size(context, 10),
            crossAxisSpacing: RS.size(context, 10),
            childAspectRatio: 1.8,
          ),
          itemBuilder: (context, index) {
            final time = _timeSlots[index];
            final isSelected = _selectedTime != null &&
                _selectedTime!.hour == time.hour &&
                _selectedTime!.minute == time.minute;

            return GestureDetector(
              onTap: () {
                setState(() => _selectedTime = time);
                _emitIfComplete();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorsManager.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                  border: Border.all(
                    color: isSelected
                        ? ColorsManager.primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  _formatTime(time),
                  style: TextStyle(
                    fontSize: RS.font(context, 13),
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : ColorsManager.primaryTextDarkColor,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}