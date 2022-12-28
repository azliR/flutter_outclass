import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DirectoriesShareTypeWrapperPage extends StatelessWidget {
  const DirectoriesShareTypeWrapperPage({
    super.key,
    @PathParam() required this.shareType,
  });

  final String shareType;

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
