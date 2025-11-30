import 'package:flutter/material.dart';
class CategoryCard extends StatelessWidget {
  final dynamic item; 
  final bool isEven;
  final Function(String) onTap;

  const CategoryCard({
    required this.item,
    required this.isEven,
    required this.onTap,
    super.key,
  });

  Widget _buildViewAllButton(String title) {
    return ElevatedButton(
      onPressed: () => onTap(title),
      child: Text("View All"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Material(
            elevation: 5,
         borderRadius: BorderRadius.circular(16),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment:
                    isEven ? Alignment.bottomRight : Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment:
                      isEven ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isEven) _buildViewAllButton(item.title.toLowerCase()),
                    if (!isEven) const SizedBox(width: 12),
                    if (isEven) const SizedBox(width: 12),
                    if (isEven) _buildViewAllButton(item.title.toLowerCase()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
