import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/views/core/app_router.dart';
import 'package:outclass/views/core/utils/colors.dart';

class FolderItem extends StatelessWidget {
  const FolderItem({super.key, required this.folder});

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(
            colorPalettes
                .firstWhere((color) => color.key == folder.color)
                .color,
          ),
          child: const Icon(Icons.folder),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        tileColor: colorScheme.surfaceVariant,
        title: Text(folder.name),
        onTap: () {
          context.router.push(
            DirectoriesRoute(
              shareType: ShareType.classroom.toString(),
              parentId: folder.id,
            ),
          );
        },
      ),
    );
  }
}
