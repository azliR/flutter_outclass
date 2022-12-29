import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/classroom/join/join_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';
import 'package:outclass/views/core/app_router.dart';

class JoinPage extends StatefulWidget implements AutoRouteWrapper {
  const JoinPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<JoinCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.submissionSuccess) {
            context.router.pushAndPopUntil(
              const HomeWrapperRoute(),
              predicate: (_) => false,
            );
          } else if (state.status ==
              AuthStatus.submissionSuccessWithNoClassroom) {
            context.router.pushAndPopUntil(
              const JoinRoute(),
              predicate: (_) => false,
            );
          } else if (state.status == AuthStatus.submissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gagal masuk'),
              ),
            );
          }
        },
        child: this,
      ),
    );
  }

  @override
  State<JoinPage> createState() => JoinPageState();
}

class JoinPageState extends State<JoinPage> {
  final _form = GlobalKey<FormState>();

  void _onJoinPressed() {
    if (_form.currentState?.validate() ?? false) {
      context.read<AuthCubit>().joinClassroom(
            context.read<JoinCubit>().state.joinDto,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<JoinCubit>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      body: BlocSelector<AuthCubit, AuthState, AuthStatus>(
        selector: (state) => state.status,
        builder: (context, state) {
          return ProgressOverlay(
            visible: state == AuthStatus.submissionInProgress,
            child: CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  backgroundColor: colorScheme.primaryContainer,
                  elevation: 0,
                  expandedHeight: 200,
                  title: const Text('Ayo join!'),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masukin kode kelas kamu di bawah (psst, tanyain kodenya ke temen kamu)',
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.equalLength(
                                  16,
                                  errorText: 'Kode kelas kamu enggak valid.',
                                ),
                              ]),
                              onChanged: cubit.onClassCodeChanged,
                              decoration: const InputDecoration(
                                labelText: 'Kode kelas',
                                icon: Icon(Icons.pin_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              autocorrect: false,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.number,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'NIM kamu gak boleh kosong yah.',
                                ),
                              ]),
                              onFieldSubmitted: (_) => _onJoinPressed(),
                              onChanged: cubit.onStudentIdChanged,
                              decoration: const InputDecoration(
                                labelText: 'NIM (Nomor Induk Mahasiswa)',
                                icon: Icon(Icons.badge_rounded),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: colorScheme.onPrimary,
                                  backgroundColor: colorScheme.primary,
                                ).copyWith(
                                  elevation: ButtonStyleButton.allOrNull(0),
                                ),
                                onPressed: _onJoinPressed,
                                child: const Text('Join kelas'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () =>
                                    context.router.push(const SignUpRoute()),
                                child: const Text('Buat kelas'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Center(
                              child: Text('Kamu males ngetik?'),
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: colorScheme.onPrimary,
                                  backgroundColor: colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  textStyle: textTheme.titleMedium,
                                ).copyWith(
                                  elevation: ButtonStyleButton.allOrNull(0),
                                ),
                                onPressed: () => {},
                                icon: const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  size: 28,
                                ),
                                label: const Text('Scan QR'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Salah akun?'),
                                TextButton(
                                  onPressed: () =>
                                      context.router.push(const SignInRoute()),
                                  child: const Text('Masuk lagi'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: ColoredBox(
                    color: colorScheme.background,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
