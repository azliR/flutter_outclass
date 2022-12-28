import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/home/directories/add_post/add_post_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';

class AddPostDialog extends StatelessWidget implements AutoRouteWrapper {
  const AddPostDialog({
    super.key,
    required this.shareType,
    this.parentId,
    this.existingPost,
    required this.onPostCreated,
  });

  final String shareType;
  final String? parentId;
  final Post? existingPost;
  final void Function(Post post) onPostCreated;

  @override
  Widget wrappedRoute(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (_) => getIt<AddPostCubit>()
        ..init(
          classroomId: authCubit.state.classroom!.id,
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<AddPostCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(existingPost == null ? 'Buat post' : 'Edit post'),
        actions: [
          ElevatedButton(
            onPressed: () => cubit.onSavePressed(
              isUpdating: existingPost != null,
              onPostCreated: onPostCreated,
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
                      initialValue: existingPost?.name,
                      onChanged: cubit.onPostNameChanged,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        label: Text('Nama post'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: existingPost?.description,
                      minLines: 2,
                      maxLines: 5,
                      onChanged: cubit.onPostDescriptionChanged,
                      decoration: InputDecoration(
                        icon: Icon(Icons.notes),
                        label: Text('Deskripsi'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Pilih warna',
                        style: textTheme.titleMedium,
                      ),
                    ),
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
