import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/auth/sign_in/sign_in_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';
import 'package:outclass/views/core/app_router.dart';

class SignInPage extends StatefulWidget implements AutoRouteWrapper {
  const SignInPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
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
              const HomeWrapperRoute(),
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
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _form = GlobalKey<FormState>();

  void _onSignInWithEmailAndPasswordPressed() {
    if (_form.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signInWithEmailAndPassword(
            context.read<SignInCubit>().state.signInDto,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  title: const Text('Masuk dulu yuk'),
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
                              'Sebelum masuk kelas, masuk dulu pake akun kamu biar datanya bisa dibuka di semua perangkat kamu',
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.go,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Emailnya gak boleh kosong yah.',
                                ),
                                FormBuilderValidators.email(
                                  errorText: 'Emailnya kamu enggak valid.',
                                ),
                              ]),
                              onChanged: (value) => context
                                  .read<SignInCubit>()
                                  .onEmailChanged(value),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.mail_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            BlocSelector<SignInCubit, SignInState, bool>(
                              selector: (state) {
                                return state.showPassword;
                              },
                              builder: (context, showPassword) {
                                return TextFormField(
                                  obscureText: !showPassword,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.go,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText:
                                          'Passwordnya gak boleh kosong yah.',
                                    ),
                                    FormBuilderValidators.minLength(
                                      8,
                                      errorText:
                                          'Passwordnya minimal 8 karakter yah.',
                                    ),
                                  ]),
                                  onFieldSubmitted: (_) =>
                                      _onSignInWithEmailAndPasswordPressed(),
                                  onChanged: (value) => context
                                      .read<SignInCubit>()
                                      .onPasswordChanged(value),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    icon: const Icon(Icons.lock_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        showPassword
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                      ),
                                      tooltip: showPassword
                                          ? 'Hide password'
                                          : 'Show password',
                                      onPressed: () => context
                                          .read<SignInCubit>()
                                          .toggleShowPassword(),
                                    ),
                                  ),
                                );
                              },
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
                                onPressed: _onSignInWithEmailAndPasswordPressed,
                                child: const Text('Masuk sekarang'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Aku belum punya akun'),
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
