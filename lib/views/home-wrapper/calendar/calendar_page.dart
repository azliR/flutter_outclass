import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/home/calendar/calendar_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/calendar/calendar_event.dart';
import 'package:outclass/views/core/utils/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget implements AutoRouteWrapper {
  const CalendarPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (_) => getIt<CalendarCubit>()
        ..getCalendarEvents(
            classroomId: authCubit.state.classroomMember!.classroomId),
      child: this,
    );
  }

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _calendarController = CalendarController();
  final _calendarDataSource = EventDataSource([]);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarCubit, CalendarState>(
      listenWhen: (previous, current) =>
          previous.getEventsStatus != current.getEventsStatus,
      listener: (context, state) {
        if (state.getEventsStatus == GetEventsStatus.success) {
          _calendarDataSource
            ..appointments.addAll(state.events)
            ..notifyListeners(CalendarDataSourceAction.add, state.events);
        } else if (state.getEventsStatus == GetEventsStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal mendapatkan event'),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            controller: _calendarController,
            dataSource: _calendarDataSource,
            view: CalendarView.week,
            showDatePickerButton: true,
            allowedViews: const [
              CalendarView.day,
              CalendarView.week,
              CalendarView.month,
              CalendarView.schedule,
            ],
          ),
        ),
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(this.source);

  List<CalendarEvent> source;

  @override
  List<CalendarEvent> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return appointments[index].startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].endDate ?? appointments[index].startDate;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].endDate == null;
  }

  @override
  String getSubject(int index) {
    return appointments[index].title;
  }

  @override
  Object? getRecurrenceId(int index) {
    return appointments[index].id;
  }

  @override
  String? getRecurrenceRule(int index) {
    final event = appointments[index];

    if (event.repeat == 'none') {
      return super.getRecurrenceRule(index);
    }

    return SfCalendar.generateRRule(
      RecurrenceProperties(
        recurrenceType: () {
          if (event.repeat == 'daily') {
            return RecurrenceType.daily;
          } else if (event.repeat == 'weekly') {
            return RecurrenceType.weekly;
          } else if (event.repeat == 'monthly') {
            return RecurrenceType.monthly;
          } else if (event.repeat == 'yearly') {
            return RecurrenceType.yearly;
          } else {
            throw Exception('Invalid repeat value: ${event.repeat}');
          }
        }(),
        weekDays: [WeekDays.values[event.startDate.weekday % 7]],
        startDate: event.startDate,
      ),
      event.startDate,
      event.endDate ?? event.startDate,
    );
  }

  @override
  Color getColor(int index) {
    return Color(
      colorPalettes
          .firstWhere(
              (colorPalette) => colorPalette.key == appointments[index].color)
          .color,
    );
  }
}
