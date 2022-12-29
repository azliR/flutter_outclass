import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/classroom_dto.dart';

part 'join_state.dart';

@injectable
class JoinCubit extends Cubit<JoinState> {
  JoinCubit() : super(JoinState.initial());

  void onClassCodeChanged(String classCode) {
    emit(state.copyWith(joinDto: state.joinDto.copyWith(classCode: classCode)));
  }

  void onStudentIdChanged(String studentId) {
    emit(state.copyWith(joinDto: state.joinDto.copyWith(studentId: studentId)));
  }
}
