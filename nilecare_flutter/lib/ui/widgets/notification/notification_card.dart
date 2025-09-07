import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nilecare_flutter/models/notification.dart' as models;

class NotificationCard extends StatelessWidget {
  final models.Notification notification;
  final VoidCallback? onTap;

  const NotificationCard({
    Key? key,
    required this.notification,
    this.onTap,
  }) : super(key: key);

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case 'appointment':
        return Icons.calendar_today;
      case 'payment':
        return Icons.payment;
      case 'message':
        return Icons.message;
      case 'system':
        return Icons.notifications;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(BuildContext context) {
    switch (notification.type) {
      case 'appointment':
        return Colors.blue;
      case 'payment':
        return Colors.green;
      case 'message':
        return Colors.purple;
      case 'system':
        return Colors.orange;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getNotificationColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getNotificationIcon(),
                  color: _getNotificationColor(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy • hh:mm a')
                          .format(notification.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
