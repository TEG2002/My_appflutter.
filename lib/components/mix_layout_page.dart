import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';

class MixLayoutPage extends StatefulWidget {
  const MixLayoutPage({super.key});

  @override
  State<MixLayoutPage> createState() => _MixLayoutPageState();
}

class _MixLayoutPageState extends State<MixLayoutPage> {
  int selectedChip = 0;
  final chips = ['ทั้งหมด', 'เทคโนโลยี', 'อุปกรณ์เสริม', 'เฟอร์นิเจอร์'];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'แดชบอร์ด',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 90, 16, 24),
        children: [
          Row(
            children: [
              Expanded(child: _MiniStat(label: 'รายรับ', value: '฿12,450', delta: '+8.2%', up: true)),
              const SizedBox(width: 10),
              Expanded(child: _MiniStat(label: 'ลูกค้าใหม่', value: '328 ราย', delta: '+3.1%', up: true)),
              const SizedBox(width: 10),
              Expanded(child: _MiniStat(label: 'ยกเลิก', value: '14 ราย', delta: '-1.4%', up: false)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ยอดขาย 7 วันล่าสุด',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 1.0].map((h) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 100 * h,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('จ.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    Text('อ.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    Text('พ.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    Text('พฤ.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    Text('ศ.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    Text('ส.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    Text('อา.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('คลังสินค้าด่วน', style: TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chips.length,
              itemBuilder: (context, i) {
                final selected = selectedChip == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(chips[i]),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedChip = i),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.bgCard,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: selected ? AppColors.primary : Colors.black.withOpacity(0.04),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: List.generate(4, (i) => _ItemGridCard(index: i)),
          ),
          const SizedBox(height: 24),
          const Text('ธุรกรรมล่าสุด', style: TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(3, (i) => _TransactionTile(index: i)),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label, value, delta;
  final bool up;
  const _MiniStat({required this.label, required this.value, required this.delta, required this.up});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                up ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                size: 11,
                color: up ? AppColors.success : AppColors.danger,
              ),
              const SizedBox(width: 2),
              Text(
                delta,
                style: TextStyle(
                  color: up ? AppColors.success : AppColors.danger,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemGridCard extends StatelessWidget {
  final int index;
  const _ItemGridCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final icons = [Icons.laptop_mac_rounded, Icons.headphones_rounded, Icons.keyboard_rounded, Icons.mouse_rounded];
    final names = ['แมคบุ๊คโปร', 'หูฟังบลูทูธ', 'คีย์บอร์ดไร้สาย', 'เมาส์ไร้สาย'];
    final colors = [AppColors.accentCyan, AppColors.primary, AppColors.accentGold, AppColors.success];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colors[index].withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icons[index], color: colors[index], size: 18),
          ),
          const Spacer(),
          Text(
            names[index],
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'คงเหลือ: ${(index + 1) * 3}',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final int index;
  const _TransactionTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final titles = ['ซื้อแมคบุ๊คโปร M3', 'ขายโต๊ะทำงานเก่า', 'รับเงินโอนค่าบริการ'];
    final amounts = ['-35,900', '+3,500', '+15,000'];
    final positive = [false, true, true];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withOpacity(0.08),
            child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              titles[index],
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '${amounts[index]} ฿',
            style: TextStyle(
              color: positive[index] ? AppColors.success : AppColors.danger,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
