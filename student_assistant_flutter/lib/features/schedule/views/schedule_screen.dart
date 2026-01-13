import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/schedule_bloc.dart';
import 'add_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ScheduleBloc();
        _loadData(bloc);
        return bloc;
      },
      child: BlocConsumer<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          if (state is ScheduleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          } else if (state is ScheduleOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thành công'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Thời khóa biểu'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddDialog(context),
                ),
              ],
            ),
            body: Column(
              children: [
                _buildWeekNavigator(context),
                Expanded(
                  child: _buildScheduleList(state, context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _loadData(ScheduleBloc bloc) {
    final startOfWeek = _currentDate.subtract(
      Duration(days: _currentDate.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    bloc.add(LoadWeeklySchedule(startOfWeek, endOfWeek));
  }

  Widget _buildWeekNavigator(BuildContext context) {
    final startOfWeek = _currentDate.subtract(
      Duration(days: _currentDate.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeWeek(context, -1),
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
            onPressed: () => _changeWeek(context, 1),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(ScheduleState state, BuildContext context) {
    if (state is ScheduleLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ScheduleLoaded) {
      if (state.schedules.isEmpty) {
        return const Center(child: Text('Chưa có lịch học tuần này'));
      }

      return RefreshIndicator(
        onRefresh: () async {
          _loadData(context.read<ScheduleBloc>());
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: state.schedules.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = state.schedules[index];
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
                  item.subject?.name ?? 'Môn học #${item.subjectId}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${dayFormat.format(item.startTime)}: ${timeFormat.format(item.startTime)} - ${timeFormat.format(item.endTime)}',
                    ),
                    if (item.room != null) Text('Phòng: ${item.room}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _handleDelete(context, item.id!),
                ),
              ),
            );
          },
        ),
      );
    }

    return const SizedBox();
  }

  void _changeWeek(BuildContext context, int offset) {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 7 * offset));
    });
    _loadData(context.read<ScheduleBloc>());
  }

  void _handleDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa lịch học'),
        content: const Text('Bạn có chắc chắn muốn xóa không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ScheduleBloc>().add(DeleteScheduleItem(id));
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AddScheduleDialog(
        onSubmit: (schedule, repeatWeeks) {
          Navigator.pop(ctx);
          context.read<ScheduleBloc>().add(
            AddNewSchedule(schedule, repeatWeeks),
          );
        },
      ),
    );
  }
}