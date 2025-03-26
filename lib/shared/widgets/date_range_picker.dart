import 'package:box_alarm/shared/constants/shared_constants_export.dart';
import 'package:box_alarm/shared/widgets/share_untils_widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangePicker extends StatefulWidget {
  final Function(DateTime?, DateTime?) buttonSelected;
  final DateTime? startDate;
  final DateTime? endDate;

  // final Function(DateTime?, DateTime?) onDateRangeSelected;

  const DateRangePicker(
      {super.key,
      // required this.onDateRangeSelected,
      required this.buttonSelected,
      this.startDate,
      this.endDate});

  @override
  DateRangePickerState createState() => DateRangePickerState();
}

class DateRangePickerState extends State<DateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime _focusedDay = DateTime.now();
  String? _selectedPreset;

  final List<int> _hours = List.generate(24, (index) => index);
  final List<int> _minutes = List.generate(60, (index) => index);

  int _calculateDaysDifference(DateTime? start, DateTime? end) {
    if (start == null || end == null) return 0;
    return end.difference(start).inDays + 1;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  final Map<String, DateTimeRange> _presets = DataRangePicker().presets;

  void _onPresetSelected(String preset) {
    setState(() {
      _selectedPreset = preset;
      final range = _presets[preset];
      _startDate = range?.start;
      _endDate = range?.end;
      _focusedDay = _startDate ?? DateTime.now();
      _calculateDaysDifference(_startDate, _startDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 92,
      child: Column(
        children: [
          _buildHeader(),
          _buildDateRangerPresets(),
          _buildTableCalendar(),
          const Divider(),
          _buildTimeFromEnd(),
          _buildNavButton(),
        ],
      ),
    );
  }

  _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xffF1F1F1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/home/calendar_header.svg',
            color: Color(0xff78C6E7),
          ),
          SizedBox(width: 12),
          Text(
            'Chọn mốc thời gian',
            style: styleS18W4(neutralGray),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.cancel,
              color: softGray,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateRangerPresets() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xffF1F1F1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _presets.length,
              itemBuilder: (context, index) {
                return _buildItemPreset(_presets.keys.elementAt(index));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      // key: ValueKey(_focusedDay),
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(1990),
      lastDay: DateTime.utc(2050),
      calendarFormat: CalendarFormat.month,
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      rangeStartDay: _startDate,
      rangeEndDay: _endDate,
      locale: 'vi_VN',
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: styleS16W6(const Color(0xff222222)),
      ),
      calendarStyle: CalendarStyle(
          defaultTextStyle: styleS14W5(const Color(0xff222222)),
          todayTextStyle: styleS14W5(const Color(0xff007DC0)),
          todayDecoration: const BoxDecoration(
              color: Color(0xffF2F2F2), shape: BoxShape.circle),
          rangeStartTextStyle: styleS14W5(Colors.white),
          rangeEndTextStyle: styleS14W5(Colors.white),
          rangeHighlightColor: const Color(0xffE3E5E5),
          rangeStartDecoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(4),
            color: oceanBlue,
          ),
          rangeEndDecoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(4),
            color: oceanBlue,
          )),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) {
          final weekdays = {
            1: 'T2',
            2: 'T3',
            3: 'T4',
            4: 'T5',
            5: 'T6',
            6: 'T7',
            7: 'CN',
          };
          return weekdays[date.weekday]!;
        },
        weekendStyle: styleS12W6(const Color(0xffAFAFAF)),
        weekdayStyle: styleS12W6(const Color(0xffAFAFAF)),
      ),
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _startDate = start;
          _endDate = end;
          _focusedDay = focusedDay;
          _selectedPreset = null;
        });
        // widget.onDateRangeSelected(start, end);
      },
    );
  }

  Widget _buildTimeFromEnd() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Từ',
                style: styleS14W5(const Color(0xff55595D)),
              ),
              const SizedBox(
                height: 4,
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          _buildGroupTitleDropDown(
            title: 'GIỜ',
            child: DropdownButton<int>(
              style: styleS14W4(const Color(0xffAFAFAF)),
              underline: const SizedBox(),
              value: _startTime?.hour,
              items: _hours
                  .map((hour) => DropdownMenuItem<int>(
                        value: hour,
                        child: Text(hour.toString().padLeft(2, '0')),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _startTime =
                      TimeOfDay(hour: value!, minute: _startTime?.minute ?? 0);
                });
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ':',
                style: styleS18W5(const Color(0xff222222)),
              ),
              const SizedBox(
                height: 4,
              )
            ],
          ),
          // Start Hour
          const SizedBox(
            width: 10,
          ),
          _buildGroupTitleDropDown(
            title: 'PHÚT',
            child: DropdownButton<int>(
              style: styleS14W4(const Color(0xffAFAFAF)),
              underline: const SizedBox(),
              value: _startTime?.minute,
              items: _minutes
                  .map((minute) => DropdownMenuItem<int>(
                        value: minute,
                        child: Text(minute.toString().padLeft(2, '0')),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _startTime =
                      TimeOfDay(hour: _startTime?.hour ?? 0, minute: value!);
                });
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đến',
                style: styleS14W5(const Color(0xff55595D)),
              ),
              const SizedBox(
                height: 4,
              )
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          _buildGroupTitleDropDown(
            title: 'GIỜ',
            child: DropdownButton<int>(
              style: styleS14W4(const Color(0xffAFAFAF)),
              underline: const SizedBox(),
              value: _endTime?.hour,
              items: _hours
                  .map((hour) => DropdownMenuItem<int>(
                        value: hour,
                        child: Text(hour.toString().padLeft(2, '0')),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _endTime =
                      TimeOfDay(hour: value!, minute: _endTime?.minute ?? 0);
                });
              },
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ':',
                style: styleS18W5(const Color(0xff222222)),
              ),
              const SizedBox(
                height: 4,
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),

          _buildGroupTitleDropDown(
            title: 'PHÚT',
            child: DropdownButton<int>(
              style: styleS14W4(const Color(0xffAFAFAF)),
              underline: const SizedBox(),
              value: _endTime?.minute,
              items: _minutes
                  .map((minute) => DropdownMenuItem<int>(
                        value: minute,
                        child: Text(minute.toString().padLeft(2, '0')),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _endTime =
                      TimeOfDay(hour: _endTime?.hour ?? 0, minute: value!);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavButton() {
    return (_startDate != null && _endDate != null)
        ? Column(
            children: [
              const Divider(),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'Đã chọn:',
                        style: styleS14W4(softGray),
                      ),
                      RichText(
                          text: TextSpan(
                              text:
                                  '${_calculateDaysDifference(_startDate, _endDate)}',
                              style: styleS14W5(const Color(0xff007DC0)),
                              children: [
                            TextSpan(
                              text: ' ngày',
                              style: styleS14W5(const Color(0xff55595D)),
                            )
                          ]))
                    ],
                  ),
                  Spacer(),
                  ButtonWidget(
                    title: 'Hủy bỏ',
                    colorText: oceanBlue,
                    colorButton: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 16),
                  ButtonWidget(
                    title: 'Áp dụng',
                    colorText: Colors.white,
                    onPressed: () {
                      widget.buttonSelected(_startDate, _endDate);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildGroupTitleDropDown(
      {required String title, required Widget child}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: styleS12W4(textPrimary),
          ),
          Container(
              alignment: Alignment.center,
              height: 33,
              width: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffE3E5E5), width: 1)),
              child: child)
        ],
      ),
    );
  }

  Widget _buildItemPreset(String elementAt) {
    return InkWell(
      onTap: () {
        _onPresetSelected(elementAt);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              elementAt,
              style: styleS16W5(
                  _selectedPreset == elementAt ? oceanBlue : neutralGray),
            ),
            const SizedBox(width: 4),
            _selectedPreset == elementAt
                ? SvgPicture.asset('assets/icons/home/calendar_tick.svg')
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
