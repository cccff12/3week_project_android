import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../bagick/myappbar.dart';

class Calendar extends StatefulWidget {
  Calendar({
    Key? key,
  }) : super(key: key);
  String? category;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  User? user = FirebaseAuth.instance.currentUser;
  late ValueNotifier<List<String>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  // 현재 날짜
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedEvents =
        ValueNotifier<List<String>>(_getEventsForDay(DateTime.now()));
  }

  List<String> _getEventsForDay(DateTime day) {
    // 여기에 해당 날짜에 대한 이벤트 목록을 가져오는 로직을 추가하세요.
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SizedBox(
        width: 1000,
        child: Container(
          // 배경색 또는 다른 스타일을 설정하세요.
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
            child: Column(
              children: [
                TableCalendar(
                  locale: 'ko_KR', // 한글로 날짜 표시
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2023, 1, 1), // 수정: 원하는 날짜로 변경
                  lastDay: DateTime.utc(2023, 12, 31), // 수정: 원하는 날짜로 변경
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedEvents.value = _getEventsForDay(selectedDay);
                    });
                  },
                ),
                ValueListenableBuilder<List<String>>(
                  valueListenable: _selectedEvents,
                  builder: (context, events, _) {
                    // 이벤트 목록을 표시하거나 다른 작업을 수행하세요.
                    return const Text('선택한 날짜에 대한 이벤트 목록');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
