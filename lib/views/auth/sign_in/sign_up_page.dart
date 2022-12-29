import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:outclass/blocs/auth/auth_cubit.dart';
import 'package:outclass/blocs/auth/sign_up/sign_up_cubit.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/views/auth/sign_in/widgets/progress_overlay.dart';

class SignUpPage extends StatefulWidget implements AutoRouteWrapper {
  const SignUpPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpCubit>(),
      child: this,
    );
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _form = GlobalKey<FormState>();

  void _onSignUpWithEmailAndPasswordPressed() {
    if (_form.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signUpWithEmailAndPassword(
            context.read<SignUpCubit>().state.signUpDto,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
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
                  title: const Text('Buat akun sekarang!'),
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
                              'Buat akunnya gampang banget, kamu cuman perlu masukin data di bawah, langsung cuss bisa nikmatin semua fitur di OutClass!',
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Namanya gak boleh kosong yah.',
                                ),
                              ]),
                              onChanged: cubit.onNameChanged,
                              decoration: const InputDecoration(
                                labelText: 'Nama lengkap',
                                icon: Icon(Icons.person_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Emailnya gak boleh kosong yah.',
                                ),
                                FormBuilderValidators.email(
                                  errorText: 'Emailnya kamu enggak valid.',
                                ),
                              ]),
                              onChanged: cubit.onEmailChanged,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.mail_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            BlocSelector<SignUpCubit, SignUpState, bool>(
                              selector: (state) => state.showPassword,
                              builder: (context, showPassword) {
                                return TextFormField(
                                  obscureText: !showPassword,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.next,
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
                                  onChanged: cubit.onPasswordChanged,
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
                                      onPressed: cubit.toggleShowPassword,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            BlocSelector<SignUpCubit, SignUpState, bool>(
                              selector: (state) => state.showPassword,
                              builder: (context, showPassword) {
                                return TextFormField(
                                  obscureText: !showPassword,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.go,
                                  validator: (value) {
                                    if (value !=
                                        cubit.state.signUpDto.password) {
                                      return 'Passwordnya gak sama.';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) =>
                                      _onSignUpWithEmailAndPasswordPressed(),
                                  onChanged: cubit.onConfirmPasswordChanged,
                                  decoration: InputDecoration(
                                    labelText: 'Konfirmasi password',
                                    icon: const SizedBox(width: 24),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        showPassword
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                      ),
                                      tooltip: showPassword
                                          ? 'Hide password'
                                          : 'Show password',
                                      onPressed: cubit.toggleShowPassword,
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
                                onPressed: _onSignUpWithEmailAndPasswordPressed,
                                child: const Text('Buat akun'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => context.router.pop(),
                                child: const Text('Aku udah punya akun'),
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
