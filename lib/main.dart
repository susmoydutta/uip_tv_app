import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:uip_tv_app/domain/models/movie_data.dart';
import 'package:uip_tv_app/domain/network/local_database/movie_data_adapter.dart';
import 'package:uip_tv_app/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MovieDataAdapter());

  await Hive.openBox<MovieData>('moviesBox');
  await Hive.openBox('userBox');

  runApp(App());
}






