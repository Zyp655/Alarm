import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_assistant_client/student_assistant_client.dart';

class AddScheduleDialog extends StatefulWidget {
  final Function(Schedule schedule, int repeatWeeks) onSubmit;

  const AddScheduleDialog({super.key, required this.onSubmit});

  @override
  State<AddScheduleDialog> createState() => _AddScheduleDialogState();
}

class _AddScheduleDialogState extends State<AddScheduleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _roomController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 9, minute: 0);
  int _repeatWeeks = 1;

  @override
  void dispose() {
    _subjectController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return AlertDialog(
      title: const Text('Thêm lịch học'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Tên môn học',
                  icon: Icon(Icons.book),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên môn';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(
                  labelText: 'Phòng học',
                  icon: Icon(Icons.room),
                ),
              ),
              const SizedBox(height: 16),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text('Ngày: ${dateFormat.format(_selectedDate)}'),
                onTap: _pickDate,
              ),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickTime(true),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Bắt đầu',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8,
                              vertical: 4),
                        ),
                        child: Text(
                          _startTime.format(context),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickTime(false),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Kết thúc',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8,
                              vertical: 4),
                        ),
                        child: Text(
                          _endTime.format(context),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<int>(
                initialValue: _repeatWeeks,
                decoration: const InputDecoration(
                  labelText: 'Lặp lại',
                  icon: Icon(Icons.repeat),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Chỉ tuần này')),
                  DropdownMenuItem(value: 2, child: Text('2 tuần')),
                  DropdownMenuItem(value: 4, child: Text('4 tuần')),
                  DropdownMenuItem(value: 5, child: Text('5 tuần')),
                  DropdownMenuItem(value: 8, child: Text('8 tuần')),
                  DropdownMenuItem(value: 10, child: Text('10 tuần')),
                  DropdownMenuItem(value: 15, child: Text('15 tuần')),
                ],
                onChanged: (val) => setState(() => _repeatWeeks = val!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _onSave,
          child: const Text('Lưu'),
        ),
      ],
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final start = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _startTime.hour,
        _startTime.minute,
      );

      final end = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _endTime.hour,
        _endTime.minute,
      );

      if (end.isBefore(start)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Giờ kết thúc phải sau giờ bắt đầu')),
        );
        return;
      }

      final schedule = Schedule(
        startTime: start,
        endTime: end,
        room: _roomController.text.isNotEmpty ? _roomController.text : null,
        subjectId: 0,
        isExam: false,
        subject: Subject(
          name: _subjectController.text,
          credits: 3,
          requiredAttendance: 0,
          absentCount: 0,
          teacherName: '',
        ),
      );
      widget.onSubmit(schedule, _repeatWeeks);
    }
  }
}