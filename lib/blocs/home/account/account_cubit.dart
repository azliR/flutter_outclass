import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/models/classroom/classroom_member_profile.dart';
import 'package:outclass/repositories/classroom_member_repository.dart';

part 'account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._classroomMemberRepository) : super(AccountState.initial());

  final ClassroomMemberRepository _classroomMemberRepository;

  Future<void> getClassroomMemberProfile({required String classroomId}) async {
    emit(state.copyWith(status: FetchProfileStatus.inProgress));

    final responseClassroomMemberProfile =
        await _classroomMemberRepository.getClassroomMemberProfile(
      classroomId: classroomId,
    );

    if (!responseClassroomMemberProfile.success) {
      emit(state.copyWith(status: FetchProfileStatus.failed));
      return;
    }

    emit(
      state.copyWith(
        profile: responseClassroomMemberProfile.data,
        status: FetchProfileStatus.succeeded,
      ),
    );
  }
}
