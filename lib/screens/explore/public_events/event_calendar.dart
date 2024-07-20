import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zineapp2023/screens/explore/public_events/view_models/public_events_vm.dart';
import 'package:zineapp2023/theme/color.dart';

class EventCalendar extends StatelessWidget {
  const EventCalendar({super.key, required this.evm});
  final PublicEventsVM evm;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: const CalendarStyle(
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: textDarkBlue,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: blurBlue,
          )),
      eventLoader: evm.getEvents,
      focusedDay: (evm.isLoaded && !evm.isError && evm.events.isNotEmpty)
          ? DateTime.now()
          : evm.selectedEvent.timeDate!.toDate(),
      selectedDayPredicate: (day) {
        if (evm.isError || !evm.isLoaded || evm.events.isEmpty) {
          return false;
        } else {
          return isSameDay(evm.selectedEvent.timeDate!.toDate(), day);
        }
      },
      firstDay: DateTime.now(),
      lastDay: evm.getLastEventDate(),
      onDaySelected: evm.selectEvent,
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 30),
        rightChevronVisible: false,
        leftChevronVisible: false,
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }
}
