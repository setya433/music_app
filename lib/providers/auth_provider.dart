import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider((ref) {
  return Supabase.instance.client;
});

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return AuthRepository(ref.read(supabaseProvider));
});

class AuthRepository{
  final SupabaseClient supabase;
  AuthRepository(this.supabase);

  Future<void> signIn(String email,String passsword) async{
    await supabase.auth.signInWithPassword(
      email: email,
      password: passsword,
    );
  }

  Future<void> signUp(String email, String password,String fullname) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
      data : {'fullname' : fullname},
      );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;
  }

  final authStateProvider = StreamProvider<AuthState>((ref) {
    final supabase = ref.read(supabaseProvider);
    return supabase.auth.onAuthStateChange;
  });

