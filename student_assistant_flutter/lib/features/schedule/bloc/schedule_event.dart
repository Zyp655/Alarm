part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWeeklySchedule extends ScheduleEvent {
  final DateTime fromDate;
  final DateTime toDate;
  LoadWeeklySchedule(this.fromDate, this.toDate);
}

class AddNewSchedule extends ScheduleEvent {
  final Schedule schedule;
  final int repeatWeeks;
  AddNewSchedule(this.schedule, this.repeatWeeks);
}

class DeleteScheduleItem extends ScheduleEvent {
  final int id;
  DeleteScheduleItem(this.id);
}