import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/views/core/app_router.dart';

class DirectoriesWrapperPage extends StatelessWidget {
  DirectoriesWrapperPage({super.key});

  final _folderPagingControllers = {
    for (var shareType in ShareType.values)
      shareType: PagingController<int, Folder>(firstPageKey: 1)
  };

  final _postPagingControllers = {
    for (var shareType in ShareType.values)
      shareType: PagingController<int, Post>(firstPageKey: 1)
  };

  void _openAddFolderDialog({
    required BuildContext context,
    required ShareType shareType,
  }) {
    context.router.push(
      AddFolderDialogRoute(
        onFolderCreated: (folder) {
          _folderPagingControllers[shareType]?.refresh();
        },
        shareType: shareType.toString(),
      ),
    );
  }

  void _openAddPostDialog({
    required BuildContext context,
    required ShareType shareType,
  }) {
    context.router.push(
      AddPostDialogRoute(
        onPostCreated: (post) {
          _postPagingControllers[shareType]?.refresh();
        },
        shareType: shareType.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InheritedPagingController(
      folderPagingControllers: _folderPagingControllers,
      postPagingControllers: _postPagingControllers,
      child: DefaultTabController(
        length: ShareType.values.length,
        child: AutoTabsRouter.tabBar(
          homeIndex: 0,
          routes: ShareType.values
              .map(
                (shareType) => DirectoriesShareTypeWrapperRoute(
                  children: [
                    DirectoriesRoute(
                      shareType: shareType.toString(),
                      parentId: '',
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
      ),
    );
  }
}

class InheritedPagingController extends InheritedWidget {
  const InheritedPagingController({
    super.key,
    required this.folderPagingControllers,
    required this.postPagingControllers,
    required super.child,
  });

  final Map<ShareType, PagingController<int, Folder>> folderPagingControllers;
  final Map<ShareType, PagingController<int, Post>> postPagingControllers;

  static InheritedPagingController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedPagingController>();
  }

  static InheritedPagingController of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No InheritedPagingController found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedPagingController oldWidget) => false;
}
