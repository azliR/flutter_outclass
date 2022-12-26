import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:outclass/views/core/app_router.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Account'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_rounded),
                onPressed: () {
                  context.router.push(const SettingsRoute());
                },
              ),
            ],
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profil kamu',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Semua orang di kelas kamu bakal bisa liat info ini',
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                  const Divider(indent: 8, endIndent: 8, height: 0),
                  ListTile(
                    title: const Text('Nama'),
                    subtitle: const Text('Rizal Hadiyansah'),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: const Text('rizalhadiyansah@gmail.com'),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Password'),
                    subtitle: const Text('********'),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelas',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Data kelas kamu sekarang',
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                  const Divider(indent: 8, endIndent: 8, height: 0),
                  ListTile(
                    title: const Text('Nama Kelas'),
                    subtitle: const Text('IF E (2022)'),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Kode Kelas'),
                    subtitle: const Text('sjkEpxSio2zAl04H'),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Anggota Kelas'),
                    subtitle: const Text('22 anggota'),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
