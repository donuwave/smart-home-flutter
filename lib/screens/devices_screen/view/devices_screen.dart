import 'package:flutter/material.dart';
import 'package:smart_home/entities/device/service/device_response.dart';
import 'package:smart_home/entities/device/service/device_service.dart';
import 'package:mjpeg_stream/mjpeg_stream.dart';

class DevicesScreen extends StatefulWidget {
  final int deviceId;
  const DevicesScreen({super.key, required this.deviceId});

  @override
  State<DevicesScreen> createState() => DevicesStateScreen();
}

class DevicesStateScreen extends State<DevicesScreen> {
  late final Future<DeviceResponse> _futureDevice;

  @override
  void initState() {
    super.initState();
    _futureDevice = DeviceService().getDeviceById(widget.deviceId);
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      FutureBuilder<DeviceResponse>(
        future: _futureDevice,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Text('Ошибка: ${snap.error}');
          }
          final home = snap.data;
          if (home == null) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              MJPEGStreamScreen(
                streamUrl:
                    'http://10.0.2.2:8003/api/v1/stream/video_feed?device_id=${widget.deviceId}',
                width: double.infinity,
                height: 300.0,
                fit: BoxFit.cover,
                showLiveIcon: true,
              ),
            ],
          );
        },
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }
}
