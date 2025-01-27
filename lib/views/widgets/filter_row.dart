import 'package:dash_board/core/utils/app_styles.dart';
import 'package:dash_board/views/widgets/filter_drop_dwon.dart';
import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            // Left side: Title and Subtitle
            Flexible(
              flex: 2, // Give this more space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "إدارة مشروعات المركز الوطني",
                      style: AppStyles.tajawalBold32,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "رؤية شاملة عن جميع المشروعات من منظور عام لجميع القطاعات",
                      style: AppStyles.tajawalLight20,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Add space between the title and filters
            // Right side: Filter Dropdowns
            Flexible(
              flex: 3, // Give this more space
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Row(
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
                    const FilterDateDropdown(
                      label: "فترة العرض",
                    ),
                    const SizedBox(width: 16),
                    const FilterDropdown(
                      label: "تصنيف التعاقد",
                      value: "الكل",
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
