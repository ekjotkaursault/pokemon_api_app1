// Importing required Dart and Flutter packages
import 'dart:convert';                     // For decoding JSON data
import 'package:flutter/material.dart';    // Flutter UI toolkit
import 'package:http/http.dart' as http;   // HTTP package for API requests
import 'pokemon_detail.dart';              // Importing the second page (details page)

// Entry point of the application
void main() {
  runApp(const PokemonApp());              // Runs the root widget
}

// Root widget of the app (Stateless — it doesn't change dynamically)
class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp provides app-level configuration
    return MaterialApp(
      title: 'Pokémon Cards',                // Title shown in app bar and taskbar
      debugShowCheckedModeBanner: false,     // Hides the debug banner
      theme: ThemeData(
        useMaterial3: true,                  // Enables Material Design 3 style
        colorSchemeSeed: Colors.blue,        // App-wide theme color
      ),
      home: const PokemonListPage(),         // The first screen of the app
    );
  }
}

// Main screen that displays the list of Pokémon cards
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

// State class where all logic and UI updates happen
class _PokemonListPageState extends State<PokemonListPage> {
  // Variables to store API data, loading state, and error messages
  List<dynamic> _cards = [];   // Stores Pokémon cards fetched from API
  bool _loading = true;        // Shows loading spinner initially
  String? _error;              // Stores any network or decoding error

  // initState() runs once when the screen is first loaded
  @override
  void initState() {
    super.initState();
    _fetchCards();             // Calls the function to get Pokémon data
  }

  // Function to fetch Pokémon card data from the API
  Future<void> _fetchCards() async {
    try {
      // API endpoint (fetches 30 Pokémon cards)
      final url = Uri.parse('https://api.pokemontcg.io/v2/cards?pageSize=30');

      // Send a GET request to the API
      final res = await http.get(url);

      // If the server response is OK (status 200)
      if (res.statusCode == 200) {
        final body = json.decode(res.body);         // Decode JSON data
        setState(() {
          _cards = body['data'] as List<dynamic>;   // Store the list of cards
          _loading = false;                         // Hide the loader
        });
      } else {
        // If server gives any error code (e.g., 404, 500)
        setState(() {
          _error = 'Failed to load data (${res.statusCode})';
          _loading = false;
        });
      }
    } catch (e) {
      // Catch network or JSON errors
      setState(() {
        _error = 'Network error: $e';
        _loading = false;
      });
    }
  }

  // Builds the visible UI of the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar at the top of the screen
     //  Gradient AppBar
appBar: AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF4FACFE), // light sky blue
          Color(0xFF00F2FE)  // teal blue
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
  title: const Text(
    'Pokémon Cards',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  ),
  centerTitle: true,
),


      // Main body with gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFF42A5F5)], // Light to dark blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        // Different UI states:
        child: _loading
            // 1️⃣ If data is loading, show a circular progress bar
            ? const Center(child: CircularProgressIndicator())

            // 2️⃣ If an error occurred, display the message
            : (_error != null)
                ? Center(
                    child: Text(
                      _error!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )

                // 3️⃣ Otherwise, display the list of Pokémon cards
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _cards.length,
                    itemBuilder: (context, i) {
                      final card = _cards[i];               // Get one card at a time
                      final name = card['name'] ?? 'Unknown'; // Pokémon name
                      final small = card['images']?['small']; // Small image
                      final large = card['images']?['large'] ?? small; // Large image

                      // Create a nice Card widget for each Pokémon
                      return Card(
                        elevation: 3,                        // Shadow effect
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),

                          // Small image shown on the left
                          leading: small != null
                              ? Hero(
                                  tag: 'hero_$i', // Used for animation when opening details
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      small,                   // Image URL
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const SizedBox(width: 56, height: 56),

                          // Pokémon name text
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),

                          // Small arrow icon at right
                          trailing: const Icon(Icons.chevron_right),

                          // When the user taps a card → navigate to detail page
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PokemonDetailPage(
                                  name: name,
                                  imageUrl: large,
                                  heroTag: 'hero_$i', // For animation
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
