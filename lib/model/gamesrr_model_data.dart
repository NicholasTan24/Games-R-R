class Games{
  final String name;
  final String releaseDate;
  final String description;
  final String genre;
  final String requirements;
  final String imageAsset;
  final List<String> previewUrls;
  bool isFavorite;

  Games({
    required this.name,
    required this.releaseDate,
    required this.description,
    required this.genre,
    required this.requirements,
    required this.imageAsset,
    required this.previewUrls,
    this.isFavorite = false,
  });

}