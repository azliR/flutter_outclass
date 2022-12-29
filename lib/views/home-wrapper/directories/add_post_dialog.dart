import 'package:auto_route/auto_route.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/home/directories/add_post/add_post_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';

class AddPostDialog extends StatefulWidget implements AutoRouteWrapper {
  const AddPostDialog({
    super.key,
    required this.shareType,
    required this.parentId,
    this.existingPost,
    required this.onPostCreated,
  });

  final String shareType;
  final String parentId;
  final Post? existingPost;
  final void Function(Post post) onPostCreated;

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (_) => getIt<AddPostCubit>()
        ..init(
          classroomId: authCubit.state.classroomMember!.classroomId,
          existingPost: existingPost,
          shareType: ShareType.fromString(shareType),
          parentId: parentId,
        ),
      child: BlocListener<AddPostCubit, AddPostState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AddPostStatus.success) {
            Navigator.of(context).pop();
          } else if (state.status == AddPostStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gagal membuat post'),
              ),
            );
          }
        },
        child: this,
      ),
    );
  }
}

class _AddPostDialogState extends State<AddPostDialog> {
  var _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<AddPostCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingPost == null ? 'Buat post' : 'Edit post'),
        actions: [
          ElevatedButton(
            onPressed: () => cubit.onSavePressed(
              isUpdating: widget.existingPost != null,
              onPostCreated: widget.onPostCreated,
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: colorScheme.onPrimary,
              backgroundColor: colorScheme.primary,
            ),
            child: Text('Simpan'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocSelector<AddPostCubit, AddPostState, bool>(
          selector: (state) => state.status == AddPostStatus.submitting,
          builder: (context, isSubmitting) {
            return ProgressOverlay(
              visible: isSubmitting,
              child: Form(
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: widget.existingPost?.name,
                      onChanged: cubit.onPostNameChanged,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        label: Text('Judul postingan'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: widget.existingPost?.description,
                      minLines: 2,
                      maxLines: 5,
                      onChanged: cubit.onPostDescriptionChanged,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.notes),
                        label: Text('Deskripsi'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Pilih berkas',
                        style: textTheme.titleMedium,
                      ),
                    ),
                    BlocSelector<AddPostCubit, AddPostState, List<XFile>>(
                      selector: (state) => state.addPostDto.files,
                      builder: (context, files) {
                        return DropTarget(
                          onDragDone: (detail) {
                            cubit.onPostFilesChanged(
                              [...files, ...detail.files],
                            );
                          },
                          onDragEntered: (detail) {
                            setState(() {
                              _isDragging = true;
                            });
                          },
                          onDragExited: (detail) {
                            setState(() {
                              _isDragging = false;
                            });
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: 180,
                            ),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceVariant,
                              border: Border.all(
                                color: _isDragging
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                                width: _isDragging ? 2 : 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (files.isEmpty)
                                  Center(
                                    child: Text(
                                      _isDragging
                                          ? 'Lepasin buat nambahin berkasnya'
                                          : 'Lempar sini berkasnya, atau',
                                    ),
                                  )
                                else
                                  Wrap(
                                    children: [
                                      for (final file in files)
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Chip(
                                            label: Text(file.name),
                                            onDeleted: () {
                                              cubit.onPostFilesChanged(
                                                [...files]..remove(file),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                const SizedBox(height: 8),
                                if (!_isDragging)
                                  ElevatedButton(
                                    onPressed: cubit.onSelectFiles,
                                    child: Text('Pilih berkas'),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
