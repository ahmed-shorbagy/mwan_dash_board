import 'package:dash_board/views/widgets/charts_widget.dart';
import 'package:dash_board/views/widgets/filter_row.dart';
import 'package:dash_board/views/widgets/stats_row.dart';
import 'package:flutter/material.dart';

class ProjectsStatusTab extends StatelessWidget {
  const ProjectsStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34),
            child: FilterRow(),
          ),
          StatsRow(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DashboardCharts(),
          )
        ],
      ),
    );
  }
}
