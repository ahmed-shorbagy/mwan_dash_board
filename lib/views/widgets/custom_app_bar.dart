import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
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
          // Notification Bellz
          Image.asset(
            Assets.assetsImagesLogogpng,
            height: 40,
          ),
          Spacer(),
          // Tab Bar
          TabBar(
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
          Spacer(),

          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor, width: 2),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(Assets.assetsImagesProfile),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                "محمد أشرف",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 34),
              Center(
                child: SvgPicture.asset(
                  Assets.assetsImagesBell,
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
          // Logo
        ],
      ),
    );
  }
}
