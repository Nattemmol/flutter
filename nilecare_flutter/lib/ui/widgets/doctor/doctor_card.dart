import 'package:flutter/material.dart';
import 'package:nilecare_flutter/models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap;
  final bool showRating;
  final bool showSpecialty;
  final bool showAvailability;

  const DoctorCard({
    Key? key,
    required this.doctor,
    this.onTap,
    this.showRating = true,
    this.showSpecialty = true,
    this.showAvailability = true,
  }) : super(key: key);

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
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: doctor.profileImage != null
                        ? NetworkImage(doctor.profileImage!)
                        : null,
                    child: doctor.profileImage == null
                        ? Text(
                            doctor.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${doctor.name}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (showSpecialty) ...[
                          const SizedBox(height: 4),
                          Text(
                            doctor.specialization,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                        if (showRating) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                doctor.rating?.toStringAsFixed(1) ?? '0.0',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${doctor.reviewCount})',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (showAvailability) ...[
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
                      'Available Today',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
