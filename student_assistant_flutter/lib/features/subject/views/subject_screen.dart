import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant_client/student_assistant_client.dart';
import 'package:student_assistant_flutter/features/subject/views/subject_detail_screen.dart';
import '../bloc/subject_bloc.dart';

class SubjectScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();

  SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quản lý Môn Học")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddDialog(context),
      ),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          if (state is SubjectLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SubjectLoaded) {
            if (state.subjects.isEmpty) {
              return Center(child: Text("Chưa có môn học nào"));
            }

            return ListView.builder(
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                final sub = state.subjects[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      sub.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Đã nghỉ: ${sub.absentCount}/${sub.requiredAttendance}",
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<SubjectBloc>(),
                            child: SubjectDetailScreen(subject: sub),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is SubjectError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          }
          return Center(child: Text("Chào bạn! Hãy thêm môn học."));
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Thêm Môn Học Mới"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Tên môn"),
              ),
              TextField(
                controller: _creditController,
                decoration: InputDecoration(labelText: "Số tín chỉ"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = _nameController.text;
                final credits = int.tryParse(_creditController.text) ?? 0;

                if (name.isNotEmpty) {
                  final newSubject = Subject(
                    name: name,
                    credits: credits,
                    requiredAttendance: 10,
                    absentCount: 0,
                  );

                  context.read<SubjectBloc>().add(CreateSubject(newSubject));
                  Navigator.pop(context);
                  _nameController.clear();
                  _creditController.clear();
                }
              },
              child: Text("Lưu"),
            ),
          ],
        );
      },
    );
  }
}
