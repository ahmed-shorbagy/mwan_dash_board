import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/core/utils/app_styles.dart';
import 'package:dash_board/views/widgets/filter_drop_dwon.dart';
import 'package:dash_board/views/widgets/helper_components.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectStageCard extends StatelessWidget {
  const ProjectStageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      'تنفيذ المشروع',
      'الشراء',
      'تخطيط المشروع',
      'ملغي',
      'قبل بدأ المشروع',
      'الفارغ',
      'الإغلاق',
    ];

    final values = [
      0.95,
      0.85,
      0.75,
      0.65,
      0.45,
      0.35,
      0.25,
    ]; // Example progress values

    // Ensure all values are valid (between 0 and 1)
    final validValues = values.map((value) {
      if (value.isNaN || value.isInfinite || value < 0 || value > 1) {
        return 0.0; // Fallback to 0 if the value is invalid
      }
      return value.clamp(0.0, 1.0);
    }).toList();

    return DashboardContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('مرحلة المشروع', style: AppStyles.tajawalBold19_2),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'عرض اجمالي المشاريع بالنسبة للنموذج التشغيلي',
              style:
                  AppStyles.tajawalLight14.copyWith(color: kItemTitleTextColor),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: stages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Stage Label
                        Expanded(
                          flex: 2,
                          child: Text(
                            stages[index],
                            style: AppStyles.tajawalMedium14
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Progress Bar
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: validValues[index] * 100,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Percentage Value
                        Text(
                          '${(validValues[index] * 100).toInt()}%',
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectDistributionCard extends StatefulWidget {
  const ProjectDistributionCard({super.key});

  @override
  _ProjectDistributionCardState createState() =>
      _ProjectDistributionCardState();
}

class _ProjectDistributionCardState extends State<ProjectDistributionCard>
    with SingleTickerProviderStateMixin {
  int? _hoveredIndex;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSectionHover(int index) {
    setState(() {
      _hoveredIndex = index;
      _controller.forward();
    });
  }

  void _onSectionExit() {
    setState(() {
      _hoveredIndex = null;
      _controller.reverse();
    });
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = [
      ('ثانيا الرئيس', 41, Colors.blue),
      ('فارغ', 36, Colors.orange),
      ('الرئيس الثاني', 45, Colors.green),
      ('القسم الرابع', 38, Colors.purple), // Added fourth section
    ];

    final total = data.fold(0, (sum, item) => sum + item.$2);

    return DashboardContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('توزيع المشاريع', style: AppStyles.tajawalBold24),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('الأقسام',
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.green)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('حالة المشاريع',
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
            Text('بالنسبة للأقسام وحالة التقدم',
                style: AppStyles.tajawalLight14
                    .copyWith(color: kItemTitleTextColor)),
            const SizedBox(height: 16),
            Row(
              children: [
                // Legend
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.map((item) {
                      final percentage =
                          (item.$2 / total * 100).toStringAsFixed(1);
                      return MouseRegion(
                        onEnter: (_) => _onSectionHover(data.indexOf(item)),
                        onExit: (_) => _onSectionExit(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: item.$3,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.$1,
                                  style: AppStyles.tajawalMedium14
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Text(
                                '$percentage%',
                                style: AppStyles.tajawalLight12
                                    .copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 16),
                // Pie Chart
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 120, // Decreased width
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: data.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              final isHovered = _hoveredIndex == index;

                              return PieChartSectionData(
                                value: item.$2.toDouble(),
                                color: item.$3,
                                title:
                                    '${((item.$2 / total) * 100).toStringAsFixed(1)}%',
                                radius: isHovered ? 35 : 30,
                                titleStyle: AppStyles.tajawalBold19_2.copyWith(
                                    color: Colors.white,
                                    fontSize: 12), // Adjusted font size
                              );
                            }).toList(),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$total',
                              style: AppStyles.tajawalBold20
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              'الكل',
                              style: AppStyles.tajawalLight12
                                  .copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubdivisionsProjectsChart extends StatelessWidget {
  const SubdivisionsProjectsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "تمكين المركز",
      "تحقيق التحول الرقمي في القطاع",
      "رفع مستويات الامتثال",
      "تعزيز السلوكيات السليمة",
      "تعزيز الجاذبية الاستثمارية والأداء",
      "تنظيم قطاع إدارة الأداء",
    ].reversed.toList();

    final values = [45.0, 50.0, 20.0, 35.0, 20.0, 25.0];

    return DashboardContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("توزيع المشاريع للمحافظ الفرعية",
              style: AppStyles.tajawalBold24),
          const SizedBox(height: 8),
          Text("عرض اجمالي المشاريع في كل محافظة مع الأهداف الاستراتيجية",
              style: AppStyles.tajawalLight18
                  .copyWith(color: kItemTitleTextColor)),
          const SizedBox(height: 16),
          Expanded(
              child: SfCartesianChart(
            borderWidth: 0,
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
              majorGridLines: const MajorGridLines(
                color: Colors.transparent, // Remove vertical grid lines
              ),
              maximumLabels: categories.length,
              labelIntersectAction: AxisLabelIntersectAction.wrap,
            ),
            primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white70),
              majorGridLines: const MajorGridLines(
                color: Colors.white24, // Keep horizontal grid lines
              ),
              labelAlignment: LabelAlignment.center,
              axisLine: const AxisLine(
                color: Colors.transparent,
              ),
              opposedPosition: true, // Move Y-axis to the right
              minimum: 0, // Start Y-axis at 0
              maximum: 50, // End Y-axis at 100
              interval: 25, // Show ticks at 0, 50, and 100
            ),
            plotAreaBorderWidth: 0,
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                dataSource: List.generate(
                  categories.length,
                  (index) => ChartData(categories[index], values[index]),
                ),
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                color: kPrimaryColor,
                width: 0.18,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              LineSeries<ChartData, String>(
                dataSource: List.generate(
                  categories.length,
                  (index) => ChartData(categories[index], values[index]),
                ),
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                color: const Color(0xFF3F434A),
                width: 2,
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}

class CoordinatorVisitsChart extends StatelessWidget {
  const CoordinatorVisitsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "تمكين المركز",
      "تحقيق التحول الرقمي",
      "رفع مستويات الاستغلال",
      "تعزيز السلوكيات السليمة",
      "تعزيز الجاذبية الاستثمارية",
      "تنظيم قطاع إدارة الأداء",
      "رفع كفاءة الموارد",
      "زيادة التوعية الرقمية",
      "تطوير أدوات الإبداع",
      "تحسين نظم الرقابة",
      "زيادة التعاون المشترك",
      "إدارة الابتكار",
      "التوسع في الخدمات",
      "تعزيز الكفاءة التشغيلية",
      "تحفيز التغيير الإيجابي",
    ].reversed.toList();

    final values = [
      12.0,
      18.0,
      10.0,
      16.0,
      20.0,
      14.0,
      15.0,
      13.0,
      17.0,
      19.0,
      9.0,
      11.0,
      8.0,
      12.0,
      16.0,
    ];

    return DashboardContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("عدد المشاريع للإدارات التنفيذية",
              style: AppStyles.tajawalBold24),
          const SizedBox(height: 8),
          Text("عرض اجمالي المشاريع مع قيم العقود الحالية بشكل شخطي",
              style: AppStyles.tajawalLight18
                  .copyWith(color: kItemTitleTextColor)),
          const SizedBox(height: 16),
          Expanded(
            child: SfCartesianChart(
              borderColor: Colors.transparent,
              borderWidth: 0,
              primaryXAxis: CategoryAxis(
                labelStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                majorGridLines: const MajorGridLines(
                  color: Colors.transparent, // Remove vertical grid lines
                ),
                maximumLabels: categories.length,
                labelIntersectAction: AxisLabelIntersectAction.wrap,
              ),
              primaryYAxis: NumericAxis(
                labelStyle: const TextStyle(color: Colors.white70),
                majorGridLines: const MajorGridLines(
                  color: Colors.white24, // Keep horizontal grid lines
                ),

                labelAlignment: LabelAlignment.center,
                axisLine: const AxisLine(color: Colors.transparent, width: 0),

                opposedPosition: true, // Move Y-axis to the right
                minimum: 0, // Start Y-axis at 0
                maximum: 20, // End Y-axis at 100
                interval: 10, // Show ticks at 0, 50, and 100
              ),
              series: <CartesianSeries>[
                ColumnSeries<ChartData, String>(
                  dataSource: List.generate(
                    categories.length,
                    (index) => ChartData(categories[index], values[index]),
                  ),
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.value,
                  color: kPrimaryColor,
                  width: 0.18,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                LineSeries<ChartData, String>(
                  dataSource: List.generate(
                    categories.length,
                    (index) => ChartData(categories[index], values[index]),
                  ),
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.value,
                  color: const Color(0xFF3F434A),
                  width: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCoordinatorsCard extends StatelessWidget {
  const ProjectCoordinatorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final coordinators = [
      'محمد الشرف',
      'محمد العجمي',
      'أحمد مصطفى',
      'تقي سامع',
      'سمية الشوامين',
      'زييدة جستنيّة',
    ];

    final values = [
      0.9,
      0.8,
      0.7,
      0.6,
      0.5,
      0.4,
    ]; // Example values for project distribution

    // Validate and clamp values to ensure they're within a valid range
    final validValues = values.map((value) {
      if (value.isNaN || value.isInfinite || value < 0 || value > 1) {
        return 0.0; // Fallback to 0 if the value is invalid
      }
      return value.clamp(0.0, 1.0);
    }).toList();

    return DashboardContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Row(
                children: [
                  Text('منسقين المشاريع', style: AppStyles.tajawalBold24),
                  SizedBox(
                    width: 60,
                  ),
                  SimpleDropdown()
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'عرض المشاريع بالنسبة لأسماء المنسقين',
              style:
                  AppStyles.tajawalLight14.copyWith(color: kItemTitleTextColor),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: coordinators.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            coordinators[index],
                            style: AppStyles.tajawalMedium14
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: validValues[index],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${(validValues[index] * 100).toInt()}%',
                          style: AppStyles.tajawalLight12
                              .copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
                child: SubdivisionsProjectsChart(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ProjectDistributionCard(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ProjectStageCard(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: CoordinatorVisitsChart(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ProjectCoordinatorsCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
