import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:outclass/models/directory/directory.dart';
import 'package:outclass/views/home-wrapper/posts/widgets/folder_item_widget.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  static const _pageSize = 20;

  final PagingController<int, Folder> _folderPagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _folderPagingController.addPageRequestListener((pageKey) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Posts'),
          ),
          PagedSliverList(
            pagingController: _folderPagingController,
            builderDelegate: PagedChildBuilderDelegate<Folder>(
              itemBuilder: (context, item, index) {
                return FolderItem(
                  folder: item,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
