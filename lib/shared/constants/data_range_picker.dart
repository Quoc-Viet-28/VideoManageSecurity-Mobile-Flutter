import 'package:flutter/material.dart';

class DataRangePicker {
  final Map<String, DateTimeRange> presets = {
    'Ngày hôm nay': DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    ),
    'Ngày hôm qua': DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 1)),
      end: DateTime.now().subtract(Duration(days: 1)),
    ),
    '7 ngày trước': DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 7)),
      end: DateTime.now(),
    ),
    '14 ngày trước': DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 14)),
      end: DateTime.now(),
    ),
    '30 ngày trước': DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 30)),
      end: DateTime.now(),
    ),
    'Tuần này': DateTimeRange(
      start:
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
      end: DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)),
    ),
    'Tuần trước': DateTimeRange(
      start:
          DateTime.now().subtract(Duration(days: DateTime.now().weekday + 6)),
      end: DateTime.now().subtract(Duration(days: DateTime.now().weekday)),
    ),
    'Tháng này': DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
    ),
    'Tháng trước': DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month, 0),
    ),
  };
}
