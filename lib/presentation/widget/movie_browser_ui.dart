import 'package:flutter/material.dart';
import 'package:uip_tv_app/presentation/widget/category_tab.dart';
import 'package:uip_tv_app/presentation/widget/indicator.dart';
import 'package:uip_tv_app/presentation/widget/movie_card.dart';

class MovieBrowserUI extends StatefulWidget {
  const MovieBrowserUI({
    super.key,
    required this.movies,
  });

  final List<String> movies;

  @override
  MovieBrowserUIState createState() => MovieBrowserUIState();
}

class MovieBrowserUIState extends State<MovieBrowserUI> {
  final List<String> categories = [
    'All',
    'Action',
    'Anime',
    'Sci-fi',
    'Thriller',
  ];

  final PageController _pageController = PageController();
  int _selectedCategoryIndex = 0;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() {
    if (widget.movies.isNotEmpty) {
      Future.delayed(const Duration(seconds: 3), () {
        if (_pageController.hasClients) {
          final nextPage = (_currentPageIndex + 1) % widget.movies.length;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentPageIndex = nextPage;
          });
        }
        _autoSlide();
      });
    } else {
      debugPrint("No movies available for auto-slide.");
    }
  }

  void _onCategoryTabClick(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories
                  .asMap()
                  .entries
                  .map(
                    (entry) => CategoryTab(
                      title: entry.value,
                      isSelected: _selectedCategoryIndex == entry.key,
                      onTap: () => _onCategoryTabClick(entry.key),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        // Movie Carousel
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return MovieCard(imageUrl: widget.movies[index]);
            },
          ),
        ),
        // Carousel Indicator
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Indicator(isActive: index == _currentPageIndex),
            ),
          ),
        ),
      ],
    );
  }
}
