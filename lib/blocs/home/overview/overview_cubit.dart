import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/calendar/calendar_event.dart';
import 'package:outclass/models/calendar/event.dart';
import 'package:outclass/models/calendar/task.dart';

part 'overview_state.dart';

@injectable
class OverviewCubit extends Cubit<OverviewState> {
  OverviewCubit() : super(OverviewState.initial());

  void updateEvents(List<CalendarEvent> calendarEvents) {
    emit(
      state.copyWith(
        upcomingEvents:
            calendarEvents.fold<List<Event>>([], (previous, calendarEvent) {
          if (calendarEvent.type == 'event') {
            if (calendarEvent.startDate.isAfter(DateTime.now())) {
              return [...previous, Event.fromCalendarEvent(calendarEvent)];
            }
          }
          return previous;
        }).toList(),
      ),
    );

    emit(
      state.copyWith(
        upcomingTasks:
            calendarEvents.fold<List<Task>>([], (previous, calendarEvent) {
          if (calendarEvent.type == 'task') {
            if (calendarEvent.startDate.isAfter(DateTime.now())) {
              return [...previous, Task.fromCalendarEvent(calendarEvent)];
            }
          }
          return previous;
        }).toList(),
      ),
    );
  }
}
