// lib/modules/notifications/views/widgets/follow_requests_tile.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:codesapp/app/data/components/custom_text.dart';

import '../../../data/components/app_color.dart';

class FollowRequestsTile extends StatelessWidget {
  final VoidCallback onTap;

  const FollowRequestsTile({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeadingAvatar(),
      title: Text(
        'Follow requests',
        style: GoogleFonts.jost(
          fontWeight: FontWeight.bold,
          color: AppColors.appWhite,
        ),
      ),
      subtitle: CommonText(text: 'vivesh_jain + 101 others',textAlign: TextAlign.start,),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLeadingAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
