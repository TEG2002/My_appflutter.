import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/gradient_stat_bar.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<_TaskItem> tasks = [
    _TaskItem('วิเคราะห์ข้อมูลยอดขายประจำสัปดาห์', 'เสร็จสิ้นภายในวันนี้', true, AppColors.success),
    _TaskItem('ปรับปรุงโครงสร้างธีม UI ของระบบ', 'สำคัญสูง', false, AppColors.primary),
    _TaskItem('เขียนเอกสารสรุปความต้องการผู้ใช้', 'เสร็จสิ้นพรุ่งนี้', true, AppColors.success),
    _TaskItem('แก้ไขบั๊กเมนูนำทางด้านข้าง', 'ด่วนที่สุด', false, AppColors.danger),
    _TaskItem('ทดสอบฟังก์ชันหน้าโปรไฟล์', 'สำคัญปานกลาง', false, AppColors.accentGold),
  ];

  @override
  Widget build(BuildContext context) {
    int completedCount = tasks.where((t) => t.isCompleted).length;
    double progress = tasks.isEmpty ? 0.0 : completedCount / tasks.length;

    return AppScaffold(
      title: 'งานของฉัน',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 90, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.04)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ความคืบหน้ารวม',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GradientStatBar(
                  label: 'งานที่ทำเสร็จแล้ว',
                  value: progress,
                  trailingText: '$completedCount / ${tasks.length} งาน',
                  gradient: AppColors.primaryGradient,
                  icon: Icons.assignment_turned_in_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'รายการภารกิจวันนี้',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ทั้งหมด',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.04)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Checkbox(
                    value: task.isCompleted,
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (val) {
                      setState(() {
                        task.isCompleted = val ?? false;
                      });
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      color: task.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: task.tagColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          task.tag,
                          style: TextStyle(
                            color: task.tagColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TaskItem {
  final String title;
  final String tag;
  bool isCompleted;
  final Color tagColor;

  _TaskItem(this.title, this.tag, this.isCompleted, this.tagColor);
}
