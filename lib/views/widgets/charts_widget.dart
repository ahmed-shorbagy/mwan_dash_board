import 'package:dash_board/core/utils/app_styles.dart';
import 'package:dash_board/views/widgets/helper_components.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectStageCard extends StatelessWidget {
  const ProjectStageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      'تحديد المشروع',
      'الخطة التنفيذية للمشروع',
      'مبدئي',
      'قبول المشروع المبدئي',
      'إغلاق',
      'إلغاء',
    ];

    final values = [0.95, 0.85, 0.75, 0.65, 0.45, 0.35];

    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('مرحلة المشروع', style: AppStyles.tajawalBold19_2),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('الأقسام',
                    style:
                        AppStyles.tajawalLight12.copyWith(color: Colors.green)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('حالة المشاريع',
                    style:
                        AppStyles.tajawalLight12.copyWith(color: Colors.blue)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: stages
                      .map((stage) => Text(
                            stage,
                            style: AppStyles.tajawalLight12
                                .copyWith(color: Colors.white70),
                          ))
                      .toList(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 1,
                      barGroups: List.generate(
                        values.length,
                        (i) => BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: values[i],
                              color: Colors.green,
                              width: 8,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ],
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(show: false),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: values
                      .map((value) => Text(
                            '${(value * 100).toInt()}%',
                            style: AppStyles.tajawalLight12
                                .copyWith(color: Colors.white70),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectDistributionCard extends StatelessWidget {
  const ProjectDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ('الدائرة الرئيسية', 41, Colors.blue),
      ('إدارة المشاريع', 53, Colors.orange),
      ('الدائرة الثانية', 45, Colors.yellow),
      ('الدائرة الثالثة', 36, Colors.green),
    ];

    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('توزيع المشاريع', style: AppStyles.tajawalBold19_2),
          const SizedBox(height: 8),
          Text('بالنسبة للمشاريع وحالة التقدم',
              style: AppStyles.tajawalLight12.copyWith(color: Colors.white70)),
          Expanded(
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: data
                        .map((item) => PieChartSectionData(
                              value: item.$2.toDouble(),
                              color: item.$3,
                              title: '${((item.$2 / 180) * 100).toInt()}%',
                              radius: 60,
                              titleStyle: AppStyles.tajawalBold19_2
                                  .copyWith(color: Colors.white),
                              showTitle: true,
                            ))
                        .toList(),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '180',
                        style: AppStyles.tajawalBold24,
                      ),
                      Text(
                        'الكل',
                        style: AppStyles.tajawalLight14
                            .copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Legend
          Wrap(
            spacing: 16,
            children: data
                .map((item) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: item.$3,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.$1,
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.white70),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class RegionalDistributionCard extends StatelessWidget {
  const RegionalDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final regions = [
      'مدينة الملك خالد الطبية',
      'مدينة الملك سعود الطبية',
      'مستشفى الملك فيصل التخصصي',
      'مدينة الأمير سلطان الطبية',
      'المستشفى التخصصي',
    ];

    final values = [45.0, 35.0, 25.0, 40.0, 30.0];

    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('توزيع المشاريع للمحافظ الفرعية',
              style: AppStyles.tajawalBold19_2),
          const SizedBox(height: 8),
          Text('عرض إجمالي المشاريع في كل محافظة مع النسبة الاستراتيجية',
              style: AppStyles.tajawalLight12.copyWith(color: Colors.white70)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 50,
                  barGroups: List.generate(
                    regions.length,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: values[i],
                          color: const Color(0xFF00FF85),
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.white70),
                        ),
                        reservedSize: 30,
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            regions[value.toInt()],
                            style: AppStyles.tajawalLight12
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                        reservedSize: 120,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom section with coordinator visits chart
class CoordinatorVisitsChart extends StatelessWidget {
  const CoordinatorVisitsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'ابريل',
      'مايو',
      'يونيو',
      'يوليو',
      'اغسطس',
      'سبتمبر',
      'اكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    final values = [
      15.0,
      18.0,
      12.0,
      16.0,
      8.0,
      14.0,
      17.0,
      10.0,
      13.0,
      9.0,
      11.0,
      15.0
    ];

    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("عدد المشاريع للإدارات التنفيذية",
              style: AppStyles.tajawalBold19_2),
          const SizedBox(height: 8),
          Text("عرض اجمالي المشاريع مع قيم العقود الحالية بشكل شخطي",
              style: AppStyles.tajawalLight12.copyWith(color: Colors.white70)),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          months[value.toInt()],
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.white70),
                        ),
                      ),
                      reservedSize: 60,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: AppStyles.tajawalLight12
                            .copyWith(color: Colors.white70),
                      ),
                      reservedSize: 30,
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      months.length,
                      (i) => FlSpot(i.toDouble(), values[i]),
                    ),
                    isCurved: true,
                    color: const Color(0xFF00FF85),
                    barWidth: 2,
                    dotData: FlDotData(show: true),
                  ),
                ],
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCharts extends StatelessWidget {
  const DashboardCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ProjectStageCard(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ProjectDistributionCard(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: RegionalDistributionCard(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: CoordinatorVisitsChart(),
        ),
      ],
    );
  }
}
