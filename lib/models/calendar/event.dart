import 'package:equatable/equatable.dart';
import 'package:outclass/models/calendar/calendar_event.dart';

class Event extends Equatable {
  const Event({
    required this.id,
    required this.ownerId,
    required this.classroomId,
    required this.title,
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
  final DateTime startDate;
  final DateTime? endDate;
  final String repeat;
  final String color;
  final String? description;
  final DateTime lastModified;
  final DateTime dateCreated;

  factory Event.fromCalendarEvent(CalendarEvent calendarEvent) => Event(
        id: calendarEvent.id,
        ownerId: calendarEvent.ownerId,
        classroomId: calendarEvent.classroomId,
        title: calendarEvent.title,
        startDate: calendarEvent.startDate,
        endDate: calendarEvent.endDate,
        repeat: calendarEvent.repeat,
        color: calendarEvent.color,
        description: calendarEvent.description,
        lastModified: calendarEvent.lastModified,
        dateCreated: calendarEvent.dateCreated,
      );

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'] as String,
        ownerId: json['owner_id'] as String,
        classroomId: json['classroom_id'] as String,
        title: json['title'] as String,
        startDate: DateTime.parse(json['start_date'] as String),
        endDate: (json['end_date'] as String?) == null
            ? null
            : DateTime.parse(json['end_date'] as String),
        repeat: json['repeat'] as String,
        color: json['color'] as String,
        description: json['description'] as String?,
        lastModified: DateTime.parse(json['last_modified'] as String),
        dateCreated: DateTime.parse(json['date_created'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner_id': ownerId,
        'classroom_id': classroomId,
        'title': title,
        'start_date': startDate,
        'end_date': endDate,
        'repeat': repeat,
        'color': color,
        'description': description,
        'last_modified': lastModified.toIso8601String(),
        'date_created': dateCreated.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      ownerId,
      classroomId,
      title,
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
