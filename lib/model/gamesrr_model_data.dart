class Games{
  final String name;
  final String releaseDate;
  final String description;
  final String genre;
  final String requirements;
  final String imageAsset;
  final List<String> preview;
  bool isFavorite;

  Games({
    required this.name,
    required this.releaseDate,
    required this.description,
    required this.genre,
    required this.requirements,
    required this.imageAsset,
    required this.preview,
    this.isFavorite = false,
  });
}

