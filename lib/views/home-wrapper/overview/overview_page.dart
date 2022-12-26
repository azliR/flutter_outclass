import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('Beranda'),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Deadline tugas',
                      style: textTheme.titleMedium,
                    ),
                  ),
                  const Divider(indent: 8, endIndent: 8, height: 0),
                  CheckboxListTile(
                    title: const Text('Presentasi OutClass'),
                    subtitle: const Text('11:00 pm, 27 Desember 2022'),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (bool? value) {},
                    value: false,
                    secondary: const CircleAvatar(
                      child: Icon(Icons.article_rounded),
                    ),
                    // onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
