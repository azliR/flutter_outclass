import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/calendar/calendar_event.dart';
import 'package:outclass/repositories/event_repository.dart';
import 'package:outclass/repositories/task_repository.dart';

part 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._eventRepository, this._taskRepository)
      : super(CalendarState.initial());

  final EventRepository _eventRepository;
  final TaskRepository _taskRepository;

  Future<void> getCalendarEvents({required String classroomId}) async {
    emit(state.copyWith(getEventsStatus: GetEventsStatus.loading));

    final calendarEvents = <CalendarEvent>[];

    final eventsResponse =
        await _eventRepository.getEvents(classroomId: classroomId);
    if (!eventsResponse.success) {
      emit(state.copyWith(getEventsStatus: GetEventsStatus.failure));
      return;
    }
    calendarEvents.addAll(
      eventsResponse.data?.map(CalendarEvent.fromEvent).toList() ?? [],
    );

    final tasksResponse =
        await _taskRepository.getTasks(classroomId: classroomId);
    if (!tasksResponse.success) {
      emit(state.copyWith(getEventsStatus: GetEventsStatus.failure));
      return;
    }
    calendarEvents
        .addAll(tasksResponse.data?.map(CalendarEvent.fromTask).toList() ?? []);

    emit(
      state.copyWith(
        events: calendarEvents,
        getEventsStatus: GetEventsStatus.success,
      ),
    );
  }
}
