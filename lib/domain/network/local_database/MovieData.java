import 'package:hive/hive.dart';

part 'movie_data.g.dart';

@HiveType(typeId: 0)
class MovieData {
    @HiveField(0)
    final String title;

    @HiveField(1)
    final String description;

    @HiveField(2)
    final String imageUrl;

    MovieData({
        required this.title,
                required this.description,
                required this.imageUrl,
    });
}
