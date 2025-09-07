import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nilecare_flutter/models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    this.onTap,
    this.onCancel,
    this.onReschedule,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (appointment.status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    switch (appointment.status) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getStatusText(),
                      style: TextStyle(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(appointment.dateTime),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('hh:mm a').format(appointment.dateTime),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.video_camera_front,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    appointment.type.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              if (appointment.notes != null) ...[
                const SizedBox(height: 8),
                Text(
                  appointment.notes!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appointment.currency} ${appointment.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (appointment.status == 'pending') ...[
                    Row(
                      children: [
                        TextButton(
                          onPressed: onReschedule,
                          child: const Text('Reschedule'),
                        ),
                        TextButton(
                          onPressed: onCancel,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
