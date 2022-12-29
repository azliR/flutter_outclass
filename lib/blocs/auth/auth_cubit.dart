import 'package:equatable/equatable.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/classroom_dto.dart';
import 'package:outclass/dtos/sign_in_dto.dart';
import 'package:outclass/dtos/sign_up_dto.dart';
import 'package:outclass/dtos/token_dto.dart';
import 'package:outclass/injectable.dart';
import 'package:outclass/models/auth/token.dart';
import 'package:outclass/models/classroom/classroom_member.dart';
import 'package:outclass/repositories/auth_repository.dart';
import 'package:outclass/repositories/classroom_repository.dart';
import 'package:outclass/repositories/token_repository.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(
    this._authRepository,
    this._classroomRepository,
    this._tokenRepository,
  ) : super(AuthState.initial());

  final AuthRepository _authRepository;
  final ClassroomRepository _classroomRepository;
  final TokenRepository _tokenRepository;

  Future<void> initialSetup() async {
    if (state.token != null) {
      await getIt<Fresh<OAuth2Token>>().setToken(
        _tokenRepository.parseToken(state.token!),
      );
    }
  }

  Future<OAuth2Token?> renewToken({
    required RenewTokenDto renewTokenDto,
  }) async {
    final response =
        await _tokenRepository.renewToken(renewTokenDto: renewTokenDto);

    if (!response.success) {
      emit(state.copyWith(status: AuthStatus.submissionFailure));
      return null;
    }

    final token = response.data!;
    emit(state.copyWith(token: token));
    return _tokenRepository.parseToken(token);
  }

  Future<void> signInWithEmailAndPassword(SignInDto signInDto) async {
    emit(state.copyWith(status: AuthStatus.submissionInProgress));

    final response =
        await _authRepository.signInWithEmailAndPassword(signInDto: signInDto);

    if (!response.success) {
      emit(state.copyWith(status: AuthStatus.submissionFailure));
      return;
    }

    final token = response.data!;
    await _tokenRepository.setToken(token);

    emit(state.copyWith(token: token));

    final responseClassroomMembers =
        await _classroomRepository.getClassroomsByUserId(
      dto: const GetClassroomsByUserIdDto(page: 1, pageLimit: 1),
    );

    if (!responseClassroomMembers.success) {
      emit(state.copyWith(status: AuthStatus.submissionFailure));
      return;
    }

    final classroomMembers = responseClassroomMembers.data!;

    if (classroomMembers.isEmpty) {
      emit(state.copyWith(status: AuthStatus.submissionSuccessWithNoClassroom));
      return;
    }

    final classroomMember = classroomMembers.first;
    emit(
      state.copyWith(
        status: AuthStatus.submissionSuccess,
        classroomMember: classroomMember,
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword(SignUpDto signUpDto) async {
    emit(state.copyWith(status: AuthStatus.submissionInProgress));

    final response =
        await _authRepository.signUpWithEmailAndPassword(signUpDto: signUpDto);

    if (!response.success) {
      emit(state.copyWith(status: AuthStatus.submissionFailure));
      return;
    }

    final token = response.data!.token;
    await _tokenRepository.setToken(token);

    emit(
      state.copyWith(
        token: token,
        status: AuthStatus.submissionSuccessWithNoClassroom,
      ),
    );
  }

  Future<void> joinClassroom(JoinClassroomDto dto) async {
    emit(state.copyWith(status: AuthStatus.submissionInProgress));

    final joinResponse = await _classroomRepository.joinClassroom(dto: dto);
    if (!joinResponse.success) {
      emit(state.copyWith(status: AuthStatus.submissionFailure));
      return;
    }

    final classroomMember = joinResponse.data!;
    emit(
      state.copyWith(
        status: AuthStatus.submissionSuccess,
        classroomMember: classroomMember,
      ),
    );
  }

  Future<void> signOut() async {
    // await _tokenRepository.deleteToken();
    // emit(state.copyWith(
    //   token: null,
    //   classroom: null,
    // ));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
