import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/core/utils/app_styles.dart';
import 'package:dash_board/views/widgets/helper_components.dart';
import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const FilterDropdown({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.tajawalLight20),
        const SizedBox(height: 8),
        DashboardContainer(
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: AppStyles.tajawalLight18.copyWith(
                    color: kItemTitleTextColor,
                  ),
                ),
                const SizedBox(width: 60),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: kItemTitleTextColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
