import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/classroom/create_classroom/create_classroom_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';
import 'package:outclass/views/core/app_router.gr.dart';

@RoutePage()
class CreateClassroomPage extends StatefulWidget implements AutoRouteWrapper {
  const CreateClassroomPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateClassroomCubit>(),
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
  State<CreateClassroomPage> createState() => CreateClassroomPageState();
}

class CreateClassroomPageState extends State<CreateClassroomPage> {
  final _form = GlobalKey<FormState>();

  void _onCreateClassroomPressed() {
    if (_form.currentState?.validate() ?? false) {
      context.read<AuthCubit>().createClassroom(
            context.read<CreateClassroomCubit>().state.dto,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateClassroomCubit>();
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
                  title: const Text('Ayo buat kelas!'),
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
                              'Yuk buat kelas buat kamu sama temen kamu! Kalo bukan kamu siapa lagi, ya kan?',
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: cubit.onClassNameChanged,
                              decoration: const InputDecoration(
                                labelText: 'Nama kelas',
                                icon: Icon(Icons.title_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              autocorrect: false,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.compose([]),
                              onFieldSubmitted: (_) =>
                                  _onCreateClassroomPressed(),
                              onChanged: cubit.onClassDescChanged,
                              decoration: const InputDecoration(
                                labelText: 'Deskripsi kelas',
                                icon: Icon(Icons.notes_rounded),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text('Sekalian lengkapin data kamu yuk!'),
                            const SizedBox(height: 24),
                            TextFormField(
                              autocorrect: false,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.number,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'NIM kamu gak boleh kosong yah.',
                                ),
                              ]),
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
                                onPressed: _onCreateClassroomPressed,
                                child: const Text('CreateClassroom kelas'),
                              ),
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
