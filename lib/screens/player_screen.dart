import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.textPrimary),
        centerTitle: true,
        title: const Text(
          "Now Playing",
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Cover Album
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images_album/slayer_2.jpg',
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Title & Artist
            const Text(
              "Song Title",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Artist Name",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),

            // Slider
            Slider(
              value: 30,
              min: 0,
              max: 100,
              activeColor: AppColors.accent,
              onChanged: (value) {},
            ),

            // Duration (current / total)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("01:15", style: TextStyle(color: AppColors.textSecondary)),
                Text("03:45", style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),

            const SizedBox(height: 32),

            // Player Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous_rounded, size: 40),
                  color: AppColors.accent,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow_rounded, size: 40),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded, size: 40),
                  color: AppColors.accent,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
