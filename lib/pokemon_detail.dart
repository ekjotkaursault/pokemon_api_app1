// Importing the Flutter Material library for UI components
import 'package:flutter/material.dart';

// This screen shows the enlarged Pokémon card image
// It opens when the user taps on any card in the ListView
class PokemonDetailPage extends StatelessWidget {
  // These variables will store data received from the previous page
  final String name;       // Pokémon's name (for AppBar title)
  final String imageUrl;   // URL of the larger Pokémon image
  final String heroTag;    // Used for Hero animation effect

  // Constructor: requires name, imageUrl, and heroTag from main.dart
  const PokemonDetailPage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at the top showing Pokémon's name
      appBar: AppBar(
        title: Text(name), // Display the Pokémon name
        centerTitle: true, // Center the title in the AppBar
      ),

      // The main body of the screen
      body: Center(
        // InteractiveViewer allows pinch-zooming and panning of images
        child: InteractiveViewer(
          minScale: 0.8, // Minimum zoom-out level
          maxScale: 4.0, // Maximum zoom-in level
          child: Hero(
            // The Hero widget connects the small image from the list
            // to the larger image here with a smooth animation.
            tag: heroTag, 

            // Display the Pokémon card image from the provided URL
            child: Image.network(
              imageUrl,           // The URL of the large image
              fit: BoxFit.contain, // Keeps the image ratio
              loadingBuilder: (context, child, progress) {
                // Show a loading spinner while the image loads
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                // If the image fails to load, show an error icon
                return const Icon(Icons.error, size: 80, color: Colors.red);
              },
            ),
          ),
        ),
      ),
    );
  }
}
