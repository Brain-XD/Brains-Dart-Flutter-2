import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  Color _getTypeColor(String type) {
    final colors = {
      'normal': Colors.brown,
      'fire': Colors.red,
      'water': Colors.blue,
      'electric': Colors.yellow,
      'grass': Colors.green,
      'ice': Colors.cyan,
      'fighting': Colors.orange,
      'poison': Colors.purple,
      'ground': Colors.amber,
      'flying': Colors.indigo,
      'psychic': Colors.pink,
      'bug': Colors.lightGreen,
      'rock': Colors.grey,
      'ghost': Colors.deepPurple,
      'dragon': Colors.indigo,
      'dark': Colors.brown,
      'steel': Colors.blueGrey,
      'fairy': Colors.pink,
    };

    return colors[type] ?? Colors.grey!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with ID and Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.formattedId,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ), // TextStyle
                  ), // Text
                  Text(
                    pokemon.capitalizedName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // TextStyle
                  ), // Text
                ],
              ), // Row
            
              const SizedBox(height: 16),

              // Pokémon Image
              Center(
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  height: 100,
                  width: 100,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ), // CachedNetworkImage
              ), // Center

              const SizedBox(height: 16),

              // Types
              Wrap(
                spacing: 8,
                children: pokemon.types.map((type) {
                  return Chip(
                    label: Text(
                      type.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ), // TextStyle
                    ), // Text
                    backgroundColor: _getTypeColor(type),
                  ); // Chip
                }).toList(),
              ), // Wrap

              const SizedBox(height: 8),

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Height', '${pokemon.height / 10}m'),
                  _buildStat('Weight', '${pokemon.weight / 10}kg'),
                ],
              ), // Row
            ],
          ), // Column
        ), // Padding
      ), // InkWell
    ); // Card
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ), // TextStyle
        ), // Text
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ), // TextStyle
        ), // Text
      ],
    ); // Column
  }
}