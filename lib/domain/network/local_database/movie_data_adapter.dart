import 'package:hive/hive.dart';
import 'package:uip_tv_app/domain/models/movie_data.dart';

class MovieDataAdapter extends TypeAdapter<MovieData> {
  @override
  final int typeId = 0;

  @override
  MovieData read(BinaryReader reader) {
    return MovieData(
      title: reader.read(),
      description: reader.read(),  // Corrected
      imageUrl: reader.read(),      // Corrected
    );
  }

  @override
  void write(BinaryWriter writer, MovieData obj) {
    writer.write(obj.title);
    writer.write(obj.thumbnailUrl);  // Corrected
    writer.write(obj.url);     // Corrected
  }
}
