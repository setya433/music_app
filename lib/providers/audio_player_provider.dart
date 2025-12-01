import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(() => player.dispose());
  return player;
});

final audioControllerProvider = StateNotifierProvider<AudioController, PlayerState>(
  (ref) => AudioController(ref),
);

class PlayerState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  PlayerState({
    required this.isPlaying,
    required this.position,
    required this.duration,
  });

  PlayerState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) {
    return PlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  static PlayerState initial() => PlayerState(
        isPlaying: false,
        position: Duration.zero,
        duration: Duration.zero,
      );
}

class AudioController extends StateNotifier<PlayerState> {
  final Ref ref;

  AudioController(this.ref) : super(PlayerState.initial());

  Future<void> load(String url) async {
  final player = ref.read(audioPlayerProvider);
  String safeUrl = url.replaceAll('//', '/').replaceFirst(':/', '://');

  print("🎧 Try to load: $safeUrl");

  try {
    await player.setUrl(safeUrl); // Sumber utama error
    await player.seek(Duration.zero);
    print("✅ Audio loaded successfully");

    // Dengarkan perubahan posisi
    player.positionStream.listen((pos) {
      state = state.copyWith(position: pos);
    });

    // Dengarkan durasi lagu
    player.durationStream.listen((dur) {
      if (dur != null) {
        state = state.copyWith(duration: dur);
      }
    });

    // Dengarkan status playing
    player.playingStream.listen((isPlaying) {
      state = state.copyWith(isPlaying: isPlaying);
    });

  } catch (e, stack) {
    print("❌ Gagal memuat audio:");
    print("Error: $e");
    print("Stacktrace: $stack");
  }
}


  Future<void> play() async {
    final player = ref.read(audioPlayerProvider);
    await player.play();
    state = state.copyWith(isPlaying: true);
  }

  Future<void> pause() async {
    final player = ref.read(audioPlayerProvider);
    await player.pause();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> seek(Duration position) async {
    final player = ref.read(audioPlayerProvider);
    await player.seek(position);
  }
}
