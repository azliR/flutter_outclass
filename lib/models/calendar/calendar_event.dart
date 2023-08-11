import 'package:equatable/equatable.dart';
import 'package:outclass/models/calendar/event.dart';
import 'package:outclass/models/calendar/task.dart';

enum EventType { event, task }

class CalendarEvent extends Equatable {
  const CalendarEvent({
    required this.id,
    required this.ownerId,
    required this.classroomId,
    required this.title,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.repeat,
    required this.color,
    this.description,
    required this.lastModified,
    required this.dateCreated,
  });

  final String id;
  final String ownerId;
  final String classroomId;
  final String title;
  final String type;
  final DateTime startDate;
  final DateTime? endDate;
  final String repeat;
  final String color;
  final String? description;
  final DateTime lastModified;
  final DateTime dateCreated;

  factory CalendarEvent.fromEvent(Event event) => CalendarEvent(
        id: event.id,
        ownerId: event.ownerId,
        classroomId: event.classroomId,
        title: event.title,
        type: 'event',
        startDate: event.startDate,
        endDate: event.endDate,
        repeat: event.repeat,
        color: event.color,
        description: event.description,
        lastModified: event.lastModified,
        dateCreated: event.dateCreated,
      );

  factory CalendarEvent.fromTask(Task task) => CalendarEvent(
        id: task.id,
        ownerId: task.ownerId,
        classroomId: task.classroomId,
        title: task.title,
        type: 'task',
        startDate: task.date,
        repeat: task.repeat,
        color: task.color,
        lastModified: task.lastModified,
        dateCreated: task.dateCreated,
      );

  @override
  List<Object?> get props {
    return [
      id,
      ownerId,
      classroomId,
      title,
      type,
      startDate,
      endDate,
      repeat,
      color,
      description,
      lastModified,
      dateCreated,
    ];
  }
}
