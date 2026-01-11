import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../service/schedule_service.dart';
import 'add_schedule_screen.dart';
import 'package:student_assistant_client/student_assistant_client.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _scheduleService = ScheduleService();
  List<Schedule>? _schedules;
  bool _isLoading = false;
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await _scheduleService.getSchedules(_currentDate);
      setState(() => _schedules = data);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleAdd(Schedule schedule, int repeatWeeks) async {
    try {
      final errorMsg = await _scheduleService.addSchedule(
        schedule,
        repeatWeeks,
      );

      if (!mounted) return;

      if (errorMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
        );
      } else {
        Navigator.pop(context);
        _loadData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm lịch thành công')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  Future<void> _handleDelete(int id) async {
    try {
      await _scheduleService.deleteSchedule(id);
      _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  void _changeWeek(int offset) {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 7 * offset));
    });
    _loadData();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AddScheduleDialog(
        onSubmit: _handleAdd,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final startOfWeek = _currentDate.subtract(
      Duration(days: _currentDate.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thời khóa biểu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => _changeWeek(-1),
                ),
                Text(
                  '${dateFormat.format(startOfWeek)} - ${dateFormat.format(endOfWeek)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => _changeWeek(1),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _schedules == null || _schedules!.isEmpty
                ? const Center(child: Text('Chưa có lịch học tuần này'))
                : RefreshIndicator(
                    onRefresh: _loadData,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: _schedules!.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = _schedules![index];
                        final timeFormat = DateFormat('HH:mm');
                        final dayFormat = DateFormat('EEEE', 'vi_VN');

                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                dayFormat
                                    .format(item.startTime)
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              item.subject?.name ??
                                  'Môn học #${item.subjectId}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${dayFormat.format(item.startTime)}: ${timeFormat.format(item.startTime)} - ${timeFormat.format(item.endTime)}',
                                ),
                                if (item.room != null)
                                  Text('Phòng: ${item.room}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _handleDelete(item.id!),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
