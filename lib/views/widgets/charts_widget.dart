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
      'الشراء',
      'تخطيط المشروع',
      'ملغي',
      'قبل بدأ المشروع',
      'الفارغ',
      'البغانق',
    ];

    final values = [0.95, 0.85, 0.75, 0.65, 0.45, 0.35, 0.25];

    return DashboardContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 16),
            Center(
              child: Text(
                '100%',
                style: AppStyles.tajawalBold20.copyWith(color: Colors.white),
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
                Text('توزيع المشاريع', style: AppStyles.tajawalBold19_2),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
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
                style:
                    AppStyles.tajawalLight12.copyWith(color: Colors.white70)),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "عدد المشاريع للإدارات التنفيذية",
              style: AppStyles.tajawalBold19_2,
            ),
            const SizedBox(height: 8),
            Text(
              "عرض اجمالي المشاريع مع قيم العقود الحالية بشكل شخطي",
              style: AppStyles.tajawalLight12.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 16),
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
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            return RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                months[value.toInt()],
                                style: AppStyles.tajawalLight12
                                    .copyWith(color: Colors.white70),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
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
                  maxX: months.length - 1,
                  minY: 0,
                  maxY: 20,
                ),
              ),
            ),
          ],
        ),
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
            Row(
              children: [
                Text('منسقين المشاريع', style: AppStyles.tajawalBold19_2),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'الأقسام',
                    style:
                        AppStyles.tajawalLight12.copyWith(color: Colors.green),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'حالة المشاريع',
                    style:
                        AppStyles.tajawalLight12.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'عرض المشاريع بالنسبة لأسماء المنسقين',
              style: AppStyles.tajawalLight12.copyWith(color: Colors.white70),
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
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: validValues[index],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
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
                flex: 3,
                child: RegionalDistributionCard(),
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
                flex: 3,
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
