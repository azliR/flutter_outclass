import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:outclass/views/core/app_router.gr.dart';

@RoutePage()
class ScanPage extends StatelessWidget {
  ScanPage({super.key});

  final cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32,
            onPressed: cameraController.toggleTorch,
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32,
            onPressed: cameraController.switchCamera,
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          final value = barcode.rawValue ?? '';
          final url = Uri.parse(value);
          final pathNames = [...url.pathSegments];
          if ((url.host == 'localhost:5173' ||
                  url.host == 'outclass.azlir.my.id') &&
              pathNames.length == 2 &&
              pathNames[0] == 'join') {
            context.router
                .push(JoinInsertStudentIdRoute(classCode: pathNames[1]));
          }
        },
      ),
    );
  }
}
