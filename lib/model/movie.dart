final String tableMovie = 'movie';

class MovieFields {
  static final List<String> values = [
    /// Add all fields
    id, img, title, description, time
  ];

  static final String id = '_id';
  static final String img = 'img';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Movie {
  final int? id;
  final String img;
  final String title;
  final String director;
  final DateTime createdTime;

  const Movie({
    this.id,
    required this.img,
    required this.title,
    required this.director,
    required this.createdTime,
  });

  Movie copy({
    int? id,
    String? img,
    String? title,
    String? director,
    DateTime? createdTime,
  }) =>
      Movie(
        id: id ?? this.id,
        img: img ?? this.img,
        title: title ?? this.title,
        director: director ?? this.director,
        createdTime: createdTime ?? this.createdTime,
      );

  static Movie fromJson(Map<String, Object?> json) => Movie(
        id: json[MovieFields.id] as int?,
        img: json[MovieFields.img] as String,
        title: json[MovieFields.title] as String,
        director: json[MovieFields.description] as String,
        createdTime: DateTime.parse(json[MovieFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.img: img,
        MovieFields.title: title,
        MovieFields.description: director,
        MovieFields.time: createdTime.toIso8601String(),
      };
}
