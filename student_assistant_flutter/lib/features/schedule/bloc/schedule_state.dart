part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}
class ScheduleLoading extends ScheduleState {}
class ScheduleOperationSuccess extends ScheduleState {}
class ScheduleLoaded extends ScheduleState {
  final List<Schedule> schedules;
  ScheduleLoaded(this.schedules);
}
class ScheduleError extends ScheduleState {
  final String message;
  ScheduleError(this.message);
}