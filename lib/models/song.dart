class Song {
  final int id;
  final String title;
  final String artist;
  final String? imageUrl;
  final String audioUrl;
  final DateTime createdAt;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.audioUrl,
    required this.createdAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      imageUrl: json['image_url'] ?? '',
      audioUrl: json['audio_url'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
