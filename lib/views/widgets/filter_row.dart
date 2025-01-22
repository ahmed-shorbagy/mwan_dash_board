import 'package:dash_board/core/utils/app_styles.dart';
import 'package:dash_board/views/widgets/filter_drop_dwon.dart';
import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "إدارة مشروعات المركز الوطني",
              style: AppStyles.tajawalBold32,
            ),
            Text(
              "رؤية شاملة عن جميع المشروعات من منظور عام لجميع القطاعات",
              style: AppStyles.tajawalLight20,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            const FilterDropdown(
              label: "الأقسام",
              value: "الكل",
            ),
            const SizedBox(width: 16),
            const FilterDropdown(
              label: "حالة المشاريع",
              value: "الكل",
            ),
            const SizedBox(width: 16),
            const FilterDropdown(
              label: "فترة العرض",
              value: "يناير ٢٠٢٤ حتى ديسمبر ٢٠٢٤",
            ),
            const SizedBox(width: 16),
            const FilterDropdown(
              label: "تصنيف التعاقد",
              value: "الكل",
            ),
          ],
        ),
      ],
    );
  }
}
