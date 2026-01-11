import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_assistant_client/student_assistant_client.dart';

class AddScheduleDialog extends StatefulWidget {
  final Function(Schedule, int) onSubmit;

  const AddScheduleDialog({super.key, required this.onSubmit});

  @override
  State<AddScheduleDialog> createState() => _AddScheduleDialogState();
}

class _AddScheduleDialogState extends State<AddScheduleDialog> {
  final _formKey = GlobalKey<FormState>();

  int? _subjectId;
  String? _room;
  String? _description;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 9, minute: 0);
  int _repeatWeeks = 1;
  bool _isExam = false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart)
          _startTime = picked;
        else
          _endTime = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final startDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _startTime.hour,
        _startTime.minute,
      );

      final endDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _endTime.hour,
        _endTime.minute,
      );

      if (endDateTime.isBefore(startDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Giờ kết thúc phải sau giờ bắt đầu')),
        );
        return;
      }

      final schedule = Schedule(
        subjectId: _subjectId ?? 1,
        startTime: startDateTime,
        endTime: endDateTime,
        room: _room,
        description: _description,
        isExam: _isExam,
      );

      widget.onSubmit(schedule, _repeatWeeks);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return AlertDialog(
      title: const Text('Thêm Lịch Học'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mã Môn Học (ID)'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Nhập ID môn học' : null,
                onSaved: (v) => _subjectId = int.tryParse(v!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phòng học'),
                onSaved: (v) => _room = v,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Ngày: ${dateFormat.format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Chọn'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Bắt đầu: ${_startTime.format(context)}'),
                  ),
                  TextButton(
                    onPressed: () => _pickTime(true),
                    child: const Text('Sửa'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Kết thúc: ${_endTime.format(context)}'),
                  ),
                  TextButton(
                    onPressed: () => _pickTime(false),
                    child: const Text('Sửa'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: '1',
                decoration: const InputDecoration(
                  labelText: 'Lặp lại (số tuần)',
                  helperText: 'Nhập 1 nếu chỉ học 1 buổi',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final val = int.tryParse(v ?? '');
                  if (val == null || val < 1) return 'Ít nhất 1 tuần';
                  return null;
                },
                onSaved: (v) => _repeatWeeks = int.parse(v!),
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
          onPressed: _submit,
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
