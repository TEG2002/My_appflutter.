import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/gradient_stat_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'โปรไฟล์',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 90, 16, 24),
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.08),
                        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
                      ),
                      child: const Icon(Icons.person, color: AppColors.primary, size: 52),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text('Warin Traveler', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('General User • Ubon Ratchathani', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.04)),
            ),
            child: const GradientStatBar(
              label: 'ความสมบูรณ์ของบัญชี',
              value: 0.85,
              trailingText: '85%',
              gradient: AppColors.primaryGradient,
              icon: Icons.verified_user_rounded,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: const [
              _StatCard(icon: Icons.assignment_outlined, label: 'โครงการที่ดูแล', value: '12', color: AppColors.primary),
              _StatCard(icon: Icons.task_alt_rounded, label: 'งานที่เสร็จสิ้น', value: '184', color: AppColors.success),
              _StatCard(icon: Icons.speed_rounded, label: 'ประสิทธิภาพ', value: '94%', color: AppColors.accentCyan),
              _StatCard(icon: Icons.access_time_rounded, label: 'ชั่วโมงงานสะสม', value: '450 ชม.', color: AppColors.accentGold),
            ],
          ),
          const SizedBox(height: 24),
          const Text('การตั้งค่าระบบ', style: TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _SettingTile(icon: Icons.notifications_none_rounded, label: 'การแจ้งเตือน', trailing: Switch(value: true, onChanged: (_) {}, activeColor: AppColors.primary)),
          _SettingTile(icon: Icons.dark_mode_outlined, label: 'โหมดมืด', trailing: Switch(value: false, onChanged: (_) {}, activeColor: AppColors.primary)),
          _SettingTile(icon: Icons.lock_outline_rounded, label: 'ความเป็นส่วนตัว', trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary)),
          _SettingTile(icon: Icons.info_outline_rounded, label: 'เกี่ยวกับแอพ', trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 9), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  const _SettingTile({required this.icon, required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.textSecondary, size: 20),
        title: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
        trailing: trailing,
      ),
    );
  }
}
