import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_assistant_client/student_assistant_client.dart';
import '../../../main.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitial()) {


    on<LoadSubjects>((event, emit) async {
      emit(SubjectLoading());
      try {
        final results = await client.subject.getSubjects();
        emit(SubjectLoaded(results));
      } catch (e) {
        emit(SubjectError("Lỗi kết nối: $e"));
      }
    });

    on<CreateSubject>((event, emit) async {
      try {
        await client.subject.addSubject(event.subject);
        add(LoadSubjects());
      } catch (e) {
        emit(SubjectError("Không thể thêm môn học"));
      }
    });
  }
}