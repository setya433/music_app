import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/song.dart';
import 'song_provider.dart';

final favoritesProvider = FutureProvider<List<Song>>((ref) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return [];

  final response = await Supabase.instance.client
      .from('favorites')
      .select('song_id, songs(*)') // Join dengan songs
      .eq('user_id', user.id);

  final data = response as List;

  // Pastikan relasi songs() sudah di-setup di Supabase
  return data.map((e) => Song.fromJson(e['songs'])).toList();
});

final favoriteSongIdsProvider = FutureProvider<List<int>>((ref) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) {
    print('⚠️ User not logged in');
    return [];
  }

  final data = await Supabase.instance.client
      .from('favorites')
      .select('song_id')
      .eq('user_id', user.id);

  print('📥 Favorite IDs raw: $data');

  return (data as List).map((e) => e['song_id'] as int).toList();
});




Future<void> toggleFavorite(String songId, WidgetRef ref) async {  
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) return;

    print('toggleFavorite -> user_id: ${user.id} (${user.id.runtimeType}), song_id: $songId (${songId.runtimeType})');


  final existing = await supabase
      .from('favorites')
      .select()
      .eq('user_id', user.id)
      .eq('song_id', songId)
      .maybeSingle();

  if (existing != null) {
    await supabase.from('favorites').delete().eq('id', existing['id']);
  } else {
    await supabase.from('favorites').insert({
      'user_id': user.id,
      'song_id': songId,
    });

  
  
  // ✅ Refresh data favorit
  ref.invalidate(favoritesProvider);
  ref.invalidate(favoriteSongIdsProvider);
  
    
  }
}
