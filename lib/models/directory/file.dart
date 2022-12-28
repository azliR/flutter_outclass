import 'package:equatable/equatable.dart';

class PostFile extends Equatable {
  const PostFile({
    required this.name,
    required this.link,
    required this.type,
    required this.size,
  });

  final String name;
  final String link;
  final String type;
  final int size;

  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
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
