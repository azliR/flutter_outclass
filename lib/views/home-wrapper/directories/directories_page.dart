import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/home/directories/directories_cubit.dart';
import 'package:outclass/dtos/directory_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/directory/folder.dart';
import 'package:outclass/models/directory/post.dart';
import 'package:outclass/views/home-wrapper/directories/widgets/folder_item_widget.dart';
import 'package:outclass/views/home-wrapper/directories/widgets/post_item_widget.dart';

class DirectoriesPage extends StatefulWidget implements AutoRouteWrapper {
  const DirectoriesPage({
    super.key,
    @PathParam() required this.shareType,
    @PathParam() required this.parentId,
  });

  final String shareType;
  final String parentId;

  @override
  State<DirectoriesPage> createState() => _DirectoriesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DirectoriesCubit>(),
      child: this,
    );
  }
}

class _DirectoriesPageState extends State<DirectoriesPage> {
  static const _pageLimit = 20;

  final _folderPagingController =
      PagingController<int, Folder>(firstPageKey: 1);
  final _postPagingController = PagingController<int, Post>(firstPageKey: 1);

  Future<void> _fetchFolders(int page) async {
    final authCubit = context.read<AuthCubit>();

    final newItems = await context.read<DirectoriesCubit>().getFolders(
          GetFoldersDto(
            classroomId: authCubit.state.classroom!.id,
            shareType: ShareType.fromString(widget.shareType),
            parentId: widget.parentId,
            page: page,
            pageLimit: _pageLimit,
          ),
        );
    final isLastPage = newItems.length < _pageLimit;
    if (isLastPage) {
      _folderPagingController.appendLastPage(newItems);
    } else {
      _folderPagingController.appendPage(newItems, page + 1);
    }
  }

  Future<void> _fetchPosts(int page) async {
    final authCubit = context.read<AuthCubit>();

    final newItems = await context.read<DirectoriesCubit>().getPosts(
          GetPostsDto(
            classroomId: authCubit.state.classroom!.id,
            shareType: ShareType.fromString(widget.shareType),
            parentId: widget.parentId,
            page: page,
            pageLimit: _pageLimit,
          ),
        );
    final isLastPage = newItems.length < _pageLimit;
    if (isLastPage) {
      _postPagingController.appendLastPage(newItems);
    } else {
      _postPagingController.appendPage(newItems, page + 1);
    }
  }

  @override
  void initState() {
    _folderPagingController.addPageRequestListener(_fetchFolders);
    _postPagingController.addPageRequestListener(_fetchPosts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      child: CustomScrollView(
        slivers: [
          if (context.router.canPop())
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colorScheme.onSecondaryContainer,
                      backgroundColor: colorScheme.secondaryContainer,
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
                    onPressed: () => context.router.pop(),
                    label: const Text('Kembali'),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Folder',
                style: textTheme.labelMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: PagedSliverList(
              pagingController: _folderPagingController,
              shrinkWrapFirstPageIndicators: true,
              builderDelegate: PagedChildBuilderDelegate<Folder>(
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text('Folder masih kosong'),
                ),
                itemBuilder: (context, item, index) {
                  return FolderItem(folder: item);
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Postingan',
                style: textTheme.labelMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: PagedSliverList(
              pagingController: _postPagingController,
              shrinkWrapFirstPageIndicators: true,
              builderDelegate: PagedChildBuilderDelegate<Post>(
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text('Postingan masih kosong'),
                ),
                itemBuilder: (context, item, index) {
                  return PostItem(post: item);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
