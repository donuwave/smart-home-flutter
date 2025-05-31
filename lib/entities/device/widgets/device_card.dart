import 'package:flutter/material.dart';
import 'package:smart_home/entities/device/service/device_response.dart';

class DeviceCard extends StatelessWidget {
  final DeviceResponse device;
  final void Function()? onTap;

  const DeviceCard({Key? key, required this.device, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: const Color(0xFF2C2F33),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _iconForType(device.deviceType),
                size: 28,
                color: theme.primaryColor,
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Название: ${device.name}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Модель: ${device.model}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type.toLowerCase()) {
      case 'camera':
        return Icons.videocam;
      case 'thermostat':
        return Icons.thermostat;
      case 'light':
        return Icons.lightbulb;
      default:
        return Icons.devices_other;
    }
  }
}
