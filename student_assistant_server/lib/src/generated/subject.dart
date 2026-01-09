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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Subject
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = SubjectTable();

  static const db = SubjectRepository._();

  @override
  int? id;

  String name;

  String? teacherName;

  int credits;

  int requiredAttendance;

  int absentCount;

  double? targetScore;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static SubjectInclude include() {
    return SubjectInclude._();
  }

  static SubjectIncludeList includeList({
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    SubjectInclude? include,
  }) {
    return SubjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subject.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Subject.t),
      include: include,
    );
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

class SubjectUpdateTable extends _i1.UpdateTable<SubjectTable> {
  SubjectUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> teacherName(String? value) => _i1.ColumnValue(
    table.teacherName,
    value,
  );

  _i1.ColumnValue<int, int> credits(int value) => _i1.ColumnValue(
    table.credits,
    value,
  );

  _i1.ColumnValue<int, int> requiredAttendance(int value) => _i1.ColumnValue(
    table.requiredAttendance,
    value,
  );

  _i1.ColumnValue<int, int> absentCount(int value) => _i1.ColumnValue(
    table.absentCount,
    value,
  );

  _i1.ColumnValue<double, double> targetScore(double? value) => _i1.ColumnValue(
    table.targetScore,
    value,
  );
}

class SubjectTable extends _i1.Table<int?> {
  SubjectTable({super.tableRelation}) : super(tableName: 'subject') {
    updateTable = SubjectUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    teacherName = _i1.ColumnString(
      'teacherName',
      this,
    );
    credits = _i1.ColumnInt(
      'credits',
      this,
    );
    requiredAttendance = _i1.ColumnInt(
      'requiredAttendance',
      this,
    );
    absentCount = _i1.ColumnInt(
      'absentCount',
      this,
    );
    targetScore = _i1.ColumnDouble(
      'targetScore',
      this,
    );
  }

  late final SubjectUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString teacherName;

  late final _i1.ColumnInt credits;

  late final _i1.ColumnInt requiredAttendance;

  late final _i1.ColumnInt absentCount;

  late final _i1.ColumnDouble targetScore;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    teacherName,
    credits,
    requiredAttendance,
    absentCount,
    targetScore,
  ];
}

class SubjectInclude extends _i1.IncludeObject {
  SubjectInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Subject.t;
}

class SubjectIncludeList extends _i1.IncludeList {
  SubjectIncludeList._({
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Subject.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Subject.t;
}

class SubjectRepository {
  const SubjectRepository._();

  /// Returns a list of [Subject]s matching the given query parameters.
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
  Future<List<Subject>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Subject>(
      where: where?.call(Subject.t),
      orderBy: orderBy?.call(Subject.t),
      orderByList: orderByList?.call(Subject.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Subject] matching the given query parameters.
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
  Future<Subject?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Subject>(
      where: where?.call(Subject.t),
      orderBy: orderBy?.call(Subject.t),
      orderByList: orderByList?.call(Subject.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Subject] by its [id] or null if no such row exists.
  Future<Subject?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Subject>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Subject]s in the list and returns the inserted rows.
  ///
  /// The returned [Subject]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Subject>> insert(
    _i1.Session session,
    List<Subject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Subject>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Subject] and returns the inserted row.
  ///
  /// The returned [Subject] will have its `id` field set.
  Future<Subject> insertRow(
    _i1.Session session,
    Subject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Subject>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Subject]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Subject>> update(
    _i1.Session session,
    List<Subject> rows, {
    _i1.ColumnSelections<SubjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Subject>(
      rows,
      columns: columns?.call(Subject.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subject]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Subject> updateRow(
    _i1.Session session,
    Subject row, {
    _i1.ColumnSelections<SubjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Subject>(
      row,
      columns: columns?.call(Subject.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subject] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Subject?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SubjectUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Subject>(
      id,
      columnValues: columnValues(Subject.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Subject]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Subject>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SubjectUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubjectTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubjectTable>? orderBy,
    _i1.OrderByListBuilder<SubjectTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Subject>(
      columnValues: columnValues(Subject.t.updateTable),
      where: where(Subject.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subject.t),
      orderByList: orderByList?.call(Subject.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Subject]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Subject>> delete(
    _i1.Session session,
    List<Subject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Subject>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Subject].
  Future<Subject> deleteRow(
    _i1.Session session,
    Subject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Subject>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Subject>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubjectTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Subject>(
      where: where(Subject.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubjectTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Subject>(
      where: where?.call(Subject.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
