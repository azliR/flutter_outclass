part of 'overview_cubit.dart';

class OverviewState extends Equatable {
  const OverviewState({
    required this.upcomingEvents,
    required this.upcomingTasks,
  });

  factory OverviewState.initial() => const OverviewState(
        upcomingEvents: [],
        upcomingTasks: [],
      );

  final List<Event> upcomingEvents;
  final List<Task> upcomingTasks;

  OverviewState copyWith({
    List<Event>? upcomingEvents,
    List<Task>? upcomingTasks,
  }) {
    return OverviewState(
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      upcomingTasks: upcomingTasks ?? this.upcomingTasks,
    );
  }

  @override
  List<Object> get props => [];
}
