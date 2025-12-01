import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_community_app/providers/search_song.dart';
import '../providers/song_provider.dart';
import '../theme/app_theme.dart';
import 'player_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final songs = ref.watch(filteredSongsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Songs'),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(songsProvider); // ⬅️ force refresh dari Supabase
        },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                  hintText: 'Search by title or artist...',
                  hintStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              ),
              const SizedBox(height: 20),
              if (songs.isEmpty && query.isNotEmpty)
                const Text('No results found.', style: TextStyle(color: AppColors.textSecondary)),
              if (songs.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: (song.imageUrl != null && song.imageUrl!.isNotEmpty)
                              ? Image.network(
                                  song.imageUrl!,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/no_cover.jpg',
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/no_cover.jpg',
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                ),
                        ),

                        title: Text(song.title, style: const TextStyle(color: AppColors.textPrimary)),
                        subtitle: Text(song.artist, style: const TextStyle(color: AppColors.textSecondary)),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_arrow, color: AppColors.accent),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlayerScreen(
                                  title: song.title,
                                  artist: song.artist,
                                  imageUrl: song.imageUrl  ?? '',
                                  audioUrl: song.audioUrl,
                                  songId: song.id.toInt(),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
