import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';

// Custom container widget for dashboard items
class DashboardContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const DashboardContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: kItemBackGroundColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

// Stats card for numerical data
class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget? icon;
  final Color? valueColor;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: valueColor ?? Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

// Chart container for graphs
class ChartContainer extends StatelessWidget {
  final String title;
  final Widget chart;
  final List<Widget>? actions;

  const ChartContainer({
    super.key,
    required this.title,
    required this.chart,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (actions != null) ...actions!,
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: chart),
        ],
      ),
    );
  }
}

// Table container for data grids
class TableContainer extends StatelessWidget {
  final String title;
  final Widget table;
  final List<Widget>? actions;

  const TableContainer({
    super.key,
    required this.title,
    required this.table,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (actions != null) ...actions!,
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 500, // Fixed height for the table
            width: double.infinity, // Fill the entire width
            child: table,
          ),
        ],
      ),
    );
  }
}

// Example usage in your dashboard
class DashboardExample extends StatelessWidget {
  const DashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stats Row
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      title: 'إجمالي عدد المشاريع',
                      value: '180',
                      icon: Icon(Icons.bar_chart,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    child: StatsCard(
                      title: 'قيمة العقود الحالية',
                      value: '858.09M',
                      valueColor: Colors.orange,
                    ),
                  ),
                  // Add more stats cards...
                ],
              ),
            ),

            // Charts Row
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ChartContainer(
                      title: 'توزيع المشاريع',
                      chart: const Placeholder(), // Your chart widget here
                    ),
                  ),
                  Expanded(
                    child: ChartContainer(
                      title: 'توزيع المحافظات',
                      chart: const Placeholder(), // Your chart widget here
                    ),
                  ),
                ],
              ),
            ),

            // Table Section
            Expanded(
              child: TableContainer(
                title: 'تفاصيل المشاريع',
                table: const Placeholder(), // Your table widget here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
