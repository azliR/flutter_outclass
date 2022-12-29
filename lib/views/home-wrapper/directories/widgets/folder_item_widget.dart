import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/home/directories/directories_cubit.dart';
import 'package:outclass/blocs/home/directories_wrapper/directories_wrapper_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/views/core/app_router.dart';
import 'package:outclass/views/core/utils/colors.dart';

enum PopupItem {
  edit,
  delete;
}

class FolderItem extends StatelessWidget {
  const FolderItem({
    super.key,
    required this.folder,
    required this.onTap,
  });

  final Folder folder;
  final void Function() onTap;

  void _onEditPressed(BuildContext context) {
    final shareType = () {
      if (folder.classroomId != null) {
        return ShareType.classroom;
      } else if (folder.sharedWith != null) {
        return ShareType.group;
      } else {
        return ShareType.personal;
      }
    }();

    context.router.push(
      AddFolderDialogRoute(
        parentId: folder.parentId ?? '',
        onFolderCreated: (folder) {
          context
              .read<DirectoriesWrapperCubit>()
              .state
              .folderPagingControllers[shareType]
              ?.refresh();
        },
        shareType: shareType.toString(),
        existingFolder: folder,
      ),
    );
  }

  void _onDeletePressed(BuildContext context) {
    final cubit = context.read<DirectoriesCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Folder'),
          content: const Text(
              'Folder ini sama isinya bakal kehapus semua? Yakin mau ngehapusnya?'),
          actions: [
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () async {
                Navigator.pop(context);
                await cubit.deleteFolder(folder.id);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

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
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return PopupItem.values.map((item) {
              return PopupMenuItem(
                value: item,
                child: Text(
                  () {
                    switch (item) {
                      case PopupItem.edit:
                        return 'Edit';
                      case PopupItem.delete:
                        return 'Delete';
                    }
                  }(),
                ),
              );
            }).toList();
          },
          onSelected: (value) {
            switch (value) {
              case PopupItem.edit:
                _onEditPressed(context);
                break;
              case PopupItem.delete:
                _onDeletePressed(context);
                break;
            }
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        tileColor: colorScheme.surfaceVariant,
        title: Text(folder.name),
        onTap: onTap,
      ),
    );
  }
}
