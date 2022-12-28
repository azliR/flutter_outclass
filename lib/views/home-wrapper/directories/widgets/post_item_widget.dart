import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outclass/models/directory/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.name,
              style: textTheme.titleMedium,
            ),
            if (post.description != null)
              Text(
                post.description!,
                style: textTheme.bodyMedium,
              ),
            if (post.files?.isNotEmpty ?? false)
              StaggeredGrid.count(
                crossAxisCount: 1,
                children: post.files!.map((file) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      title: Text(file.name),
                      subtitle: Text(file.size.toString()),
                      leading: CircleAvatar(child: Icon(Icons.picture_as_pdf)),
                      trailing: Icon(Icons.download, size: 20),
                      tileColor: colorScheme.surfaceVariant,
                      minVerticalPadding: 0,
                      dense: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
