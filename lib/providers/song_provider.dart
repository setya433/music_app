import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/song.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');


final songsProvider = FutureProvider<List<Song>>((ref) async {
  final response = await Supabase.instance.client
      .from('songs')
      .select()
      .order('created_at', ascending: false);

  final data = response as List;

  debugPrint('✅ Data berhasil diambil dari Supabase: ${data.length} item');

return data.map((song) => Song.fromJson(song)).toList();});
