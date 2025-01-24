import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF414141),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Image.asset(
            Assets.assetsImagesLogogpng,
            height: 40,
          ),
          const SizedBox(width: 8), // Add some spacing

          // Flexible space between logo and tab bar
          Flexible(
            flex: 1,
            child: Container(), // Empty container to take up space
          ),

          // Tab Bar
          Flexible(
            flex: 3, // Give more space to the tab bar
            child: SizedBox(
              width: screenWidth * 0.5, // Limit the width of the tab bar
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Make it scrollable
                child: TabBar(
                  labelColor: kPrimaryColor,
                  controller: _tabController,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3.0,
                      color: kPrimaryColor,
                    ),
                    insets: EdgeInsets.zero,
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: kPrimaryColor,
                  tabs: const [
                    Tab(text: 'حالة المشاريع العامة'),
                    Tab(text: 'المنظور المالي'),
                    Tab(text: 'توزيع المشاريع'),
                    Tab(text: 'توزيع المناطق'),
                    Tab(text: 'توزيع المستندات'),
                  ],
                ),
              ),
            ),
          ),

          // Flexible space between tab bar and profile section
          Flexible(
            flex: 1,
            child: Container(), // Empty container to take up space
          ),

          // Profile Section
          Flexible(
            flex: 1, // Give less space to the profile section
            child: Row(
              mainAxisSize: MainAxisSize.min, // Prevent overflow
              children: [
                // Profile Photo
                Container(
                  height: 42,
                  width: 42,
                  alignment: Alignment.center, // Center the photo
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kPrimaryColor, width: 2),
                    image: DecorationImage(
                      fit: BoxFit.cover, // Ensure the photo fills the container
                      image: AssetImage(Assets.assetsImagesProfile),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Reduce spacing
                if (screenWidth > 600) // Show name only on larger screens
                  const Center(
                    child: Text(
                      "محمد أشرف",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                const SizedBox(width: 24), // Reduce spacing
                // Bell Icon
                Center(
                  child: SvgPicture.asset(
                    Assets.assetsImagesBell,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
