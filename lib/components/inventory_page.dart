import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int tabIndex = 0;
  final tabs = ['ทั้งหมด', 'ไอที', 'อุปกรณ์เสริม', 'เฟอร์นิเจอร์'];

  final items = [
    _Item('แมคบุ๊คโปร M3', Icons.laptop_mac_rounded, _Category.it, 4),
    _Item('ไอโฟน 15 โปร', Icons.phone_iphone_rounded, _Category.it, 10),
    _Item('หูฟังบลูทูธ', Icons.headphones_rounded, _Category.accessories, 25),
    _Item('โต๊ะปรับระดับได้', Icons.table_restaurant_rounded, _Category.furniture, 2),
    _Item('คีย์บอร์ดไร้สาย', Icons.keyboard_rounded, _Category.accessories, 15),
    _Item('หน้าจอ 4K UHD', Icons.monitor_rounded, _Category.it, 5),
    _Item('เก้าอี้เพื่อสุขภาพ', Icons.chair_rounded, _Category.furniture, 8),
    _Item('เมาส์ไร้สาย', Icons.mouse_rounded, _Category.accessories, 30),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) {
      if (tabIndex == 0) return true;
      if (tabIndex == 1) return item.category == _Category.it;
      if (tabIndex == 2) return item.category == _Category.accessories;
      if (tabIndex == 3) return item.category == _Category.furniture;
      return true;
    }).toList();

    int totalStock = items.fold(0, (sum, item) => sum + item.count);

    return AppScaffold(
      title: 'คลังสินค้า',
      actions: [
        IconButton(icon: const Icon(Icons.add_rounded), onPressed: () {}),
      ],
      body: Column(
        children: [
          const SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _CapacityCard(used: totalStock, total: 200),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 38,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, i) {
                final selected = tabIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => tabIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? AppColors.primary : Colors.black.withOpacity(0.04),
                        ),
                      ),
                      child: Text(
                        tabs[i],
                        style: TextStyle(
                          color: selected ? Colors.white : AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, i) => _ItemSlot(item: filteredItems[i]),
            ),
          ),
        ],
      ),
    );
  }
}

enum _Category { it, accessories, furniture }

class _Item {
  final String name;
  final IconData icon;
  final _Category category;
  final int count;
  _Item(this.name, this.icon, this.category, this.count);
}

class _ItemSlot extends StatelessWidget {
  final _Item item;
  const _ItemSlot({required this.item});

  @override
  Widget build(BuildContext context) {
    Color catColor = AppColors.primary;
    if (item.category == _Category.it) {
      catColor = AppColors.accentCyan;
    } else if (item.category == _Category.furniture) {
      catColor = AppColors.accentGold;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: catColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item.icon, color: catColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'คงเหลือ: ${item.count}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.category == _Category.it
                ? 'เทคโนโลยี'
                : item.category == _Category.furniture
                    ? 'เฟอร์นิเจอร์'
                    : 'อุปกรณ์เสริม',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _CapacityCard extends StatelessWidget {
  final int used, total;
  const _CapacityCard({required this.used, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory_2_outlined, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ปริมาณสินค้าทั้งหมด  $used/$total ชิ้น',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: used / total,
                    minHeight: 6,
                    backgroundColor: Colors.black.withOpacity(0.03),
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
