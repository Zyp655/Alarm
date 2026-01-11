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
    double progress =
        _currentSubject.absentCount / _currentSubject.requiredAttendance;

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentSubject.name),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tín chỉ: ${_currentSubject.credits}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "GV: ${_currentSubject.teacherName ?? 'Chưa rõ'}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Tình trạng chuyên cần",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progress > 1 ? 1 : progress,
                      color: isDanger ? Colors.red : Colors.green,
                      backgroundColor: Colors.grey[300],
                      minHeight: 10,
                    ),
                    SizedBox(height: 10),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "CẢNH BÁO: Bạn đã nghỉ quá số buổi!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),
            Center(
              child: Text(
                "Cập nhật nhanh",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentSubject.absentCount > 0
                      ? () => _updateAbsence(-1)
                      : null,
                  icon: Icon(Icons.remove),
                  label: Text("Giảm nghỉ"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _updateAbsence(1),
                  icon: Icon(Icons.add),
                  label: Text("Vắng học hôm nay"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
    setState(() {
      _currentSubject.absentCount += change;
    });
    context.read<SubjectBloc>().add(UpdateSubject(_currentSubject));
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Xác nhận xóa"),
        content: Text("Bạn có chắc muốn xóa môn ${_currentSubject.name}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Hủy")),
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
            child: Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
