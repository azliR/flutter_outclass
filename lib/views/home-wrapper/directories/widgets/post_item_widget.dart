import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outclass/blocs/home/directories/directories_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/views/core/app_router.dart';
import 'package:outclass/views/home-wrapper/directories/directories_wrapper_page.dart';

enum PopupItem {
  edit,
  delete;
}

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  void _onEditPressed(BuildContext context) {
    final shareType = () {
      if (post.classroomId != null) {
        return ShareType.classroom;
      } else if (post.sharedWith != null) {
        return ShareType.group;
      } else {
        return ShareType.personal;
      }
    }();

    context.router.push(
      AddPostDialogRoute(
        onPostCreated: (post) {
          InheritedPagingController.of(context).postPagingController.refresh();
        },
        shareType: shareType.toString(),
        existingPost: post,
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
          title: const Text('Hapus Post'),
          content: const Text(
              'Post ini sama isinya bakal kehapus semua? Yakin mau ngehapusnya?'),
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
                await cubit.deletePost(post.id);
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.name,
                  style: textTheme.titleMedium,
                ),
                PopupMenuButton(
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
              ],
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
