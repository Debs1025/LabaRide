import 'package:flutter/material.dart';

class CustomerRatingsScreen extends StatelessWidget {
  const CustomerRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/backarrow.png', // Back arrow asset
            height: 24,
            width: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Customer Ratings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 36, 26, 71), // Dark purple color
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Star Filter Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterStar(icon: 'assets/images/star.png'), // 1-star filter
                FilterStar(icon: 'assets/images/star.png'), // 2-star filter
                FilterStar(icon: 'assets/images/star.png'), // 3-star filter
                FilterStar(icon: 'assets/images/star.png'), // 4-star filter
                FilterStar(icon: 'assets/images/star.png'), // 5-star filter
              ],
            ),
            SizedBox(height: 16.0),

            // Customer Ratings List
            Expanded(
              child: ListView(
                children: [
                  RatingCard(
                    name: 'Erick De Belen',
                    variation: 'Wash Only',
                    comment: 'The quality of the wash is very good but takes time to be delivered <3',
                    stars: 'assets/images/4stars.png', // 4-star rating
                  ),
                  RatingCard(
                    name: 'Nathaniel Delfino',
                    variation: 'Full Service',
                    comment: 'Good quality pero masyadong matagal dumating and very rude yung manong rider',
                    stars: 'assets/images/3stars.png', // 3-star rating
                  ),
                  RatingCard(
                    name: 'Carl Valenciano',
                    variation: 'Full Service',
                    comment: 'ANG BANGO NAMAN NG PAGKALABA SUPER BILIS DIN NG DELIVERY THE BEST WILL ORDER AGAIN',
                    stars: 'assets/images/5stars.png', // 5-star rating
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterStar extends StatelessWidget {
  final String icon;

  const FilterStar({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEDE7F6), // Light purple background
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Image.asset(
        icon,
        height: 24,
        width: 24,
      ),
    );
  }
}

class RatingCard extends StatelessWidget {
  final String name;
  final String variation;
  final String comment;
  final String stars;

  const RatingCard({super.key, 
    required this.name,
    required this.variation,
    required this.comment,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5), // Light purple background
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Stars Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 36, 26, 71),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    stars,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 4.0),
                  Image.asset(
                    stars,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 4.0),
                  Image.asset(
                    stars,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 4.0),
                  Image.asset(
                    stars,
                    height: 20,
                    width: 20,
                  ),
                  if (stars == 'assets/images/5stars.png') // Add 5th star if applicable
                    SizedBox(width: 4.0),
                  if (stars == 'assets/images/5stars.png')
                    Image.asset(
                      stars,
                      height: 20,
                      width: 20,
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),

          // Variation
          Text(
            'Variation: $variation',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.0),

          // Comment
          Text(
            'Comment: $comment',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}