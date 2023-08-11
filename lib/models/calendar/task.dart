import 'package:equatable/equatable.dart';
import 'package:outclass/models/calendar/calendar_event.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.ownerId,
    required this.classroomId,
    required this.title,
    this.details,
    required this.date,
    required this.repeat,
    required this.color,
    this.files,
    required this.lastModified,
    required this.dateCreated,
  });

  final String id;
  final String ownerId;
  final String classroomId;
  final String title;
  final String? details;
  final DateTime date;
  final String repeat;
  final String color;
  final List<TaskFile>? files;
  final DateTime lastModified;
  final DateTime dateCreated;

  factory Task.fromCalendarEvent(CalendarEvent calendarEvent) => Task(
        id: calendarEvent.id,
        ownerId: calendarEvent.ownerId,
        classroomId: calendarEvent.classroomId,
        title: calendarEvent.title,
        details: calendarEvent.description,
        date: calendarEvent.startDate,
        repeat: calendarEvent.repeat,
        color: calendarEvent.color,
        files: const [],
        lastModified: calendarEvent.lastModified,
        dateCreated: calendarEvent.dateCreated,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        ownerId: json['owner_id'] as String,
        classroomId: json['classroom_id'] as String,
        title: json['title'] as String,
        details: json['details'] as String?,
        date: DateTime.parse(json['date'] as String),
        repeat: json['repeat'] as String,
        color: json['color'] as String,
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => TaskFile.fromJson(e as Map<String, dynamic>))
            .toList(),
        lastModified: DateTime.parse(json['last_modified'] as String),
        dateCreated: DateTime.parse(json['date_created'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner_id': ownerId,
        'classroom_id': classroomId,
        'title': title,
        'details': details,
        'date': date.toIso8601String(),
        'repeat': repeat,
        'color': color,
        'files': files?.map((e) => e.toJson()).toList(),
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
      details,
      date,
      repeat,
      color,
      files,
      lastModified,
      dateCreated,
    ];
  }
}

class TaskFile extends Equatable {
  const TaskFile({
    required this.name,
    required this.link,
    required this.type,
    required this.size,
  });

  final String name;
  final String link;
  final String type;
  final int size;

  factory TaskFile.fromJson(Map<String, dynamic> json) => TaskFile(
        name: json['name'] as String,
        link: json['link'] as String,
        type: json['type'] as String,
        size: json['size'] as int,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
        'type': type,
        'size': size,
      };

  @override
  List<Object?> get props => [name, link, type, size];
}
