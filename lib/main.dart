import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restauapp/screens/cart/cart_screen.dart';

// Providers
import 'providers/cart_provider.dart';
import 'providers/session_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/menu_categories_provider.dart';

// Auth Screens
import 'providers/user_settings_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
// Feature Screens
import 'screens/history/history_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/location/location_screen.dart';
import 'screens/map/map_route_screen.dart';
import 'screens/profile/profile_edit_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/restaurant/restaurant_details_screen.dart';
import 'screens/saved/saved_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/tracking/order_tracking_screen.dart';
import 'screens/welcome_screen.dart';
import '../services/chat_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const RestauApp());
}

class RestauApp extends StatelessWidget {
  const RestauApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => MenuCategoriesProvider()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => UserSettingsProvider()),
      ],
      child: MaterialApp(
        title: 'RestauApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: Colors.orange,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Colors.orange,
            secondary: Colors.orangeAccent,
            surface: Color(0xFF1E1E1E),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF1E1E1E),
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/location': (context) => LocationScreen(),
        '/cart': (context) => const CartScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/search': (context) => const SearchScreen(),
        '/restaurant-details': (context) => const RestaurantDetailsScreen(),
        '/map-route': (context) => MapRouteScreen(),
        '/saved': (context) => const SavedScreen(),
        '/order-tracking': (context) => OrderTrackingScreen(
          orderId: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/profile': (context) => const ProfileScreen(),
        '/profile/edit': (context) => const ProfileEditScreen(),
      },
      ),
    );
  }
}