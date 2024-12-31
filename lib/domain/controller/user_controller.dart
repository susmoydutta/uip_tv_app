import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uip_tv_app/domain/models/movie_data.dart';
import 'package:uip_tv_app/domain/network/network_caller.dart';
import 'package:uip_tv_app/domain/utils/urls.dart';

class UipController extends GetxController {
  var userName = "Loading...".obs;
  var userImage = "".obs;
  var trendingMovies = <MovieData>[].obs;

  bool _inProgress = false;
  String _errorMessage = '';
  final _moviesBox = Hive.box<MovieData>('moviesBox');
  final _userBox = Hive.box('userBox');

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
    fetchUserPhoto();
    fetchTrendingMovies();
  }

  void addMovie(MovieData movie) {
    _moviesBox.add(movie);
  }
  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));

    userName.value = 'New User';
    userImage.value = 'assets/new_user.jpg';

    bool isSuccess = await fetchTrendingMovies();
    if (isSuccess) {
      // trendingMovies.value = fetchedMovies;
    } else {
    }
  }

  Future<bool> fetchUserProfile() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    if (_userBox.containsKey('userName')) {
      userName.value = _userBox.get('userName');
      _inProgress = false;
      update();
      return true;
    }

    final response = await NetworkCaller.getRequest(url: Urls.user);
    if (response.isSuccess) {
      final user = response.responseData[0];
      userName.value = user['name'] ?? 'Unknown User';

      _userBox.put('userName', userName.value);

      isSuccess = true;
    } else {
      userName.value = "Failed to load user";
      _errorMessage = response.errorMessage ?? 'User Profile fetch failed';
      log("User Profile Error", error: response.errorMessage);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> fetchUserPhoto() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    if (_userBox.containsKey('userImage')) {
      userImage.value = _userBox.get('userImage');
      _inProgress = false;
      update();
      return true;
    }

    final response = await NetworkCaller.getRequest(url: Urls.photo);
    if (response.isSuccess) {
      final user = response.responseData[0];
      userImage.value = user['url'] ?? '';

      _userBox.put('userImage', userImage.value);

      isSuccess = true;
    } else {
      userImage.value = "Failed to load user image";
      _errorMessage = response.errorMessage ?? 'User Photo fetch failed';
      log("User Photo Error", error: response.errorMessage);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
  Future<bool> fetchTrendingMovies() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    try {
      final response = await NetworkCaller.getRequest(url: Urls.photo);
      if (response.isSuccess) {
        final movies = (response.responseData as List)
            .map((json) => MovieData.fromJson(json))
            .toList();
        trendingMovies.assignAll(movies);
        isSuccess = true;

        await _moviesBox.clear();
        await _moviesBox.addAll(movies);
      } else {
        _errorMessage =
            response.errorMessage ?? 'Failed to load trending movies';
        log("Trending Movies Error", error: response.errorMessage);

        _loadMoviesFromHive();
      }
    } catch (e) {
      log("Error fetching trending movies", error: e);

      _loadMoviesFromHive();
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  void _loadMoviesFromHive() {
    final hiveMovies = _moviesBox.values.toList();
    if (hiveMovies.isNotEmpty) {
      trendingMovies.assignAll(hiveMovies);
    } else {
      _errorMessage = 'No offline data available';
    }
  }
}
