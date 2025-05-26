  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'theme/app_theme.dart';
  import 'screens/main_navigation.dart';
  import 'screens/splash_screen.dart';
  import 'providers/theme_provider.dart';
  import 'screens/signin_screen.dart';
  import 'screens/signup_screen.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';
  void main() async{
  //runApp(const ProviderScope(child: MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://arlrrptltjlbihsyehjv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFybHJycHRsdGpsYmloc3llaGp2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5ODU0NDUsImV4cCI6MjA2MzU2MTQ0NX0.ta0DmWvM1s4TNx3BsdSnfV12xs6OGNFzQJA05n9oftE',
    );
    runApp(const ProviderScope(child: MyApp()));
    }

  class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'WENOIZE',
      //theme: ThemeData.light(),    
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      // themeMode: themeMode,          
      debugShowCheckedModeBanner: false,
      //home: const SplashScreen(),   
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainNavigation(),
        '/signin': (context) =>  SignInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        // Add other routes here
      }, 
    );
  }
}
