import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outclass/blocs/home/directories/directories_cubit.dart';
import 'package:outclass/blocs/home/directories_wrapper/directories_wrapper_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/views/core/app_router.gr.dart';

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
        parentId: post.parentId ?? '',
        onPostCreated: (post) {
          context
              .read<DirectoriesWrapperCubit>()
              .state
              .postPagingControllers[shareType]
              ?.refresh();
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
    final cubit = context.read<DirectoriesCubit>();
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
                      leading: CircleAvatar(
                        child: Icon(
                          _getFileIcon(file.type),
                          color: _getFileColor(file.type),
                        ),
                      ),
                      tileColor: colorScheme.surfaceVariant,
                      minVerticalPadding: 0,
                      dense: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      onTap: () => cubit.openFile(file),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon(String type) {
    if (type == 'pdf') {
      return Icons.picture_as_pdf_outlined;
    } else if (type == 'doc' || type == 'docx') {
      return Icons.description_outlined;
    } else if (type == 'xls' || type == 'xlsx') {
      return Icons.table_chart_outlined;
    } else if (type == 'ppt' || type == 'pptx') {
      return Icons.slideshow_outlined;
    } else if (type == 'zip' || type == 'rar') {
      return Icons.folder_zip_outlined;
    } else if (type == 'txt') {
      return Icons.article_outlined;
    } else if (type == 'mp4' || type == 'avi' || type == 'mkv') {
      return Icons.video_file_outlined;
    } else if (type == 'mp3' || type == 'wav') {
      return Icons.audio_file_outlined;
    } else if (type == 'jpg' || type == 'png' || type == 'jpeg') {
      return Icons.image_outlined;
    }
    return Icons.notes_outlined;
  }

  Color _getFileColor(String type) {
    if (type == 'pdf') {
      return Colors.red;
    } else if (type == 'doc' || type == 'docx') {
      return Colors.blue;
    } else if (type == 'xls' || type == 'xlsx') {
      return Colors.green.shade600;
    } else if (type == 'ppt' || type == 'pptx') {
      return Colors.orange;
    } else if (type == 'zip' || type == 'rar') {
      return Colors.green;
    } else if (type == 'txt') {
      return Colors.grey.shade600;
    } else if (type == 'mp4' || type == 'avi' || type == 'mkv') {
      return Colors.red.shade700;
    } else if (type == 'mp3' || type == 'wav') {
      return Colors.blueGrey;
    } else if (type == 'jpg' || type == 'png' || type == 'jpeg') {
      return Colors.deepPurple;
    }
    return Colors.grey;
  }
}
