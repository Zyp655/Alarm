/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'subject.dart' as _i2;
import 'package:student_assistant_client/src/protocol/protocol.dart' as _i3;

abstract class Schedule implements _i1.SerializableModel {
  Schedule._({
    this.id,
    required this.subjectId,
    this.subject,
    required this.startTime,
    required this.endTime,
    this.room,
    this.description,
    required this.isExam,
  });

  factory Schedule({
    int? id,
    required int subjectId,
    _i2.Subject? subject,
    required DateTime startTime,
    required DateTime endTime,
    String? room,
    String? description,
    required bool isExam,
  }) = _ScheduleImpl;

  factory Schedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return Schedule(
      id: jsonSerialization['id'] as int?,
      subjectId: jsonSerialization['subjectId'] as int,
      subject: jsonSerialization['subject'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Subject>(
              jsonSerialization['subject'],
            ),
      startTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startTime'],
      ),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      room: jsonSerialization['room'] as String?,
      description: jsonSerialization['description'] as String?,
      isExam: jsonSerialization['isExam'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int subjectId;

  _i2.Subject? subject;

  DateTime startTime;

  DateTime endTime;

  String? room;

  String? description;

  bool isExam;

  /// Returns a shallow copy of this [Schedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Schedule copyWith({
    int? id,
    int? subjectId,
    _i2.Subject? subject,
    DateTime? startTime,
    DateTime? endTime,
    String? room,
    String? description,
    bool? isExam,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Schedule',
      if (id != null) 'id': id,
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJson(),
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      if (room != null) 'room': room,
      if (description != null) 'description': description,
      'isExam': isExam,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduleImpl extends Schedule {
  _ScheduleImpl({
    int? id,
    required int subjectId,
    _i2.Subject? subject,
    required DateTime startTime,
    required DateTime endTime,
    String? room,
    String? description,
    required bool isExam,
  }) : super._(
         id: id,
         subjectId: subjectId,
         subject: subject,
         startTime: startTime,
         endTime: endTime,
         room: room,
         description: description,
         isExam: isExam,
       );

  /// Returns a shallow copy of this [Schedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Schedule copyWith({
    Object? id = _Undefined,
    int? subjectId,
    Object? subject = _Undefined,
    DateTime? startTime,
    DateTime? endTime,
    Object? room = _Undefined,
    Object? description = _Undefined,
    bool? isExam,
  }) {
    return Schedule(
      id: id is int? ? id : this.id,
      subjectId: subjectId ?? this.subjectId,
      subject: subject is _i2.Subject? ? subject : this.subject?.copyWith(),
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      room: room is String? ? room : this.room,
      description: description is String? ? description : this.description,
      isExam: isExam ?? this.isExam,
    );
  }
}
