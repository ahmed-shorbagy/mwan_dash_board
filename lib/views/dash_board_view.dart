import 'package:dash_board/views/widgets/custom_app_bar.dart';
import 'package:dash_board/views/widgets/projects_status_tab.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Custom App Bar
            CustomAppbar(tabController: _tabController),

            // Tab Bar Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ProjectsStatusTab(),
                  Center(
                      child: Text('المنظور المالي',
                          style: TextStyle(color: Colors.white))),
                  Center(
                      child: Text('توزيع المشاريع',
                          style: TextStyle(color: Colors.white))),
                  Center(
                      child: Text('توزيع المناطق',
                          style: TextStyle(color: Colors.white))),
                  Center(
                      child: Text('توزيع المستندات',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
