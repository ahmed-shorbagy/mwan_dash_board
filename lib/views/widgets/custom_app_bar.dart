import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/core/utils/app_styles.dart';
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
      width: double.infinity, // Ensure the app bar takes full width
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
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Distribute children evenly
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Row(
            children: [
              Image.asset(
                Assets.assetsImagesLogogpng,
                height: 40,
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Tab Bar
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allow scrolling for tabs
                child: TabBar(
                  labelColor: kPrimaryColor,
                  labelStyle: AppStyles.tajawalBold24,
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelStyle: AppStyles.tajawalRegular24,
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

          // Profile Section
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Photo
              Container(
                height: 42,
                width: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor, width: 2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Assets.assetsImagesProfile),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (screenWidth > 600)
                Text(
                  "محمد أشرف",
                  style: AppStyles.tajawalRegular24,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(width: 16),
              // Bell Icon
              SvgPicture.asset(
                Assets.assetsImagesBell,
                height: 24,
                width: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
