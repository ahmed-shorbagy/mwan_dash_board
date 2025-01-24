import 'package:dash_board/core/utils/assets.dart';
import 'package:dash_board/views/widgets/helper_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: StatsCard(
              title: 'إجمالي عدد المشاريع',
              value: '180',
              icon: SvgPicture.asset(Assets.assetsImagesFlag1),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StatsCard(
              title: 'قيمة العقود الحالية',
              value: '858.09M',
              icon: SvgPicture.asset(Assets.assetsImagesMoney1),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StatsCard(
              title: 'المفوتر',
              value: '555.76M',
              icon: SvgPicture.asset(Assets.assetsImagesInvoice1),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StatsCard(
              title: 'المتبقي للفوترة',
              value: '302.33M',
              icon: SvgPicture.asset(Assets.assetsImagesRamainning1),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StatsCard(
              title: 'نسبة الصرف',
              value: '0.05',
              icon: SvgPicture.asset(Assets.assetsImagesPercentage),
            ),
          ),
        ],
      ),
    );
  }
}
