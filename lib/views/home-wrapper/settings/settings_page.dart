import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('Pengaturan'),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      'Tampilan',
                      style: textTheme.caption,
                    ),
                  ),
                  ListTile(
                    title: const Text('Tema'),
                    subtitle: const Text('Gelap'),
                    leading: const CircleAvatar(
                      child: Icon(Icons.brightness_4),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
