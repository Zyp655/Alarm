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
      appBar: AppBar(title: const Text("Quản lý Môn Học")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddDialog(context),
      ),
      body: BlocConsumer<SubjectBloc, SubjectState>(
        listener: (context, state) {
          if (state is SubjectError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SubjectLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubjectLoaded) {
            if (state.subjects.isEmpty) {
              return const Center(child: Text("Chưa có môn học nào"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SubjectBloc>().add(LoadSubjects());
              },
              child: ListView.builder(
                itemCount: state.subjects.length,
                itemBuilder: (context, index) {
                  final sub = state.subjects[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        sub.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Số tín chỉ: ${sub.credits} | Đã nghỉ: ${sub.absentCount}/${sub.requiredAttendance}",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Truyền Bloc hiện tại sang màn hình chi tiết
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
              ),
            );
          } else if (state is SubjectError) {
            // Nếu lỗi ngay từ đầu (chưa load được danh sách), hiện nút thử lại
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<SubjectBloc>().add(LoadSubjects()),
                    child: const Text("Thử lại"),
                  )
                ],
              ),
            );
          }
          return const Center(child: Text("Chào bạn! Hãy thêm môn học."));
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Thêm Môn Học Mới"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Tên môn"),
              ),
              TextField(
                controller: _creditController,
                decoration: const InputDecoration(labelText: "Số tín chỉ"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final credits = int.tryParse(_creditController.text) ?? 0;

                if (name.isNotEmpty) {
                  // Dữ liệu mẫu ban đầu
                  final newSubject = Subject(
                    name: name,
                    credits: credits,
                    requiredAttendance: 10, // Mặc định
                    absentCount: 0,
                  );

                  // Gọi sự kiện CreateSubject -> Bloc sẽ gọi API thật
                  context.read<SubjectBloc>().add(CreateSubject(newSubject));
                  Navigator.pop(context);
                  _nameController.clear();
                  _creditController.clear();
                }
              },
              child: const Text("Lưu"),
            ),
          ],
        );
      },
    );
  }
}