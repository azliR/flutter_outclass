import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/views/core/app_router.dart';

class DirectoriesWrapperPage extends StatelessWidget {
  const DirectoriesWrapperPage({super.key});

  void _openAddFolderDialog(BuildContext context) {
    final a = context.router;
    context.router.push(const AddFolderDialogRoute());
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
                  onTap: () {},
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Icon(Icons.post_add_rounded),
                ),
                SpeedDialChild(
                  label: 'Buat folder',
                  onTap: () => _openAddFolderDialog(context),
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
