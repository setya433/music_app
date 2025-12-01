import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_community_app/models/song.dart';
import 'package:music_community_app/providers/song_provider.dart';

final filteredSongsProvider = Provider<List<Song>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final songsAsync = ref.watch(songsProvider);

  return songsAsync.maybeWhen(
    data: (songs) {
      if (query.isEmpty) return songs;

      return songs.where((song) {
        return song.title.toLowerCase().contains(query) ||
               song.artist.toLowerCase().contains(query);
      }).toList();
    },
    orElse: () => [],
  );
});
