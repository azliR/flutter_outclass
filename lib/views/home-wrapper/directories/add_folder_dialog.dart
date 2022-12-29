import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/home/directories/add_folder/add_folder_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';
import 'package:outclass/views/core/utils/colors.dart';

class AddFolderDialog extends StatelessWidget implements AutoRouteWrapper {
  const AddFolderDialog({
    super.key,
    required this.shareType,
    required this.parentId,
    this.existingFolder,
    required this.onFolderCreated,
  });

  final String shareType;
  final String parentId;
  final Folder? existingFolder;
  final void Function(Folder folder) onFolderCreated;

  @override
  Widget wrappedRoute(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocProvider(
      create: (_) => getIt<AddFolderCubit>()
        ..init(
          classroomId: authCubit.state.classroomMember!.classroomId,
          existingFolder: existingFolder,
          shareType: ShareType.fromString(shareType),
          parentId: parentId,
        ),
      child: BlocListener<AddFolderCubit, AddFolderState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AddFolderStatus.success) {
            Navigator.of(context).pop();
          } else if (state.status == AddFolderStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gagal membuat folder'),
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
    final cubit = context.read<AddFolderCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(existingFolder == null ? 'Buat folder' : 'Edit folder'),
        actions: [
          ElevatedButton(
            onPressed: () => cubit.onSavePressed(
              isUpdating: existingFolder != null,
              onFolderCreated: onFolderCreated,
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
        child: BlocSelector<AddFolderCubit, AddFolderState, bool>(
          selector: (state) => state.status == AddFolderStatus.submitting,
          builder: (context, isSubmitting) {
            return ProgressOverlay(
              visible: isSubmitting,
              child: Form(
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: existingFolder?.name,
                      onChanged: cubit.onFolderNameChanged,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        label: Text('Nama folder'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: existingFolder?.description,
                      minLines: 2,
                      maxLines: 5,
                      onChanged: cubit.onFolderDescriptionChanged,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child:
                          BlocSelector<AddFolderCubit, AddFolderState, String?>(
                        selector: (state) => state.addFolderDto.color,
                        builder: (context, state) {
                          return Wrap(
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: colorPalettes.map(
                              (colorPalette) {
                                return Tooltip(
                                  message: colorPalette.name,
                                  child: Material(
                                    color: Color(colorPalette.color),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    elevation: 4,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      onTap: () => cubit.onFolderColorChanged(
                                          colorPalette.key),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: state == colorPalette.key
                                            ? const Icon(Icons.check)
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          );
                        },
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
