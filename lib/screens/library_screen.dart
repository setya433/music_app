import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_provider.dart';
import '../theme/app_theme.dart';
import 'player_screen.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Library"),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: favoritesAsync.when(
        data: (songs) {
          if (songs.isEmpty) {
            return const Center(
              child: Text("No favorites yet", style: TextStyle(color: AppColors.textSecondary)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return ListTile(
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
                          imageUrl: song.imageUrl  ?? '', // Pastikan imageUrl ada di model Song
                          audioUrl: song.audioUrl,
                          songId: song.id.toInt(), // Pastikan song.id ada di model Song
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
