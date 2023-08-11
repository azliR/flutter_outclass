import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:outclass/blocs/home/directories_wrapper/directories_wrapper_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/core/app_router.gr.dart';

@RoutePage()
class DirectoriesWrapperPage extends StatelessWidget
    implements AutoRouteWrapper {
  const DirectoriesWrapperPage({super.key});

  void _openAddFolderDialog({
    required BuildContext context,
    required ShareType shareType,
  }) {
    final cubit = context.read<DirectoriesWrapperCubit>();

    context.router.push(
      AddFolderDialogRoute(
        onFolderCreated: (folder) {
          cubit.state.folderPagingControllers[shareType]?.refresh();
        },
        shareType: shareType.toString(),
        parentId: cubit.state.currentFolderId,
      ),
    );
  }

  void _openAddPostDialog({
    required BuildContext context,
    required ShareType shareType,
  }) {
    final cubit = context.read<DirectoriesWrapperCubit>();
    print('1212 ${cubit.state.currentFolderId}');
    context.router.push(
      AddPostDialogRoute(
        onPostCreated: (post) {
          cubit.state.postPagingControllers[shareType]?.refresh();
        },
        shareType: shareType.toString(),
        parentId: cubit.state.currentFolderId,
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DirectoriesWrapperCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ShareType.values.length,
      child: AutoTabsRouter.tabBar(
        homeIndex: 0,
        routes: ShareType.values
            .map(
              (shareType) => DirectoriesShareTypeWrapperRoute(
                children: [
                  DirectoriesRoute(
                    shareType: shareType.toString(),
                  ),
                ],
              ),
            )
            .toList(),
        builder: (tabContext, child, tabController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Berkas'),
              bottom: TabBar(
                controller: tabController,
                onTap: (index) {},
                tabs: ShareType.values
                    .map(
                      (shareType) => Tab(
                        text: () {
                          switch (shareType) {
                            case ShareType.classroom:
                              return 'Kelas';
                            case ShareType.group:
                              return 'Kelompok';
                            case ShareType.personal:
                              return 'Personal';
                          }
                        }(),
                      ),
                    )
                    .toList(),
              ),
            ),
            body: child,
            floatingActionButton: SpeedDial(
              icon: Icons.add,
              shape: Theme.of(tabContext).floatingActionButtonTheme.shape ??
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
              activeIcon: Icons.close,
              childrenButtonSize: const Size.square(48),
              spaceBetweenChildren: 16,
              childPadding: const EdgeInsets.all(4),
              children: [
                SpeedDialChild(
                  label: 'Buat postingan',
                  onTap: () => _openAddPostDialog(
                    context: context,
                    shareType: ShareType.values[tabController.index],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Icon(Icons.post_add_rounded),
                ),
                SpeedDialChild(
                  label: 'Buat folder',
                  onTap: () => _openAddFolderDialog(
                    context: context,
                    shareType: ShareType.values[tabController.index],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Icon(Icons.create_new_folder_rounded),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class InheritedDirectoriesData extends InheritedWidget {
//   const InheritedDirectoriesData({
//     super.key,
//     required String parentId,
//     required this.folderPagingControllers,
//     required this.postPagingControllers,
//     required super.child,
//   });

//   final String parentId;
//   final PagingController<int, Folder> a;
//   final Map<ShareType, PagingController<int, Folder>> folderPagingControllers;
//   final Map<ShareType, PagingController<int, Post>> postPagingControllers;

//   static InheritedDirectoriesData? maybeOf(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<InheritedDirectoriesData>();
//   }

//   static InheritedDirectoriesData of(BuildContext context) {
//     final result = maybeOf(context);
//     assert(result != null, 'No InheritedPagingController found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(InheritedDirectoriesData oldWidget) => false;
// }
