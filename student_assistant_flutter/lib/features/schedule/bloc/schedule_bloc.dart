import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_assistant_client/student_assistant_client.dart';
import '../../../main.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {

    on<LoadWeeklySchedule>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final results = await client.schedule.getSchedules(event.fromDate, event.toDate);
        emit(ScheduleLoaded(results));
      } catch (e) {
        emit(ScheduleError("Lỗi tải lịch: $e"));
      }
    });

    on<AddNewSchedule>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final errorMsg = await client.schedule.addSchedule(event.schedule, event.repeatWeeks);
        if(errorMsg == null){
          emit(ScheduleOperationSuccess());
        }else{
          emit(ScheduleError(errorMsg));
        }
      } catch (e) {
        emit(ScheduleError("Lỗi hệ thống: $e"));
      }
    });

    on<DeleteScheduleItem>((event, emit) async {
      try {
        await client.schedule.deleteSchedule(event.id);
      } catch (e) {
        emit(ScheduleError("Lỗi xóa: $e"));
      }
    });
  }
}