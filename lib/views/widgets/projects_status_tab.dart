import 'package:dash_board/core/utils/assets.dart';
import 'package:dash_board/views/widgets/charts_widget.dart';
import 'package:dash_board/views/widgets/filter_row.dart';
import 'package:dash_board/views/widgets/helper_components.dart';
import 'package:dash_board/views/widgets/stats_row.dart';
import 'package:dash_board/views/widgets/table_fake_data.dart';
import 'package:dash_board/views/widgets/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectsStatusTab extends StatelessWidget {
  const ProjectsStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Shrink-wrap the column
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: FilterRow(),
          ),
          const StatsRow(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: DashboardCharts(),
          ),
          TableContainer(
            actions: [SvgPicture.asset(Assets.assetsImagesExpandButton)],
            table: CustomTable(headers: headers, rows: rows),
          ),
        ],
      ),
    );
  }
}
