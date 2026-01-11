/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'subject.dart' as _i2;
import 'package:student_assistant_server/src/generated/protocol.dart' as _i3;

abstract class Schedule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ScheduleTable();

  static const db = ScheduleRepository._();

  @override
  int? id;

  int subjectId;

  _i2.Subject? subject;

  DateTime startTime;

  DateTime endTime;

  String? room;

  String? description;

  bool isExam;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Schedule',
      if (id != null) 'id': id,
      'subjectId': subjectId,
      if (subject != null) 'subject': subject?.toJsonForProtocol(),
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      if (room != null) 'room': room,
      if (description != null) 'description': description,
      'isExam': isExam,
    };
  }

  static ScheduleInclude include({_i2.SubjectInclude? subject}) {
    return ScheduleInclude._(subject: subject);
  }

  static ScheduleIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    ScheduleInclude? include,
  }) {
    return ScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Schedule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Schedule.t),
      include: include,
    );
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

class ScheduleUpdateTable extends _i1.UpdateTable<ScheduleTable> {
  ScheduleUpdateTable(super.table);

  _i1.ColumnValue<int, int> subjectId(int value) => _i1.ColumnValue(
    table.subjectId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startTime(DateTime value) =>
      _i1.ColumnValue(
        table.startTime,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endTime(DateTime value) =>
      _i1.ColumnValue(
        table.endTime,
        value,
      );

  _i1.ColumnValue<String, String> room(String? value) => _i1.ColumnValue(
    table.room,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<bool, bool> isExam(bool value) => _i1.ColumnValue(
    table.isExam,
    value,
  );
}

class ScheduleTable extends _i1.Table<int?> {
  ScheduleTable({super.tableRelation}) : super(tableName: 'schedule') {
    updateTable = ScheduleUpdateTable(this);
    subjectId = _i1.ColumnInt(
      'subjectId',
      this,
    );
    startTime = _i1.ColumnDateTime(
      'startTime',
      this,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
      this,
    );
    room = _i1.ColumnString(
      'room',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    isExam = _i1.ColumnBool(
      'isExam',
      this,
    );
  }

  late final ScheduleUpdateTable updateTable;

  late final _i1.ColumnInt subjectId;

  _i2.SubjectTable? _subject;

  late final _i1.ColumnDateTime startTime;

  late final _i1.ColumnDateTime endTime;

  late final _i1.ColumnString room;

  late final _i1.ColumnString description;

  late final _i1.ColumnBool isExam;

  _i2.SubjectTable get subject {
    if (_subject != null) return _subject!;
    _subject = _i1.createRelationTable(
      relationFieldName: 'subject',
      field: Schedule.t.subjectId,
      foreignField: _i2.Subject.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SubjectTable(tableRelation: foreignTableRelation),
    );
    return _subject!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    subjectId,
    startTime,
    endTime,
    room,
    description,
    isExam,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'subject') {
      return subject;
    }
    return null;
  }
}

class ScheduleInclude extends _i1.IncludeObject {
  ScheduleInclude._({_i2.SubjectInclude? subject}) {
    _subject = subject;
  }

  _i2.SubjectInclude? _subject;

  @override
  Map<String, _i1.Include?> get includes => {'subject': _subject};

  @override
  _i1.Table<int?> get table => Schedule.t;
}

class ScheduleIncludeList extends _i1.IncludeList {
  ScheduleIncludeList._({
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Schedule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Schedule.t;
}

class ScheduleRepository {
  const ScheduleRepository._();

  final attachRow = const ScheduleAttachRowRepository._();

  /// Returns a list of [Schedule]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Schedule>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduleInclude? include,
  }) async {
    return session.db.find<Schedule>(
      where: where?.call(Schedule.t),
      orderBy: orderBy?.call(Schedule.t),
      orderByList: orderByList?.call(Schedule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Schedule] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Schedule?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduleInclude? include,
  }) async {
    return session.db.findFirstRow<Schedule>(
      where: where?.call(Schedule.t),
      orderBy: orderBy?.call(Schedule.t),
      orderByList: orderByList?.call(Schedule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Schedule] by its [id] or null if no such row exists.
  Future<Schedule?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ScheduleInclude? include,
  }) async {
    return session.db.findById<Schedule>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Schedule]s in the list and returns the inserted rows.
  ///
  /// The returned [Schedule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Schedule>> insert(
    _i1.Session session,
    List<Schedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Schedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Schedule] and returns the inserted row.
  ///
  /// The returned [Schedule] will have its `id` field set.
  Future<Schedule> insertRow(
    _i1.Session session,
    Schedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Schedule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Schedule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Schedule>> update(
    _i1.Session session,
    List<Schedule> rows, {
    _i1.ColumnSelections<ScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Schedule>(
      rows,
      columns: columns?.call(Schedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Schedule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Schedule> updateRow(
    _i1.Session session,
    Schedule row, {
    _i1.ColumnSelections<ScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Schedule>(
      row,
      columns: columns?.call(Schedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Schedule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Schedule?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ScheduleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Schedule>(
      id,
      columnValues: columnValues(Schedule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Schedule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Schedule>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ScheduleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ScheduleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Schedule>(
      columnValues: columnValues(Schedule.t.updateTable),
      where: where(Schedule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Schedule.t),
      orderByList: orderByList?.call(Schedule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Schedule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Schedule>> delete(
    _i1.Session session,
    List<Schedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Schedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Schedule].
  Future<Schedule> deleteRow(
    _i1.Session session,
    Schedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Schedule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Schedule>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScheduleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Schedule>(
      where: where(Schedule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Schedule>(
      where: where?.call(Schedule.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ScheduleAttachRowRepository {
  const ScheduleAttachRowRepository._();

  /// Creates a relation between the given [Schedule] and [Subject]
  /// by setting the [Schedule]'s foreign key `subjectId` to refer to the [Subject].
  Future<void> subject(
    _i1.Session session,
    Schedule schedule,
    _i2.Subject subject, {
    _i1.Transaction? transaction,
  }) async {
    if (schedule.id == null) {
      throw ArgumentError.notNull('schedule.id');
    }
    if (subject.id == null) {
      throw ArgumentError.notNull('subject.id');
    }

    var $schedule = schedule.copyWith(subjectId: subject.id);
    await session.db.updateRow<Schedule>(
      $schedule,
      columns: [Schedule.t.subjectId],
      transaction: transaction,
    );
  }
}
