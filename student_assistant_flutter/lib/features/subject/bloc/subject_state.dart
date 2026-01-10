part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  @override
  List<Object> get props => [];
}

class SubjectInitial extends SubjectState {}
class SubjectLoading extends SubjectState {}

class SubjectLoaded extends SubjectState {
  final List<Subject> subjects;
  SubjectLoaded(this.subjects);
}
class SubjectError extends SubjectState {
  final String message;
  SubjectError(this.message);
}