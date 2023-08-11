import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/dtos/classroom_dto.dart';

part 'create_classroom_state.dart';

@injectable
class CreateClassroomCubit extends Cubit<CreateClassroomState> {
  CreateClassroomCubit() : super(CreateClassroomState.initial());

  void onClassNameChanged(String className) {
    emit(state.copyWith(
      dto: state.dto.copyWith(className: className),
    ));
  }

  void onClassDescChanged(String classDesc) {
    emit(state.copyWith(
      dto: state.dto.copyWith(classDesc: classDesc),
    ));
  }

  void onStudentIdChanged(String studentId) {
    emit(state.copyWith(
      dto: state.dto.copyWith(studentId: studentId),
    ));
  }
}
