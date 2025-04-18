// lib/modules/notifications/views/widgets/notification_tile.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:codesapp/app/data/components/app_color.dart';

import '../../../data/response_model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final bool isHighlighted;

  const NotificationTile({
    Key? key,
    required this.notification,
    required this.onTap,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBlack,
      child: ListTile(
        tileColor: AppColors.appBlack,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0
        ),
        leading: _buildLeadingAvatar(),
        title: _buildNotificationTitle(),
        subtitle: _buildSubtitle(),
        trailing: _buildTrailingContent(),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLeadingAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(notification.avatarUrl),
          backgroundColor: Colors.grey[200],
        ),
        // Conditional unread indicator
        if (!notification.isRead.value)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNotificationTitle() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.jost(
          color: AppColors.appWhite,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: notification.username,
            style: GoogleFonts.jost(
              color: AppColors.appWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' ${notification.action}',
            style: GoogleFonts.jost(
              color: AppColors.appWhite,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      notification.timestamp,
      style: GoogleFonts.jost(
        color: AppColors.appWhite,
        fontSize: 12,
      ),
    );
  }

  Widget? _buildTrailingContent() {
    // If post image exists, show the image
    if (notification.postImageUrl != null) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(notification.postImageUrl!),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      );
    }

    // For follow requests or other notification types without an image
    switch (notification.type) {
      case NotificationType.followRequest:
        return _buildActionButtons();
      default:
        return null;
    }
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Confirm button
        ElevatedButton(
          onPressed: () {
            // Handle follow request confirmation
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.appWhite,
            minimumSize: Size(70, 30),
          ),
          child: Text(
            'Confirm',
            style: GoogleFonts.jost(
              fontSize: 12,
              color: AppColors.appBlack,
            ),
          ),
        ),
        SizedBox(width: 8),
        // Delete button
        OutlinedButton(
          onPressed: () {
            // Handle follow request deletion
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size(70, 30),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          child: Text(
            'Delete',
            style: GoogleFonts.jost(
              fontSize: 12,
              color: AppColors.appWhite,
            ),
          ),
        ),
      ],
    );
  }
}