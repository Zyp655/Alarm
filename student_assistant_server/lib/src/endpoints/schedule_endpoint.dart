import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ScheduleEndpoint extends Endpoint {

  Future<List<Schedule>> getSchedules(Session session, DateTime from,
      DateTime to) async {
    return await Schedule.db.find(
      session,
      where: (t) => t.startTime.between(from, to),
      orderBy: (t) => t.startTime,
      include: Schedule.include(subject: Subject.include()),
    );
  }

  Future<String?> addSchedule(Session session, Schedule schedule,
      int repeatWeeks) async {
    return await session.db.transaction((transaction) async {
      for (int i = 0; i < repeatWeeks; i++) {
        DateTime start = schedule.startTime.add(Duration(days: 7 * i));
        DateTime end = schedule.endTime.add(Duration(days: 7 * i));

        final conflict = await Schedule.db.findFirstRow(
          session,
          where: (t) => (t.startTime < end) & (t.endTime > start),
          transaction: transaction,
        );

        if (conflict != null) {
          return "Trùng lịch vào ngày ${start.toString().substring(
              0, 10)} với môn khác!";
        }

        final newSchedule = schedule.copyWith(
          startTime: start,
          endTime: end,
        );

        await Schedule.db.insertRow(
            session, newSchedule, transaction: transaction);
      }

      return null;
    });
  }

  Future<void> deleteSchedule(Session session, int id) async {
    await Schedule.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}