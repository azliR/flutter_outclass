part of 'calendar_cubit.dart';

enum GetEventsStatus {
  initial,
  loading,
  success,
  failure,
}

class CalendarState extends Equatable {
  const CalendarState({
    required this.events,
    required this.getEventsStatus,
  });

  factory CalendarState.initial() => const CalendarState(
        events: [],
        getEventsStatus: GetEventsStatus.initial,
      );

  final List<CalendarEvent> events;
  final GetEventsStatus getEventsStatus;

  CalendarState copyWith({
    List<CalendarEvent>? events,
    GetEventsStatus? getEventsStatus,
  }) {
    return CalendarState(
      events: events ?? this.events,
      getEventsStatus: getEventsStatus ?? this.getEventsStatus,
    );
  }

  @override
  List<Object> get props => [events, getEventsStatus];
}
