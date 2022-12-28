import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/home/account/account_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/core/app_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class AccountPage extends StatelessWidget implements AutoRouteWrapper {
  const AccountPage({super.key});

  void _onShowQrCodePressed(BuildContext context) {
    final profile = context.read<AccountCubit>().state.profile;
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('QR Code'),
          content: Center(
            child: PrettyQr(
              data: profile!.classCode,
              roundEdges: true,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AccountCubit>()
        ..getClassroomMemberProfile(
          classroomId: context.read<AuthCubit>().state.classroom!.id,
        ),
      child: BlocListener<AccountCubit, AccountState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FetchProfileStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gagal menyimpan'),
              ),
            );
          }
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<AccountCubit, AccountState>(
        buildWhen: (previous, current) =>
            previous.profile != current.profile ||
            previous.status != current.status,
        builder: (context, state) {
          return CustomScrollView(
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
              if (state.status == FetchProfileStatus.inProgress)
                const SliverToBoxAdapter(
                  child: LinearProgressIndicator(),
                ),
              if (state.status == FetchProfileStatus.failed)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Gagal memuat profil',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                ),
              if (state.status == FetchProfileStatus.succeeded)
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
                          subtitle: Text(state.profile!.name),
                          trailing: const Icon(Icons.arrow_right),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Email'),
                          subtitle: Text(state.profile!.email),
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
              if (state.status == FetchProfileStatus.succeeded)
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
                          subtitle: Text(state.profile!.classroomName),
                          trailing: const Icon(Icons.arrow_right),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Kode Kelas'),
                          subtitle: Text(state.profile!.classCode),
                          trailing: IconButton(
                            onPressed: () => _onShowQrCodePressed(context),
                            icon: const Icon(Icons.qr_code),
                          ),
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
          );
        },
      ),
    );
  }
}
