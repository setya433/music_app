import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/audio_player_provider.dart';
import '../providers/favorite_provider.dart'; // Tambahkan ini

class PlayerScreen extends ConsumerStatefulWidget {
  final String title;
  final String artist;
  final String? imageUrl;
  final String audioUrl;
  final int songId; // Tambahkan jika belum

  const PlayerScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.audioUrl,
    required this.songId, // Tambahkan jika belum
  });

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(audioControllerProvider.notifier).load(widget.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(audioControllerProvider);
    final favoriteIdsAsync = ref.watch(favoriteSongIdsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Now Playing"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                  ? Image.network(
                      widget.imageUrl!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/no_cover.jpg',
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/no_cover.jpg',
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
            ),

            const SizedBox(height: 24),
            Text(widget.title,textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text(widget.artist, style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
            const SizedBox(height: 12),

            // ❤️ LOVE BUTTON
            favoriteIdsAsync.when(
              data: (ids) {
                final isFavorited = ids.contains(widget.songId);
                return IconButton(
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : AppColors.accent,
                  ),
                  tooltip: isFavorited ? 'Remove from Favorites' : 'Add to Favorites',
                  iconSize: 32,
                  onPressed: () async {
                    print('Toggle favorite for song ID: ${widget.songId}');
                    await toggleFavorite(widget.songId.toString(), ref);
                    ref.invalidate(favoriteSongIdsProvider);
                  },
                );
              },
              loading: () => const SizedBox(height: 32),
              error: (e, stack) {
                debugPrint('screen Error in favoriteSongIdsProvider: $e');
                debugPrint('pasti StackTrace: $stack');
                return const Icon(Icons.error, color: Colors.red);
              },            ),

            const SizedBox(height: 16),
            Slider(
              value: playerState.position.inSeconds.toDouble(),
              max: playerState.duration.inSeconds.toDouble() > 0 ? playerState.duration.inSeconds.toDouble() : 1,
              onChanged: (value) {
                ref.read(audioControllerProvider.notifier).seek(Duration(seconds: value.toInt()));
              },
              activeColor: AppColors.accent,
              inactiveColor: Colors.white24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: const Icon(Icons.skip_previous), onPressed: () {}, iconSize: 36),
                IconButton(
                  icon: Icon(playerState.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () async {
                      final notifier = ref.read(audioControllerProvider.notifier);

                      if (playerState.isPlaying) {
                        await notifier.pause();
                      } else {
                        await notifier.play();
                      }


                  },
                  iconSize: 48,
                ),
                IconButton(icon: const Icon(Icons.skip_next), onPressed: () {}, iconSize: 36),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
