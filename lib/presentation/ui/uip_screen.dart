
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uip_tv_app/domain/controller/user_controller.dart';
import 'package:uip_tv_app/presentation/utils/asset_colors_path.dart';
import 'package:uip_tv_app/presentation/widget/categories_text.dart';
import 'package:uip_tv_app/presentation/widget/custom_box.dart';
import 'package:uip_tv_app/presentation/widget/custom_list.dart';
import 'package:uip_tv_app/presentation/widget/custom_slider.dart';
import 'package:uip_tv_app/presentation/widget/movie_browser_ui.dart';
import 'package:uip_tv_app/presentation/widget/profile_avatar.dart';

class UipScreen extends StatelessWidget {
  const UipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UipController controller = Get.find<UipController>();
    Future<void> onRefresh() async {
      await controller.refreshData();
    }
    return Scaffold(
      backgroundColor: AssetColorsPath.backgroundColors,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                buildDataProfile(controller),
                const SizedBox(height: 20),
                buildSearch(),
                const SizedBox(height: 20),
                const CategoriesText(
                  title: 'Categories',
                  subTitle: 'See More',
                ),
                const SizedBox(height: 10),
                buildMovieBrowser(controller),
                const SizedBox(height: 10),
                const CategoriesText(
                  title: 'Trending Movies',
                  subTitle: 'See More',
                ),
                const SizedBox(height: 10),
                buildTrendingMoviesSlider(controller),
                const SizedBox(height: 10),
                const CategoriesText(
                  title: 'Continue Watching',
                  subTitle: 'See More',
                ),
                const SizedBox(height: 10),
                buildContinueWatchingList(controller),
                const SizedBox(height: 10),
                const CategoriesText(
                  title: 'Recommended For You',
                  subTitle: 'See More',
                ),
                const SizedBox(height: 10),
                buildRecommendedSlider(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataProfile(UipController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => RichText(
                text: TextSpan(
                  text: 'Hello ${controller.userName.value}\n',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Let’s watch today',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              )),
        ),
        Obx(() => ProfileAvatar(userImage: controller.userImage.value)),
      ],
    );
  }

  Widget buildSearch() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: AssetColorsPath.textSmallColors),
              suffixIcon: Icon(
                Icons.search_rounded,
                size: 28,
                color: AssetColorsPath.textSmallColors,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomBox(
          height: 43,
          width: 43,
          borderRadius: 10,
          color: AssetColorsPath.iconColors,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.tune,
              color: AssetColorsPath.textBoldColors,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMovieBrowser(UipController controller) {
    return Obx(() {
      final movies =
          controller.trendingMovies.map((movie) => movie.url ?? '').toList();
      return SizedBox(
        height: 280,
        child: MovieBrowserUI(
          movies: movies,
        ),
      );
    });
  }

  Widget buildTrendingMoviesSlider(UipController controller) {
    return Obx(() {
      final sliderItems = controller.trendingMovies.map((movie) {
        return {
          'title': movie.title ?? 'Unknown Title',
          'imageUrl': movie.thumbnailUrl ?? '',
        };
      }).toList();

      log('Slider Items: $sliderItems');

      return CustomSlider(
        height: 120,
        width: 100,
        items: sliderItems,
      );
    });
  }

  Widget buildContinueWatchingList(UipController controller) {
    return Obx(() {
      final listItems = controller.trendingMovies
          .map((movie) => {
                'title': movie.title ?? 'Unknown Title',
                'imageUrl': movie.url ?? 'default_image_url.png',
              })
          .toList();

      return CustomList(
        items: listItems,
      );
    });
  }

  Widget buildRecommendedSlider(UipController controller) {
    return Obx(() {
      final sliderItems = controller.trendingMovies
          .map((movie) => {
                'title': movie.title ?? 'Unknown Title',
                'imageUrl': movie.url ?? 'default_image_url.png',
              })
          .toList();

      return CustomSlider(
        height: 120,
        width: 100,
        items: sliderItems,
      );
    });
  }
}
