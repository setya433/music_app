import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_community_app/providers/favorite_provider.dart';
import 'package:music_community_app/providers/song_provider.dart';
import 'package:music_community_app/widgets/string_extensions.dart';
import '../theme/app_theme.dart';
import 'player_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(songsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildAppBar(),
            const SizedBox(height: 20),
            _buildSectionTitle('New Releases'),
            const SizedBox(height: 10),
            _buildTrendingList(ref),
            const SizedBox(height: 30),
            _buildSectionTitle('All Songs'),
            const SizedBox(height: 10),
            _buildRecommendedList(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'WENOIZE',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: AppColors.accent),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTrendingList(WidgetRef ref) {
  final songsAsync = ref.watch(songsProvider);

  return songsAsync.when(
    data: (songs) {
      final latestSongs = songs.take(5).toList(); // Ambil 5 lagu terbaru
      return SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: latestSongs.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final song = latestSongs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlayerScreen(
                      title: song.title,
                      artist: song.artist,
                      imageUrl: song.imageUrl ?? '',
                      audioUrl: song.audioUrl,
                      songId: song.id.toInt(),
                    ),
                  ),
                );
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: song.imageUrl != null
                            ? Image.network(
                                song.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/no_cover.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/no_cover.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        textAlign:  TextAlign.center,
                        song.title.toTitleCase(),
                        style: const TextStyle(color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (e, _) => Center(child: Text('Error: $e')),
  );
}


  Widget _buildRecommendedList(BuildContext context, WidgetRef ref) {
  final songsAsync = ref.watch(songsProvider);

  return songsAsync.when(
    data: (songs) {
      print('✅ Data berhasil diambil dari Supabase: ${songs.length} item');
      return Column(
        children: songs.map((song) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerScreen(
                    title: song.title,
                    artist: song.artist,
                    imageUrl: song.imageUrl ?? '',
                    audioUrl: song.audioUrl,
                    songId: song.id.toInt(),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:  song.imageUrl != null
                        ? Image.network(
                            song.imageUrl ?? '',
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
                        : 
                    Image.network(
                      song.imageUrl ?? '',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          song.title.toTitleCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                      song.artist.toTitleCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                      ],
                    ),
                    
                  ),
                  Consumer(
  builder: (context, ref, _) {
    final favoriteIdsAsync = ref.watch(favoriteSongIdsProvider);

    return favoriteIdsAsync.when(
      data: (ids) {
        final isFavorited = ids.contains(song.id);

        return IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : AppColors.accent,
          ),
          tooltip: isFavorited ? "Unfavorite" : "Add to Favorite",
          onPressed: () async {
             print('🟡 Tombol love ditekan');
            await toggleFavorite(song.id.toString(), ref); // Fungsi toggle
            ref.invalidate(favoriteSongIdsProvider); // Refresh state
          },
        );
      },
      loading: () => const SizedBox.shrink(),
error: (e, stack) {
        debugPrint('Error in favoriteSongIdsProvider: $e');
        debugPrint('StackTrace: $stack');
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  },
),


                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: AppColors.accent),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlayerScreen(
                            title: song.title,
                            artist: song.artist,
                            imageUrl: song.imageUrl ?? '',
                            audioUrl: song.audioUrl,
                            songId: song.id.toInt(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, _) => Center(child: Text('Error: $error')),
  );
}
}