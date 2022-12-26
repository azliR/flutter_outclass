import 'package:flutter/material.dart';
import 'package:outclass/models/directory/directory.dart';

class FolderItem extends StatelessWidget {
  const FolderItem({super.key, required this.folder});

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(folder.name),
    );
  }
}
