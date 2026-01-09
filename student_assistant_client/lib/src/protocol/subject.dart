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

abstract class Subject implements _i1.SerializableModel {
  Subject._({
    this.id,
    required this.name,
    this.teacherName,
    required this.credits,
    required this.requiredAttendance,
    required this.absentCount,
    this.targetScore,
  });

  factory Subject({
    int? id,
    required String name,
    String? teacherName,
    required int credits,
    required int requiredAttendance,
    required int absentCount,
    double? targetScore,
  }) = _SubjectImpl;

  factory Subject.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subject(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      teacherName: jsonSerialization['teacherName'] as String?,
      credits: jsonSerialization['credits'] as int,
      requiredAttendance: jsonSerialization['requiredAttendance'] as int,
      absentCount: jsonSerialization['absentCount'] as int,
      targetScore: (jsonSerialization['targetScore'] as num?)?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? teacherName;

  int credits;

  int requiredAttendance;

  int absentCount;

  double? targetScore;

  /// Returns a shallow copy of this [Subject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subject copyWith({
    int? id,
    String? name,
    String? teacherName,
    int? credits,
    int? requiredAttendance,
    int? absentCount,
    double? targetScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subject',
      if (id != null) 'id': id,
      'name': name,
      if (teacherName != null) 'teacherName': teacherName,
      'credits': credits,
      'requiredAttendance': requiredAttendance,
      'absentCount': absentCount,
      if (targetScore != null) 'targetScore': targetScore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubjectImpl extends Subject {
  _SubjectImpl({
    int? id,
    required String name,
    String? teacherName,
    required int credits,
    required int requiredAttendance,
    required int absentCount,
    double? targetScore,
  }) : super._(
         id: id,
         name: name,
         teacherName: teacherName,
         credits: credits,
         requiredAttendance: requiredAttendance,
         absentCount: absentCount,
         targetScore: targetScore,
       );

  /// Returns a shallow copy of this [Subject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subject copyWith({
    Object? id = _Undefined,
    String? name,
    Object? teacherName = _Undefined,
    int? credits,
    int? requiredAttendance,
    int? absentCount,
    Object? targetScore = _Undefined,
  }) {
    return Subject(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      teacherName: teacherName is String? ? teacherName : this.teacherName,
      credits: credits ?? this.credits,
      requiredAttendance: requiredAttendance ?? this.requiredAttendance,
      absentCount: absentCount ?? this.absentCount,
      targetScore: targetScore is double? ? targetScore : this.targetScore,
    );
  }
}
