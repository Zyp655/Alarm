import 'package:student_assistant_client/student_assistant_client.dart';
import '../../../main.dart';

class ScheduleService {
  Future<List<Schedule>> getSchedules(DateTime date) async {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return await client.schedule.getSchedules(startOfWeek, endOfWeek);
  }

  Future<String?> addSchedule(Schedule schedule, int repeatWeeks) async {
    return await client.schedule.addSchedule(schedule, repeatWeeks);
  }

  Future<void> deleteSchedule(int id) async {
    await client.schedule.deleteSchedule(id);
  }
}
