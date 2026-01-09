part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSubjects extends SubjectEvent {}

class CreateSubject extends SubjectEvent {
  final Subject subject;
  CreateSubject(this.subject);
}