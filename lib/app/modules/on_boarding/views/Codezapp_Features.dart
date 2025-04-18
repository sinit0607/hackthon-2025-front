import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/components/get_size.dart';

class CodezappFeatures extends StatelessWidget {
  const CodezappFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Why Choose CodesApp?",
              style: GoogleFonts.jost(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildFeatureCard(
                  icon: Icons.language,
                  title: "Content in Hindi & English",
                  description: "Learn in the language you're comfortable with.",
                ),
                _buildFeatureCard(
                  icon: Icons.school,
                  title: "India’s Best Creators",
                  description: "Learn from IITians, industry pros, and experienced developers.",
                ),
                _buildFeatureCard(
                  icon: Icons.timeline,
                  title: "Structured Learning Paths",
                  description: "Beginner to Advanced, step-by-step video playlists.",
                ),
                SizedBox(height: H.h2(context),),
                buildFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 12,
        children: const [
          Text(
            'About Us',
            style: TextStyle(color: Colors.white70),
          ),
          Text('|', style: TextStyle(color: Colors.white30)),
          Text(
            'Contact',
            style: TextStyle(color: Colors.white70),
          ),
          Text('|', style: TextStyle(color: Colors.white30)),
          Text(
            'Privacy Policy',
            style: TextStyle(color: Colors.white70),
          ),
          Text('|', style: TextStyle(color: Colors.white30)),
          Text(
            'Terms',
            style: TextStyle(color: Colors.white70),
          ),
          Text('|', style: TextStyle(color: Colors.white30)),
          Text(
            'Instagram',
            style: TextStyle(color: Colors.white70),
          ),
          Text('|', style: TextStyle(color: Colors.white30)),
          Text(
            'LinkedIn',
            style: TextStyle(color: Colors.white70),
          ),
          Text('|', style: TextStyle(color: Colors.white30)),
          Text(
            'YouTube',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

}
