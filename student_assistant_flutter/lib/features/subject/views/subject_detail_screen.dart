import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant_client/student_assistant_client.dart';
import '../bloc/subject_bloc.dart';

class SubjectDetailScreen extends StatefulWidget {
  final Subject subject;

  const SubjectDetailScreen({super.key, required this.subject});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  late Subject _currentSubject;

  @override
  void initState() {
    super.initState();
    _currentSubject = widget.subject;
  }

  @override
  Widget build(BuildContext context) {
    bool isDanger =
        _currentSubject.absentCount >= _currentSubject.requiredAttendance;

    double progress = 0.0;
    if (_currentSubject.requiredAttendance > 0) {
      progress =
          _currentSubject.absentCount / _currentSubject.requiredAttendance;
      if (progress > 1.0) progress = 1.0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentSubject.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tín chỉ: ${_currentSubject.credits}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "GV: ${_currentSubject.teacherName ?? 'Chưa rõ'}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Tình trạng chuyên cần",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LinearProgressIndicator(
                        value: progress,
                        color: isDanger ? Colors.red : Colors.green,
                        backgroundColor: Colors.grey[300],
                        minHeight: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Đã nghỉ: ${_currentSubject.absentCount} / ${_currentSubject.requiredAttendance} buổi",
                      style: TextStyle(
                        fontSize: 16,
                        color: isDanger ? Colors.red : Colors.black,
                        fontWeight: isDanger
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    if (isDanger)
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              "CẢNH BÁO: Quá số buổi nghỉ!",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Cập nhật nhanh",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentSubject.absentCount > 0
                      ? () => _updateAbsence(-1)
                      : null,
                  icon: const Icon(Icons.remove, color: Colors.white),
                  label: const Text(
                    "Giảm",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _updateAbsence(1),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Vắng hôm nay",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateAbsence(int change) {
    final newCount = _currentSubject.absentCount + change;

    final updatedSubject = _currentSubject.copyWith(
      absentCount: newCount,
    );

    setState(() {
      _currentSubject = updatedSubject;
    });

    context.read<SubjectBloc>().add(UpdateSubject(updatedSubject));
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: Text("Bạn có chắc muốn xóa môn ${_currentSubject.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              if (_currentSubject.id != null) {
                context.read<SubjectBloc>().add(
                  DeleteSubject(_currentSubject.id!),
                );
              }
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
